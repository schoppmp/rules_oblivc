load("//oblivc:oblivc.bzl", "oblivc_library")

oblivc_library(
  name = "obliv_runtime",
  srcs = [
    "@io_oblivc//:runtime_sources",
  ],
  hdrs = [
    "@io_oblivc//:runtime_headers",
    "@io_oblivc//:runtime_obliv_headers",
  ],
  deps = [],
)

cc_library(
  name = "runtime",
  srcs = [
    ":obliv_runtime",
  ],
  hdrs = [
    "@io_oblivc//:runtime_headers",
  ],
  includes = [
    "@io_oblivc//:src/ext/oblivc"
  ],
  visibility = ["//visibility:public"],
)
