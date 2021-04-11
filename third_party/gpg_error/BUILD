load("@rules_foreign_cc//foreign_cc:configure.bzl", "configure_make")

licenses(["restricted"])

configure_make(
    name = "gpg_error",
    configure_options = [
        "--enable-static=yes",
    ],
    lib_source = "@org_gnupg_gpg_error//:all",
    out_static_libs = ["libgpg-error.a"],
    visibility = ["//visibility:public"],
)
