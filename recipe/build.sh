#!/bin/bash
set -x
# cargo build --release --manifest-path rust/Cargo.toml

# downloads and puts things into bash profile and rc
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o script
# ls -l script
# sh script -y


rustup target add wasm32-wasip1
cargo install wasm-tools
#cargo install --target wasm32-wasip1 wasm-tools
#wasm-tools --help2
$PYTHON ci/build-rust.py
$PYTHON -m pip install . -vv  --no-deps --no-build-isolation 
# ls ${SRC_DIR}/rust/target/release/
# cp ${SRC_DIR}/rust/target/release/libbindgen.dylib ${PREFIX}/bin/
