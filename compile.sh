#!/bin/bash
build_dir="./build"
# Set the name of the OCaml source file
ocaml_source_file="example.ml"
# Set the name of the output file
output_file="example"

rm -rf $build_dir/*
# Compile the OCaml source file to a native object file using the OCaml compiler
ocamlc -output-complete-obj -cc $LLVM_TOOLCHAIN/clang -o "$build_dir/${output_file}.c" "${ocaml_source_file}"
ocamlopt -output-complete-obj -cc $LLVM_TOOLCHAIN/clang -o "$build_dir/libmain.so" "${ocaml_source_file}"


echo Compiling $build_dir/$output_file.c
$LLVM_TOOLCHAIN/clang $build_dir/$output_file.c -L$(ocamlc -where) -I$(ocamlc -where) -L$build_dir -lcamlrun -lmain -o $build_dir/$output_file
# Compile the C file to LLVM bitcode using the LLVM compiler
# $LLVM_TOOLCHAIN/clang -c -emit-llvm "$build_dir${output_file}.o" -o "${output_file}.bc"

# # Convert the LLVM bitcode to GraalVM bitcode using the GraalVM LLVM toolchain
# lli --convert "${output_file}.bc" -o "${output_file}.ll"

# # Execute the GraalVM bitcode on the GraalVM virtual machine
# lli "${output_file}.ll"
