
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
    commit = "b55a96e5aebb557e07668e30a79d6818b1663f5c",
    build_file = "BUILD.oblivc",
)
