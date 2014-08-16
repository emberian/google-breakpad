# should have been executed by sh

if [ $(uname) != "Linux" ]; then
    echo "Rust breakpad glue not supported on non-Linux platforms!"
    exit 1
fi

./configure
make -j4
if [ $CXX = "" ]; then
    CXX = c++
fi
"$CXX" $CXXFLAGS -O -static
clang++ -c -static -pthread -I src rust_breakpad_linux.cc
ar rcs librust_breakpad_client.a rust_breakpad_linux.o
ar rcx librust_breakpad_client.a src/client/linux/libbreakpad_client.a

cp librust_breakpad_client.a "$OUT_DIR"
