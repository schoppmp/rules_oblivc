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
            url = "https://github.com/bazelbuild/rules_foreign_cc/archive/1f48d7756c8cb1361ce9cb9c7205036047d162e0.zip",
            strip_prefix = "rules_foreign_cc-1f48d7756c8cb1361ce9cb9c7205036047d162e0",
            sha256 = "382a2343cfd4cd1d94d7d89d9d2b7e15e48fc614e9371b4aeaf13e1161794b40",
        )

