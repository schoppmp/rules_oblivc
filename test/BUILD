load("@io_rules_oblivc//oblivc:oblivc.bzl", "oblivc_library")

oblivc_library(
  name = "million_oblivc",
  srcs = [ "million.oc" ],
  hdrs = [ "million.h" ],
)

cc_binary(
  name = "million",
  srcs = [ "million.c" ],
  deps = [
    "million_oblivc",
  ],
)
