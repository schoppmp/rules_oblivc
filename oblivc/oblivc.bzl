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
                include_dirs += depset([hdr.dirname])

        # New Starlark API. See https://github.com/bazelbuild/bazel/issues/7036
        if CcInfo in dep:
            include_dirs += dep[CcInfo].compilation_context.system_includes

    includes += ["-I" + dir for dir in include_dirs]

    outputs = []

    for src in srcs:
        output_file = ctx.actions.declare_file(src.path + ".o")

        # We have to include the Obliv-C runtime headers here.
        args = ["-c", src.path, "-o", output_file.path]
        args += includes
        args += ctx.fragments.cpp.copts
        args += ctx.host_fragments.cpp.copts
        args += ctx.attr.copts

        # Add C compiler flags from CC toolchain info.
        args += get_flags_info(ctx).cc

        # Needed for shared library support. Not sure why this doesn't get
        # included in the flags above.
        args += ["-fPIC"]

        # Obliv-C produces lots of unused variables, communicating them to the
        # user doesn't help much.
        args += ["-Wno-unused-variable"]

        # Workaround for https://github.com/samee/obliv-c/issues/48
        args += ["-D_Float128=double"]

        # Set environment from toolchain, including CC compiler
        env = get_env_vars(ctx)
        env["CC"] = get_tools_info(ctx).cc

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
        **kwargs
    )
