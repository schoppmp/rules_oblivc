def _oblivc_library_impl(ctx):
  inputs = ctx.files.srcs + ctx.files.hdrs
  input_paths = [f.path for f in inputs]
  args = \
    ["-I" + file.dirname for file in ctx.files.deps] + \
    ["-c"] + input_paths + ["-o", ctx.outputs.obj.path] + \
    ctx.fragments.cpp.copts
  ctx.actions.run(
    inputs = inputs,
    outputs = [ ctx.outputs.obj ],
    arguments = args,
    progress_message = "Compiling {} using Obliv-C".format(
      ctx.outputs.obj.path
    ),
    executable = ctx.executable.compiler,
    use_default_shell_env = True,
    execution_requirements = {
      "local": "1",
    },
    tools = ctx.files._runfiles
  )
  return [ DefaultInfo(files = depset([ ctx.outputs.obj ])) ]

oblivc_library = rule(
    implementation = _oblivc_library_impl,
    attrs = {
      "srcs": attr.label_list(allow_files = True),
      "hdrs": attr.label_list(allow_files = True),
      "deps": attr.label_list(
        allow_files = True,
        default = [
          "@io_oblivc//:runtime_headers",
          "@io_oblivc//:runtime_obliv_headers",
         ],
      ),
      "compiler": attr.label(
        default = "@io_oblivc//:bin/oblivcc",
        allow_files = True,
        cfg = "host",
        executable = True,
      ),
      "_runfiles": attr.label(
        default = "@io_oblivc//:compiled",
        allow_files = True,
        cfg = "host",
      )
    },
    outputs = {
      "obj": "%{name}.o",
    },
    fragments = [ "cpp" ],
  )
