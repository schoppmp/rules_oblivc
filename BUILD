load("@rules_foreign_cc//tools/build_defs:configure.bzl", "configure_make")

configure_make(
    name = "ocaml",
    lib_source = "@com_github_ocaml_ocaml//:all",
    make_commands = [
      "make world.opt",
      "make install",
    ],
    out_lib_dir = "lib/ocaml",
    static_libraries = [
      "graphics.a",
      "libthreadsnat.a",
      "raw_spacetime_lib.a",
      "bigarray.a",
      "dynlink.a",
      "str.a",
      "unix.a",
      "stdlib.p.a",
      "stdlib.a",
      "libasmrun_pic.a",
      "libasmrunp.a",
      "libasmrun.a",
      "ocamldoc/odoc_info.a",
      "libgraphics.a",
      "vmthreads/libvmthreads.a",
      "threads/threads.a",
      "libthreads.a",
      "libbigarray.a",
      "libcamlstr.a",
      "libunix.a",
      "libcamlrun_pic.a",
      "libcamlrun.a",
      "compiler-libs/ocamloptcomp.a",
      "compiler-libs/ocamlbytecomp.a",
      "compiler-libs/ocamlcommon.a",
    ],
    shared_libraries = [
      "libasmrun_shared.so",
      "libcamlrun_shared.so",
      "stublibs/dllgraphics.so",
      "stublibs/dllvmthreads.so",
      "stublibs/dllthreads.so",
      "stublibs/dllbigarray.so",
      "stublibs/dllcamlstr.so",
      "stublibs/dllunix.so",
    ],
    binaries = [
      "ocaml",
      "ocamlc",
      "ocamlc.byte",
      "ocamlcmt",
      "ocamlcp",
      "ocamlcp.byte",
      "ocamldebug",
      "ocamldep",
      "ocamldep.byte",
      "ocamldoc",
      "ocamllex",
      "ocamllex.byte",
      "ocamlmklib",
      "ocamlmklib.byte",
      "ocamlmktop",
      "ocamlmktop.byte",
      "ocamlobjinfo",
      "ocamlobjinfo.byte",
      "ocamloptp",
      "ocamloptp.byte",
      "ocamlprof",
      "ocamlprof.byte",
      "ocamlrun",
      "ocamlyacc",
    ],
    postfix_script = """
        find -L $INSTALLDIR/bin -print -type f \
         -exec sed -i 's@#!'"$BUILD_TMPDIR/$INSTALL_PREFIX/bin/"'@#!'"/usr/bin/env "'@g' {} ';'
    """,
)

configure_make(
    name = "opam",
    lib_source = "@com_github_ocaml_opam//:all",
    deps = [
      ":ocaml",
    ],
    configure_env_vars = {
      "PATH": "$EXT_BUILD_DEPS/ocaml/bin:$PATH",
      "CAML_LD_LIBRARY_PATH": "$EXT_BUILD_DEPS/ocaml/lib/ocaml",
    },
)


configure_make(
    name = "opam_cold",
    lib_source = "@com_github_ocaml_opam//:all",
    make_commands = [
      "make",
      "make cold-install",
    ]
)
