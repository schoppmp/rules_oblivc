def _oblivc_library_impl(ctx):
  inputs = ctx.files.srcs + ctx.files.hdrs
  input_paths = [f.path for f in inputs]
  args = ["-c"] + input_paths + ["-o", ctx.outputs.obj.path] + ctx.fragments.cpp.copts
  ctx.actions.run(
    inputs = inputs,
    outputs = [ ctx.outputs.obj ],
    arguments = args,
    progress_message = "Compiling {} using Obliv-C".format(
      ctx.outputs.obj.path
    ),
    executable = ctx.executable.compiler
  )
  return [ DefaultInfo(files = depset([ ctx.outputs.obj ])) ]

oblivc_library = rule(
    implementation = _oblivc_library_impl,
    attrs = {
      "srcs": attr.label_list(allow_files = True),
      "hdrs": attr.label_list(allow_files = True),
      "deps": attr.label_list(allow_files = True),
      "compiler": attr.label(
              default = "@io_oblivc//:oblivcc",
              allow_files = True,
              cfg = "host",
              executable = True,
          ),
    },
    outputs = {
      "obj": "%{name}.o",
    },
    fragments = [ "cpp" ],
  )
