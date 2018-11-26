
workspace(name = "io_rules_oblivc")

load(
  "@bazel_tools//tools/build_defs/repo:git.bzl",
  "git_repository",
  "new_git_repository",
)

load("//oblivc:oblivc.bzl", "oblivc_library")

new_git_repository(
    name = "io_oblivc",
    remote = "https://github.com/samee/obliv-c.git",
    commit = "3d6804ca0fd85868207a0ccbd2509ec064723ac2",
    build_file_content = """
load("@io_rules_oblivc//oblivc:compile.bzl", "compile_oblivc")

filegroup(
  name = "srcs",
  srcs = glob(["**/*"]),
)

compile_oblivc(
  name = "oblivc_tree",
)

sh_binary(
  name = "oblivcc",
  srcs = ["bin/oblivcc"],
  data = ["oblivc_tree"],
  visibility = ["//visibility:public"],
)

cc_library(
  name = "runtime",
  srcs = glob(["src/ext/oblivc/*.c"]),
  hdrs = glob(["src/ext/oblivc/*.h"]),
  copts = ["-Isrc/ext/oblivc -Wno-unused-variable"],
  visibility = ["//visibility:public"],
)
""",
)

git_repository(
    name = "io_bazel_rules_ocaml",
    remote = "https://github.com/jin/rules_ocaml.git",
    commit = "7a0a6e5226af5f09eb6e3379b901d8f2ffdb8bbf",
)

load("@io_bazel_rules_ocaml//ocaml:repo.bzl", "ocaml_repositories")
ocaml_repositories(
    opam_packages = {
      "ocaml": "4.06.0",
      "ocamlbuild": "0.12.0",
      "camlp4": "4.06+1",
      "ocamlfind": "1.8.0",
      "batteries": "2.9.0",
    },
)
