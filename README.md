# rules_oblivc
[Bazel](bazel.build) rules for compiling Obliv-C sources. For an example, see the [test](test) folder. Currently (Bazel 0.21.0), it requires `--noincompatible_strict_action_env` to be passed via the command line or a `.bazelrc` file when building. Leave this flag out when building with an older version of bazel. See also bazel#4008.
