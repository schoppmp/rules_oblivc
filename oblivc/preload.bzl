load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

# Dependencies that need to be defined before :deps.bzl can be loaded.
# Copy those in a similar preload.bzl file in any workspace that depends on
# this one.
def oblivc_deps_preload():
    if "rules_foreign_cc" not in native.existing_rules():
        http_archive(
            name = "rules_foreign_cc",
            url = "https://github.com/bazelbuild/rules_foreign_cc/archive/216ded8acb95d81e312b228dce3c39872c7a7c34.zip",
            strip_prefix = "rules_foreign_cc-216ded8acb95d81e312b228dce3c39872c7a7c34",
            sha256 = "bb38d30c5d06cc1aedc9db7d2274d2323419a60200ac8e5fdbdc100e37740975",
        )
