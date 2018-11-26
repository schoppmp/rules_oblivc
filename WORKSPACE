
workspace(name = "io_rules_oblivc")

load(
  "@bazel_tools//tools/build_defs/repo:git.bzl",
  "git_repository",
  "new_git_repository",
)

load("//oblivc:oblivc.bzl", "oblivc_library")

local_repository(
    name = "io_oblivc",
    path = "/home/schoppmp/obliv-c"
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
