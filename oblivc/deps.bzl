load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)
load(
    "@rules_foreign_cc//:workspace_definitions.bzl",
    "rules_foreign_cc_dependencies",
)

all_content = """
filegroup(
  name = "all",
  srcs = glob(["**"]),
  visibility = ["//visibility:public"],
)
"""

def clean_dep(dep):
    return str(Label(dep))

def oblivc_deps():
    rules_foreign_cc_dependencies()

    if "oblivc" not in native.existing_rules():
        http_archive(
            name = "oblivc",
            url = "https://github.com/schoppmp/obliv-c/archive/6f08d7860536f49ec102397383c0d77cebd34c7b.zip",
            sha256 = "8f7dca92f749cf099d6f04213615dc6af47f3c2b93536d1c704c4947bd0bcab4",
            strip_prefix = "obliv-c-6f08d7860536f49ec102397383c0d77cebd34c7b",
            build_file = clean_dep("//:oblivc.BUILD"),
        )

    if "org_gnupg_gcrypt" not in native.existing_rules():
        http_archive(
            name = "org_gnupg_gcrypt",
            url = "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.4.tar.bz2",
            strip_prefix = "libgcrypt-1.8.4",
            sha256 = "f638143a0672628fde0cad745e9b14deb85dffb175709cacc1f4fe24b93f2227",
            build_file_content = all_content,
        )

    if "org_gnupg_gpg_error" not in native.existing_rules():
        http_archive(
            name = "org_gnupg_gpg_error",
            url = "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.34.tar.bz2",
            strip_prefix = "libgpg-error-1.34",
            sha256 = "0680799dee71b86b2f435efb825391eb040ce2704b057f6bd3dcc47fbc398c81",
            build_file_content = all_content,
        )
