FROM base/devel

# install dependencies in build container
RUN pacman --noconfirm -Syu \
  ocaml ocaml-findlib opam
RUN opam init --disable-sandboxing -y; \
  opam switch create -y 4.06.0; \
  eval `opam config env`; \
  opam install -y camlp4 ocamlfind ocamlbuild batteries;
RUN pacman --noconfirm -Syu \
  bazel
RUN pacman --noconfirm -Syu \
  git

WORKDIR /app
COPY . .

RUN eval `opam config env`; \
  cd test; \
  bazel build //:all
