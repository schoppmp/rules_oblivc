load("@rules_foreign_cc//tools/build_defs:configure.bzl", "configure_make")

licenses(["restricted"])

configure_make(
    name = "gpg_error",
    configure_options = [
        "--enable-static=yes",
    ],
    lib_source = "@org_gnupg_gpg_error//:all",
    static_libraries = ["libgpg-error.a"],
    visibility = ["//visibility:public"],
)
