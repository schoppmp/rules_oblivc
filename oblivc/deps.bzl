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

def oblivc_deps():
    rules_foreign_cc_dependencies()

    if "oblivc" not in native.existing_rules():
        http_archive(
            name = "oblivc",
            url = "https://github.com/schoppmp/obliv-c/archive/b55a96e5aebb557e07668e30a79d6818b1663f5c.zip",
            sha256 = "b58a3022a5f62b88add1ce35d54781bcc557474c814ea13d1297b45554e2a4e9",
            strip_prefix = "obliv-c-b55a96e5aebb557e07668e30a79d6818b1663f5c",
            build_file = "@com_github_schoppmp_rules_oblivc//:oblivc.BUILD",
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
