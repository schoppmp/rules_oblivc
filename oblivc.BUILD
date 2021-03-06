load("@com_github_schoppmp_rules_oblivc//oblivc:oblivc.bzl", "oblivc_library")

filegroup(
    name = "sources",
    srcs = glob(
        ["**/*"],
        exclude = [
            "bin/cilly",
            "bin/oblivcc",
            "lib/perl5/patcher",
            "lib/perl5/Makefile.PL",
            "lib/perl5/MANIFEST",
            "lib/perl5/App/Cilly/TempFile.pm",
            "lib/perl5/App/Cilly/OutputFile.pm",
            "lib/perl5/App/Cilly/KeptFile.pm",
            "lib/perl5/App/Cilly/CilCompiler.pm",
            "lib/perl5/.gdbinit",
        ],
    ),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "all",
    srcs = [
        "configure",
        ":sources",
    ],
)

filegroup(
    name = "runtime_headers",
    srcs = glob([
        "src/ext/oblivc/*.h",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "runtime_obliv_headers",
    srcs = glob([
        "src/ext/oblivc/*.oh",
    ]),
)

filegroup(
    name = "runtime_sources",
    srcs = glob([
        "src/ext/oblivc/*.c",
    ]),
)

filegroup(
    name = "runtime_obliv_sources",
    srcs = glob([
        "src/ext/oblivc/*.oc",
    ]),
)

oblivc_library(
    name = "runtime_obliv",
    srcs = [
        ":runtime_obliv_sources",
        # Linking only works if this is included here. Not sure why, it should
        # be compiled in :runtime and linked to any oblivc_library target.
        "src/ext/oblivc/copy.c",
    ],
    hdrs = [
        ":runtime_headers",
        ":runtime_obliv_headers",
    ],
    copts = [
        "-Wno-unused-but-set-variable",
    ],
    runtime = False,
    deps = [
        "@com_github_schoppmp_rules_oblivc//third_party/gcrypt",
    ],
)

cc_library(
    name = "runtime",
    srcs = [
        ":runtime_sources",
    ],
    hdrs = [
        ":runtime_headers",
    ],
    copts = [
        "-Wno-unused-but-set-variable",
        "-Wno-unused-variable",
        "-I$(rootpath src/ext/oblivc)",
    ],
    data = ["src/ext/oblivc"],
    linkopts = [
        "-lpthread",
    ],
    strip_include_prefix = "src/ext/oblivc",
    visibility = ["//visibility:public"],
    deps = [
        "runtime_obliv",
        "@com_github_schoppmp_rules_oblivc//third_party/gcrypt",
    ],
)

genrule(
    name = "_compile",
    srcs = [
        ":sources",
        "configure",
    ],
    outs = [
        "lib/cil/ccl.mli",
        "lib/cil/ccl.cmx",
        "lib/cil/ccl.cmi",
        "lib/cil/epicenter.inferred.mli",
        "lib/cil/epicenter.cmx",
        "lib/cil/epicenter.cmi",
        "lib/cil/logwrites.inferred.mli",
        "lib/cil/logwrites.cmx",
        "lib/cil/logwrites.cmi",
        "lib/cil/availexps.inferred.mli",
        "lib/cil/availexps.cmx",
        "lib/cil/availexps.cmi",
        "lib/cil/availexpslv.inferred.mli",
        "lib/cil/availexpslv.cmx",
        "lib/cil/availexpslv.cmi",
        "lib/cil/ciltools.inferred.mli",
        "lib/cil/ciltools.cmx",
        "lib/cil/ciltools.cmi",
        "lib/cil/deadcodeelim.inferred.mli",
        "lib/cil/deadcodeelim.cmx",
        "lib/cil/deadcodeelim.cmi",
        "lib/cil/reachingdefs.inferred.mli",
        "lib/cil/reachingdefs.cmx",
        "lib/cil/reachingdefs.cmi",
        "lib/cil/rmciltmps.inferred.mli",
        "lib/cil/rmciltmps.cmx",
        "lib/cil/rmciltmps.cmi",
        "lib/cil/zrapp.mli",
        "lib/cil/zrapp.cmx",
        "lib/cil/zrapp.cmi",
        "lib/cil/cqualann.inferred.mli",
        "lib/cil/cqualann.cmx",
        "lib/cil/cqualann.cmi",
        "lib/cil/simplify.mli",
        "lib/cil/simplify.cmx",
        "lib/cil/simplify.cmi",
        "lib/cil/sfi.inferred.mli",
        "lib/cil/sfi.cmx",
        "lib/cil/sfi.cmi",
        "lib/cil/blockinggraph.mli",
        "lib/cil/blockinggraph.cmx",
        "lib/cil/blockinggraph.cmi",
        "lib/cil/heap.inferred.mli",
        "lib/cil/heap.cmx",
        "lib/cil/heap.cmi",
        "lib/cil/partial.inferred.mli",
        "lib/cil/partial.cmx",
        "lib/cil/partial.cmi",
        "lib/cil/inliner.inferred.mli",
        "lib/cil/inliner.cmx",
        "lib/cil/inliner.cmi",
        "lib/cil/golf.mli",
        "lib/cil/golf.cmx",
        "lib/cil/golf.cmi",
        "lib/cil/olf.mli",
        "lib/cil/olf.cmx",
        "lib/cil/olf.cmi",
        "lib/cil/ptranal.mli",
        "lib/cil/ptranal.cmx",
        "lib/cil/ptranal.cmi",
        "lib/cil/setp.mli",
        "lib/cil/setp.cmx",
        "lib/cil/setp.cmi",
        "lib/cil/steensgaard.mli",
        "lib/cil/steensgaard.cmx",
        "lib/cil/steensgaard.cmi",
        "lib/cil/uref.mli",
        "lib/cil/uref.cmx",
        "lib/cil/uref.cmi",
        "lib/cil/oblivUtils.inferred.mli",
        "lib/cil/oblivUtils.cmx",
        "lib/cil/oblivUtils.cmi",
        "lib/cil/simplifyTagged.mli",
        "lib/cil/simplifyTagged.cmx",
        "lib/cil/simplifyTagged.cmi",
        "lib/cil/processObliv.inferred.mli",
        "lib/cil/processObliv.cmx",
        "lib/cil/processObliv.cmi",
        "lib/cil/logcalls.mli",
        "lib/cil/logcalls.cmx",
        "lib/cil/logcalls.cmi",
        "lib/cil/oneret.mli",
        "lib/cil/oneret.cmx",
        "lib/cil/oneret.cmi",
        "lib/cil/callgraph.mli",
        "lib/cil/callgraph.cmx",
        "lib/cil/callgraph.cmi",
        "lib/cil/heapify.inferred.mli",
        "lib/cil/heapify.cmx",
        "lib/cil/heapify.cmi",
        "lib/cil/llvm.inferred.mli",
        "lib/cil/llvm.cmx",
        "lib/cil/llvm.cmi",
        "lib/cil/llvmgen.inferred.mli",
        "lib/cil/llvmgen.cmx",
        "lib/cil/llvmgen.cmi",
        "lib/cil/llvmssa.inferred.mli",
        "lib/cil/llvmssa.cmx",
        "lib/cil/llvmssa.cmi",
        "lib/cil/llvmutils.inferred.mli",
        "lib/cil/llvmutils.cmx",
        "lib/cil/llvmutils.cmi",
        "lib/cil/liveness.inferred.mli",
        "lib/cil/liveness.cmx",
        "lib/cil/liveness.cmi",
        "lib/cil/usedef.inferred.mli",
        "lib/cil/usedef.cmx",
        "lib/cil/usedef.cmi",
        "lib/cil/dataslicing.mli",
        "lib/cil/dataslicing.cmx",
        "lib/cil/dataslicing.cmi",
        "lib/cil/canonicalize.mli",
        "lib/cil/canonicalize.cmx",
        "lib/cil/canonicalize.cmi",
        "lib/cil/simplemem.inferred.mli",
        "lib/cil/simplemem.cmx",
        "lib/cil/simplemem.cmi",
        "lib/cil/whitetrack.mli",
        "lib/cil/whitetrack.cmx",
        "lib/cil/whitetrack.cmi",
        "lib/cil/util.mli",
        "lib/cil/util.cmx",
        "lib/cil/util.cmi",
        "lib/cil/trace.mli",
        "lib/cil/trace.cmx",
        "lib/cil/trace.cmi",
        "lib/cil/stats.mli",
        "lib/cil/stats.cmx",
        "lib/cil/stats.cmi",
        "lib/cil/rmtmps.mli",
        "lib/cil/rmtmps.cmx",
        "lib/cil/rmtmps.cmi",
        "lib/cil/pretty.mli",
        "lib/cil/pretty.cmx",
        "lib/cil/pretty.cmi",
        "lib/cil/patch.mli",
        "lib/cil/patch.cmx",
        "lib/cil/patch.cmi",
        "lib/cil/mergecil.mli",
        "lib/cil/mergecil.cmx",
        "lib/cil/mergecil.cmi",
        "lib/cil/machdepenv.inferred.mli",
        "lib/cil/machdepenv.cmx",
        "lib/cil/machdepenv.cmi",
        "lib/cil/machdep.inferred.mli",
        "lib/cil/machdep.cmx",
        "lib/cil/machdep.cmi",
        "lib/cil/longarray.mli",
        "lib/cil/longarray.cmx",
        "lib/cil/longarray.cmi",
        "lib/cil/lexerhack.inferred.mli",
        "lib/cil/lexerhack.cmx",
        "lib/cil/lexerhack.cmi",
        "lib/cil/inthash.mli",
        "lib/cil/inthash.cmx",
        "lib/cil/inthash.cmi",
        "lib/cil/growArray.mli",
        "lib/cil/growArray.cmx",
        "lib/cil/growArray.cmi",
        "lib/cil/frontc.mli",
        "lib/cil/frontc.cmx",
        "lib/cil/frontc.cmi",
        "lib/cil/formatparse.mli",
        "lib/cil/formatparse.cmx",
        "lib/cil/formatparse.cmi",
        "lib/cil/formatlex.inferred.mli",
        "lib/cil/formatlex.cmx",
        "lib/cil/formatlex.cmi",
        "lib/cil/formatcil.mli",
        "lib/cil/formatcil.cmx",
        "lib/cil/formatcil.cmi",
        "lib/cil/feature.mli",
        "lib/cil/feature.cmx",
        "lib/cil/feature.cmi",
        "lib/cil/expcompare.inferred.mli",
        "lib/cil/expcompare.cmx",
        "lib/cil/expcompare.cmi",
        "lib/cil/escape.mli",
        "lib/cil/escape.cmx",
        "lib/cil/escape.cmi",
        "lib/cil/errormsg.mli",
        "lib/cil/errormsg.cmx",
        "lib/cil/errormsg.cmi",
        "lib/cil/dominators.mli",
        "lib/cil/dominators.cmx",
        "lib/cil/dominators.cmi",
        "lib/cil/dataflow.mli",
        "lib/cil/dataflow.cmx",
        "lib/cil/dataflow.cmi",
        "lib/cil/cprint.inferred.mli",
        "lib/cil/cprint.cmx",
        "lib/cil/cprint.cmi",
        "lib/cil/cparser.mli",
        "lib/cil/cparser.cmx",
        "lib/cil/cparser.cmi",
        "lib/cil/clist.mli",
        "lib/cil/clist.cmx",
        "lib/cil/clist.cmi",
        "lib/cil/clexer.mli",
        "lib/cil/clexer.cmx",
        "lib/cil/clexer.cmi",
        "lib/cil/cilversion.inferred.mli",
        "lib/cil/cilversion.cmx",
        "lib/cil/cilversion.cmi",
        "lib/cil/cilutil.inferred.mli",
        "lib/cil/cilutil.cmx",
        "lib/cil/cilutil.cmi",
        "lib/cil/ciloptions.mli",
        "lib/cil/ciloptions.cmx",
        "lib/cil/ciloptions.cmi",
        "lib/cil/cillower.mli",
        "lib/cil/cillower.cmx",
        "lib/cil/cillower.cmi",
        "lib/cil/cilint.mli",
        "lib/cil/cilint.cmx",
        "lib/cil/cilint.cmi",
        "lib/cil/cil.mli",
        "lib/cil/cil.cmx",
        "lib/cil/cil.cmi",
        "lib/cil/check.mli",
        "lib/cil/check.cmx",
        "lib/cil/check.cmi",
        "lib/cil/cfg.mli",
        "lib/cil/cfg.cmx",
        "lib/cil/cfg.cmi",
        "lib/cil/cabsvisit.mli",
        "lib/cil/cabsvisit.cmx",
        "lib/cil/cabsvisit.cmi",
        "lib/cil/cabshelper.inferred.mli",
        "lib/cil/cabshelper.cmx",
        "lib/cil/cabshelper.cmi",
        "lib/cil/cabs2cil.mli",
        "lib/cil/cabs2cil.cmx",
        "lib/cil/cabs2cil.cmi",
        "lib/cil/cabs.inferred.mli",
        "lib/cil/cabs.cmx",
        "lib/cil/cabs.cmi",
        "lib/cil/bitmap.mli",
        "lib/cil/bitmap.cmx",
        "lib/cil/bitmap.cmi",
        "lib/cil/alpha.mli",
        "lib/cil/alpha.cmx",
        "lib/cil/alpha.cmi",
        "lib/cil/ccl.a",
        "lib/cil/epicenter.a",
        "lib/cil/logwrites.a",
        "lib/cil/zrapp.a",
        "lib/cil/cqualann.a",
        "lib/cil/simplify.a",
        "lib/cil/sfi.a",
        "lib/cil/blockinggraph.a",
        "lib/cil/partial.a",
        "lib/cil/inliner.a",
        "lib/cil/pta.a",
        "lib/cil/processObliv.a",
        "lib/cil/logcalls.a",
        "lib/cil/oneret.a",
        "lib/cil/callgraph.a",
        "lib/cil/heapify.a",
        "lib/cil/llvm.a",
        "lib/cil/liveness.a",
        "lib/cil/dataslicing.a",
        "lib/cil/canonicalize.a",
        "lib/cil/simplemem.a",
        "lib/cil/ccl.cmxs",
        "lib/cil/epicenter.cmxs",
        "lib/cil/logwrites.cmxs",
        "lib/cil/zrapp.cmxs",
        "lib/cil/cqualann.cmxs",
        "lib/cil/simplify.cmxs",
        "lib/cil/sfi.cmxs",
        "lib/cil/blockinggraph.cmxs",
        "lib/cil/partial.cmxs",
        "lib/cil/inliner.cmxs",
        "lib/cil/pta.cmxs",
        "lib/cil/processObliv.cmxs",
        "lib/cil/logcalls.cmxs",
        "lib/cil/oneret.cmxs",
        "lib/cil/callgraph.cmxs",
        "lib/cil/heapify.cmxs",
        "lib/cil/llvm.cmxs",
        "lib/cil/liveness.cmxs",
        "lib/cil/dataslicing.cmxs",
        "lib/cil/canonicalize.cmxs",
        "lib/cil/simplemem.cmxs",
        "lib/cil/ccl.cmxa",
        "lib/cil/epicenter.cmxa",
        "lib/cil/logwrites.cmxa",
        "lib/cil/zrapp.cmxa",
        "lib/cil/cqualann.cmxa",
        "lib/cil/simplify.cmxa",
        "lib/cil/sfi.cmxa",
        "lib/cil/blockinggraph.cmxa",
        "lib/cil/partial.cmxa",
        "lib/cil/inliner.cmxa",
        "lib/cil/pta.cmxa",
        "lib/cil/processObliv.cmxa",
        "lib/cil/logcalls.cmxa",
        "lib/cil/oneret.cmxa",
        "lib/cil/callgraph.cmxa",
        "lib/cil/heapify.cmxa",
        "lib/cil/llvm.cmxa",
        "lib/cil/liveness.cmxa",
        "lib/cil/dataslicing.cmxa",
        "lib/cil/canonicalize.cmxa",
        "lib/cil/simplemem.cmxa",
        "lib/cil/cil.a",
        "lib/cil/cil.cmxa",
        "lib/cil/ccl.cma",
        "lib/cil/epicenter.cma",
        "lib/cil/logwrites.cma",
        "lib/cil/zrapp.cma",
        "lib/cil/cqualann.cma",
        "lib/cil/simplify.cma",
        "lib/cil/sfi.cma",
        "lib/cil/blockinggraph.cma",
        "lib/cil/partial.cma",
        "lib/cil/inliner.cma",
        "lib/cil/pta.cma",
        "lib/cil/processObliv.cma",
        "lib/cil/logcalls.cma",
        "lib/cil/oneret.cma",
        "lib/cil/callgraph.cma",
        "lib/cil/heapify.cma",
        "lib/cil/llvm.cma",
        "lib/cil/liveness.cma",
        "lib/cil/dataslicing.cma",
        "lib/cil/canonicalize.cma",
        "lib/cil/simplemem.cma",
        "lib/cil/cil.cma",
        "lib/cil/META",
        "lib/perl5/MYMETA.yml",
        "lib/perl5/MYMETA.json",
        "lib/perl5/App/Cilly.pm",
        "lib/perl5/App/Cilly/CilConfig.pm",
        "lib/perl5/blib/man1/.exists",
        "lib/perl5/blib/script/cilly",
        "lib/perl5/blib/script/.exists",
        "lib/perl5/blib/bin/.exists",
        "lib/perl5/blib/man3/.exists",
        "lib/perl5/blib/lib/auto/cilly/.exists",
        "lib/perl5/blib/lib/App/Cilly/CilCompiler.pm",
        "lib/perl5/blib/lib/App/Cilly/CilConfig.pm",
        "lib/perl5/blib/lib/App/Cilly/OutputFile.pm",
        "lib/perl5/blib/lib/App/Cilly/TempFile.pm",
        "lib/perl5/blib/lib/App/Cilly/KeptFile.pm",
        "lib/perl5/blib/lib/App/Cilly.pm",
        "lib/perl5/blib/lib/.exists",
        "lib/perl5/blib/arch/.exists",
        "lib/perl5/blib/arch/auto/cilly/.exists",
        "lib/perl5/Makefile",
        "lib/perl5/pm_to_blib",
        "bin/cilly.native",
        "share/cil/ocamlpath",
        # Copied from inputs, excluded from :sources.
        "bin/cilly",
        "bin/oblivcc",
        "lib/perl5/patcher",
        "lib/perl5/Makefile.PL",
        "lib/perl5/MANIFEST",
        "lib/perl5/App/Cilly/TempFile.pm",
        "lib/perl5/App/Cilly/OutputFile.pm",
        "lib/perl5/App/Cilly/KeptFile.pm",
        "lib/perl5/App/Cilly/CilCompiler.pm",
        "lib/perl5/.gdbinit",
    ],
    # Build Obliv-C locally. We have to make a deep-copy of the sources, because
    # relative paths do not work across symlinks.
    cmd = "\n".join([
        "DIR=$$(mktemp -d $${TMPDIR-/tmp}/bazel-oblivc.XXXXXXX)",
        "cp -Lfr $$(dirname $(rootpath configure))/* \"$${DIR}\"",
        "(cd \"$${DIR}\" && ./configure && make install-local)",
        "echo \"$(@D)/lib\" > $(@D)/share/cil/ocamlpath",
        "cp -r $${DIR}/bin $(@D)",
        "cp -r $${DIR}/lib $(@D) || true",
        "rm -rf \"$${DIR}\"",
    ]),
    local = 1,
    visibility = ["//visibility:public"],
)
