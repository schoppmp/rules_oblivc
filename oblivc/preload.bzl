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
            url = "https://github.com/bazelbuild/rules_foreign_cc/archive/8ccd83504b2221b670fc0b83d78fcee5642f4cb1.zip",
            strip_prefix = "rules_foreign_cc-8ccd83504b2221b670fc0b83d78fcee5642f4cb1",
            sha256 = "e5e8289b236bf57cfed2e76a20756ddff90fec7c8a4633e6a028e65899ecb6c7",
        )
