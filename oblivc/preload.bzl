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
            url = "https://github.com/bazelbuild/rules_foreign_cc/archive/456425521973736ef346d93d3d6ba07d807047df.zip",
            strip_prefix = "rules_foreign_cc-456425521973736ef346d93d3d6ba07d807047df",
            sha256 = "450563dc2938f38566a59596bb30a3e905fbbcc35b3fff5a1791b122bc140465",
        )
