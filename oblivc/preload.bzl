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
            url = "https://github.com/bazelbuild/rules_foreign_cc/archive/16ddc00bd4e1b3daf3faee1605a168f5283326fa.zip",
            strip_prefix = "rules_foreign_cc-16ddc00bd4e1b3daf3faee1605a168f5283326fa",
            sha256 = "54ef1b6a31f7cd0f1c707efb1dc670ab86d2d7238af845108f31ed9e6d0fdf01",
        )
