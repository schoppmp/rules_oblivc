def _oblivc_object_impl(ctx):
    srcs = depset(ctx.files.srcs)
    src_paths = [f.path for f in srcs]

    hdrs = depset(
        direct = ctx.files.hdrs,
        transitive = [
            dep.cc.transitive_headers
            for dep in ctx.attr.deps
            if hasattr(dep, "cc")
        ] + [depset(ctx.files._oblivc_headers)],
    )

    # We have to include the Obliv-C runtime headers here.
    args = ["-I" + ctx.files._oblivc_headers[0].dirname]
    args += ["-c"] + src_paths + ["-o", ctx.outputs.obj.path]
    args += ctx.fragments.cpp.copts
    args += ctx.host_fragments.cpp.copts
    args += ctx.attr.copts

    # Include directories of dependencies
    include_dirs = depset()
    for dep in ctx.attr.deps:
        if hasattr(dep, "cc"):
            for hdr in dep.cc.transitive_headers:
                include_dirs += depset([hdr.dirname])
    args += ["-I" + dir for dir in include_dirs]

    # TODO: Read flags from CC toolchain
    args += ["-fPIC"]

    # Workaround for https://github.com/samee/obliv-c/issues/48
    args += ["-D_Float128=double"]

    ctx.actions.run(
        inputs = depset(transitive = [srcs, hdrs]),
        outputs = [ctx.outputs.obj],
        arguments = args,
        progress_message = "Compiling {} using Obliv-C".format(
            ctx.outputs.obj.path,
        ),
        executable = ctx.executable._compiler,
        use_default_shell_env = True,
        # execution_requirements = {
        #     "local": "1",
        # },
        tools = ctx.files._compiler_lib,
    )
    return [DefaultInfo(files = depset([ctx.outputs.obj]))]

oblivc_object = rule(
    implementation = _oblivc_object_impl,
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
    outputs = {
        "obj": "%{name}.o",
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
    oblivc_object(
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
