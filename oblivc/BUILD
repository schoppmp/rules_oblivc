load("//oblivc:oblivc.bzl", "oblivc_library")

cc_library(
  name = "oblivc",
  deps = ["@io_oblivc//:runtime",],
  hdrs = ["@io_oblivc//:runtime_headers"],
  strip_include_prefix = "/external/io_oblivc/src/ext/oblivc",
  visibility = ["//visibility:public"],
)
