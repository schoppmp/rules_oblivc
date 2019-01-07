workspace(name = "com_github_schoppmp_rules_oblivc")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Group the sources of the library so that make rules have access to it
all_content = """filegroup(name = "all", srcs = glob(["**"]), visibility = ["//visibility:public"])"""

# Rule repository
local_repository(
   name = "rules_foreign_cc",
   path = "/home/schoppmp/rules_foreign_cc",
)
#http_archive(
#   name = "rules_foreign_cc",
#   strip_prefix = "rules_foreign_cc-master",
#   url = "https://github.com/schoppmp/rules_foreign_cc/archive/master.zip",
#)
load("@rules_foreign_cc//:workspace_definitions.bzl", "rules_foreign_cc_dependencies")

# Workspace initialization function; includes repositories needed by rules_foreign_cc,
# and creates some utilities for the host operating system
rules_foreign_cc_dependencies()

# OCaml
http_archive(
  name = "com_github_ocaml_ocaml",
  build_file_content = all_content,
  url = "https://github.com/ocaml/ocaml/archive/4.06.1.zip",
  strip_prefix = "ocaml-4.06.1",
)

# OPAM
http_archive(
  name = "com_github_ocaml_opam",
  build_file_content = all_content,
  url = "https://github.com/ocaml/opam/archive/2.0.2.zip",
  strip_prefix = "opam-2.0.2",
)
