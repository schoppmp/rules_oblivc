def _impl(ctx):
  tree = ctx.actions.declare_directory(ctx.attr.name)
  ctx.actions.run_shell(
    inputs = ctx.files.srcs,
    outputs = [ tree ],
    progress_message = "Compiling Obliv-C",
    command = "\n".join([
          "cd external/io_oblivc",
          "DIR=$(mktemp -d ${TMPDIR-/tmp}/tmp.XXXXXXX)",
          "cp -Lfr . \"${DIR}\"",
          "(cd \"${DIR}\" && ./configure && make)",
          "mkdir {}/{{bin,_build}}".format(ctx.attr.name),
          "cp ${{DIR}}/bin/oblivcc {}/bin/oblivcc".format(ctx.attr.name),
          "cp ${{DIR}}/bin/cilly {}/bin/cilly".format(ctx.attr.name),
          "cp ${{DIR}}/_build/libobliv.a {}/_build".format(ctx.attr.name),
          "cp -r ${{DIR}}/lib {}".format(ctx.attr.name),
          ]),
  )
  return [ DefaultInfo(files = depset([ tree ])) ]

compile_oblivc = rule(
  implementation = _impl,
  attrs = {
    "srcs": attr.label_list(
      allow_files = True,
      default = [ "@io_oblivc//:srcs" ]
    ),
  }
)
