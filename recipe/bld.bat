@echo on
REM # filename: bld.bat

REM # build bindgen directory
cd rust
cargo build --release -p bindgen --target wasm32-wasip1
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
cd ..

REM # build the wasm component
cargo install wasm-tools
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
wasm-tools component new .\rust\target\wasm32-wasip1\release\bindgen.wasm --adapt wasi_snapshot_preview1=.\ci\wasi_snapshot_preview1.reactor.wasm -o .\rust\target\component.wasm
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

REM # bootstrapping with native platform
cd rust
cargo run -p=bindgen --features=cli .\target\component.wasm ..\wasmtime\bindgen\generated
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
cd ..

%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%