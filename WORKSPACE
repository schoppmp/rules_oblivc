
workspace(name = "io_rules_oblivc")

load(
  "@bazel_tools//tools/build_defs/repo:git.bzl",
  "git_repository",
  "new_git_repository",
)

load("//oblivc:oblivc.bzl", "oblivc_library")

new_git_repository(
    name = "io_oblivc",
    remote = "https://github.com/schoppmp/obliv-c",
    commit = "66d0cee9c4dfb1952a7a9486d541669f869e6c9a",
    build_file = "BUILD.oblivc",
)
