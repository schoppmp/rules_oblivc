load("@rules_foreign_cc//foreign_cc:configure.bzl", "configure_make")

licenses(["restricted"])

configure_make(
    name = "gcrypt",
    configure_options = [
        "--enable-static=yes",
        "--with-libgpg-error-prefix=$EXT_BUILD_DEPS/gpg_error/",
    ],
    lib_source = "@org_gnupg_gcrypt//:all",
    out_static_libs = ["libgcrypt.a"],
    visibility = ["//visibility:public"],
    deps = [
        "//third_party/gpg_error",
    ],
)
