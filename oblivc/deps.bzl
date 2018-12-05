load(
  "@bazel_tools//tools/build_defs/repo:git.bzl",
  "new_git_repository",
)

def oblivc_deps():
  if "com_github_samee_oblivc" not in native.existing_rules():
    new_git_repository(
        name = "com_github_samee_oblivc",
        remote = "https://github.com/schoppmp/obliv-c",
        commit = "b55a96e5aebb557e07668e30a79d6818b1663f5c",
        build_file = "@com_github_schoppmp_rules_oblivc//:BUILD.oblivc",
    )
