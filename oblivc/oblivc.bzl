load(
    "@rules_foreign_cc//tools/build_defs:cc_toolchain_util.bzl",
    "get_env_vars",
    "get_flags_info",
    "get_tools_info",
)

def _oblivc_objects_impl(ctx):
    srcs = depset(ctx.files.srcs)
    hdrs = depset(
        direct = ctx.files.hdrs,
        transitive = [
                         dep.cc.transitive_headers
                         for dep in ctx.attr.deps
                         if hasattr(dep, "cc")
                     ] + [
                         dep[CcInfo].compilation_context.headers
                         for dep in ctx.attr.deps
                         if CcInfo in dep
                     ] +
                     [depset(ctx.files._oblivc_headers)],
    )

    # Include execroot
    includes = ["-I."]

    # Include Obliv-C directory.
    includes += ["-I" + ctx.files._oblivc_headers[0].dirname]

    # Include directories of dependencies.
    include_dirs = depset()
    for dep in ctx.attr.deps:
        if hasattr(dep, "cc"):
            # Add directory for individual header files. This adds quite a lot
            # of directories to the include paths, but it is currently needed to
            # compile some Obliv-C targets such as libACK.
            for hdr in dep.cc.transitive_headers:
                include_dirs = depset([hdr.dirname], transitive = [include_dirs])

        # New Starlark API. See https://github.com/bazelbuild/bazel/issues/7036
        if CcInfo in dep:
            include_dirs = depset(dep[CcInfo].compilation_context.system_includes.to_list(), transitive = [include_dirs])
            include_dirs = depset(dep[CcInfo].compilation_context.includes.to_list(), transitive = [include_dirs])
            for hdr in dep[CcInfo].compilation_context.headers.to_list():
                include_dirs = depset([hdr.dirname], transitive = [include_dirs])

    includes += ["-I" + dir for dir in include_dirs.to_list()]
    flags = includes

    # Get C compiler flags from CC toolchain info and copts.
    flags += get_flags_info(ctx).cc
    flags += ctx.fragments.cpp.copts
    flags += ctx.host_fragments.cpp.copts
    flags += ctx.attr.copts

    # Needed for shared library support. Not sure why this doesn't get
    # included in toolchain_flags.
    flags += ["-fPIC"]

    # Obliv-C produces lots of unused variables, communicating them to the
    # user doesn't help much.
    flags += ["-Wno-unused-variable"]

    # Workaround for https://github.com/samee/obliv-c/issues/48
    flags += ["-D_Float128=double"]

    # Set environment from toolchain, including C compiler
    env = get_env_vars(ctx)
    env["CC"] = get_tools_info(ctx).cc

    # We compile each file separately and return the outputs as a depset.
    outputs = []
    for src in srcs.to_list():
        output_file = ctx.actions.declare_file(src.path + ".o")

        args = flags + ["-c", src.path, "-o", output_file.path]

        ctx.actions.run(
            inputs = depset(transitive = [depset([src]), hdrs]),
            outputs = [output_file],
            arguments = args,
            progress_message = "Compiling {} using Obliv-C".format(
                src.path,
            ),
            executable = ctx.executable._compiler,
            use_default_shell_env = True,
            env = env,
            tools = ctx.files._compiler_lib,
        )
        outputs += [output_file]

    return [DefaultInfo(files = depset(outputs))]

oblivc_objects = rule(
    implementation = _oblivc_objects_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "hdrs": attr.label_list(allow_files = True),
        "deps": attr.label_list(allow_files = False),
        "copts": attr.string_list(),
        "_compiler": attr.label(
            default = "@oblivc//:bin/oblivcc",
            allow_files = True,
            cfg = "host",
            executable = True,
        ),
        "_compiler_lib": attr.label(
            default = "@oblivc//:_compile",
            allow_files = True,
            cfg = "host",
        ),
        "_oblivc_headers": attr.label(
            default = "@oblivc//:runtime_headers",
            allow_files = True,
            cfg = "host",
        ),
        # We need to declare this attribute to access cc_toolchain.
        "_cc_toolchain": attr.label(
            default = Label("@bazel_tools//tools/cpp:current_cc_toolchain"),
        ),
    },
    fragments = ["cpp"],
    host_fragments = ["cpp"],
)

def oblivc_library(
        name,
        srcs = [],
        hdrs = [],
        deps = [],
        copts = [],
        runtime = True,
        **kwargs):
    if runtime:
        deps_with_runtime = deps + ["@oblivc//:runtime"]
    else:
        deps_with_runtime = deps
    oblivc_objects(
        name = "_oblivc_" + name,
        srcs = srcs,
        hdrs = hdrs,
        deps = deps_with_runtime,
        copts = copts,
    )
    native.cc_library(
        name = name,
        srcs = ["_oblivc_" + name],
        hdrs = hdrs,
        deps = deps_with_runtime,
        copts = copts,
        linkstatic = 1,
        **kwargs
    )
