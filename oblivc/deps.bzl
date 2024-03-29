load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)
load(
    "@rules_foreign_cc//foreign_cc:repositories.bzl",
    "rules_foreign_cc_dependencies",
)
load("//third_party:repo.bzl", "third_party_http_archive")

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
            url = "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.5.tar.bz2",
            strip_prefix = "libgcrypt-1.8.5",
            sha256 = "3b4a2a94cb637eff5bdebbcaf46f4d95c4f25206f459809339cdada0eb577ac3",
            build_file_content = all_content,
        )

    if "org_gnupg_gpg_error" not in native.existing_rules():
        third_party_http_archive(
            name = "org_gnupg_gpg_error",
            url = "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.37.tar.bz2",
            sha256 = "b32d6ff72a73cf79797f7f2d039e95e9c6f92f0c1450215410840ab62aea9763",
            strip_prefix = "libgpg-error-1.37",
            build_file_content = all_content,
        )
