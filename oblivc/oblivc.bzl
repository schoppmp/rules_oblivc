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
        output_file = ctx.actions.declare_file(src.basename + ".o")

        # We have to include the Obliv-C runtime headers here.
        args = ["-c", src.path, "-o", output_file.path]
        args += includes
        args += ctx.fragments.cpp.copts
        args += ctx.host_fragments.cpp.copts
        args += ctx.attr.copts

        # TODO: Read flags from CC toolchain
        args += ["-fPIC"]

        # Workaround for https://github.com/samee/obliv-c/issues/48
        args += ["-D_Float128=double"]

        ctx.actions.run(
            inputs = depset(transitive = [depset([src]), hdrs]),
            outputs = [output_file],
            arguments = args,
            progress_message = "Compiling {} using Obliv-C".format(
                src.path,
            ),
            executable = ctx.executable._compiler,
            use_default_shell_env = True,
            # execution_requirements = {
            #     "local": "1",
            # },
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
