# Embedded Linux & Musl Cross-Compilation Guide

This guide covers building lightweight embedded Linux binaries, root filesystems, and C/C++ applications using the **Higgs-Gluon Embedded Edition (Musl)** toolchain.

---

## 1. Environment Setup

Add the **Higgs-Gluon Embedded Edition** binary directory to your `PATH`:

```bash
# Clone the embedded toolchain:
git clone https://github.com/codingWiz-rick/higgs-gluon-musl.git ~/toolchains/higgs-gluon-musl

# Export PATH:
export PATH="$HOME/toolchains/higgs-gluon-musl/bin:$PATH"

# Verify cross-compiler:
aarch64-higgs-gluon-linux-musl-clang --version
```

---

## 2. Basic Compilation

### Compiling Dynamic Executables (against Musl `libc.so`)
```bash
aarch64-higgs-gluon-linux-musl-clang -O2 -pipe main.c -o app
```

### Compiling 100% Fully Static Executables
```bash
aarch64-higgs-gluon-linux-musl-clang -O2 -pipe -static main.c -o app_static
```

---

## 3. Autotools & CMake Cross-Compilation

### Using with GNU Autotools (`./configure`)
```bash
export CC=aarch64-higgs-gluon-linux-musl-clang
export CXX=aarch64-higgs-gluon-linux-musl-clang++
export AR=llvm-ar
export NM=llvm-nm
export STRIP=llvm-strip
export RANLIB=llvm-ranlib

./configure --host=aarch64-higgs-gluon-linux-musl --prefix=/usr
make -j$(nproc)
```

### Using with CMake (`toolchain.cmake`)
```cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(CMAKE_C_COMPILER aarch64-higgs-gluon-linux-musl-clang)
set(CMAKE_CXX_COMPILER aarch64-higgs-gluon-linux-musl-clang++)
set(CMAKE_AR llvm-ar)
set(CMAKE_RANLIB llvm-ranlib)
```
