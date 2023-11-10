FROM ghcr.io/graalvm/jdk:ol8-java17-22.3.1

RUN bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"

ENV PATH="/home/opam/graalvm-ce-java17-22.3.1/bin:$PATH"

ENV JAVA_HOME="/home/opam/graalvm-ce-java17-22.3.1"

RUN gu install llvm-toolchain
ENV PATH="/home/opam/graalvm-ce-java17-22.3.1/lib/llvm/bin:$PATH"
ENV LLVM_TOOLCHAIN=$(lli --print-toolchain-path)

COPY --chown=opam:opam . /home/opam/code