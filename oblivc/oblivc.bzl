def _oblivc_object_impl(ctx):
  inputs = ctx.files.srcs
  input_paths = [f.path for f in inputs]
  # We have to include the Obliv-C runtime headers here.
  args = ["-I" + ctx.files._oblivc_headers[0].dirname]
  args += ["-c"] + input_paths + ["-o", ctx.outputs.obj.path]
  args += ctx.fragments.cpp.copts
  args += ctx.host_fragments.cpp.copts
  # TODO: Handle dependencies.
  ctx.actions.run(
    inputs = inputs,
    outputs = [ ctx.outputs.obj ],
    arguments = args,
    progress_message = "Compiling {} using Obliv-C".format(
      ctx.outputs.obj.path
    ),
    executable = ctx.executable._compiler,
    use_default_shell_env = True,
    execution_requirements = {
      "local": "1",
    },
    tools = ctx.files._runfiles
  )
  return [ DefaultInfo(files = depset([ ctx.outputs.obj ])) ]

oblivc_object = rule(
    implementation = _oblivc_object_impl,
    attrs = {
      "srcs": attr.label_list(allow_files = True),
      "hdrs": attr.label_list(allow_files = True),
      "deps": attr.label_list(allow_files = True),
      "_compiler": attr.label(
        default = "@oblivc//:bin/oblivcc",
        allow_files = True,
        cfg = "host",
        executable = True,
      ),
      "_runfiles": attr.label(
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
    fragments = [ "cpp" ],
    host_fragments = [ "cpp" ],
  )

def oblivc_library(name, srcs = [], hdrs = [], deps = [], runtime = True):
  oblivc_object(
    name = name + "_obliv",
    srcs = srcs,
    hdrs = hdrs,
    deps = deps
  )
  if runtime:
    native_deps = ["@oblivc//:runtime"]
  else:
    native_deps = deps
  native.cc_library(
    name = name,
    srcs = [name + "_obliv"],
    hdrs = hdrs,
    deps = native_deps
  )
