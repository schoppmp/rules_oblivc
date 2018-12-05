load(
  "@bazel_tools//tools/build_defs/repo:http.bzl",
  "http_archive",
)

def oblivc_deps():
  if "oblivc" not in native.existing_rules():
    http_archive(
        name = "oblivc",
        url = "https://github.com/schoppmp/obliv-c/archive/b55a96e5aebb557e07668e30a79d6818b1663f5c.zip",
        sha256 = "b58a3022a5f62b88add1ce35d54781bcc557474c814ea13d1297b45554e2a4e9",
        strip_prefix = "obliv-c-b55a96e5aebb557e07668e30a79d6818b1663f5c",
        build_file = "@com_github_schoppmp_rules_oblivc//:BUILD.oblivc",
    )
