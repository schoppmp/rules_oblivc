load(
  "//oblivc:oblivc.bzl",
  "oblivc_library",
)

oblivc_library(
  name = "million_oblivc",
  srcs = [ "million.oc" ],
  hdrs = [ "million.h" ]
)

cc_binary(
  name = "million",
  srcs = [ "million.c", ":million_oblivc" ],
)
