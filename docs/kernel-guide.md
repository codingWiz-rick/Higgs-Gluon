# Android & Linux Kernel Compilation Guide

This guide covers building Android Generic Kernel Images (GKI), Qualcomm Snapdragon kernels, and mainline Linux using the **Higgs-Gluon Kernel Edition** toolchain.

---

## 1. Environment Setup

Add the **Higgs-Gluon Kernel Edition** binary directory to your `PATH`:

```bash
# Clone the kernel toolchain (or use local path):
git clone https://github.com/codingWiz-rick/higgs-gluon-kernel.git ~/toolchains/higgs-gluon-kernel

# Export PATH:
export PATH="$HOME/toolchains/higgs-gluon-kernel/bin:$PATH"

# Verify toolchain version:
clang --version
```

---

## 2. Compiling Android GKI Kernels (5.10, 6.1, 6.6)

In your kernel root directory:

```bash
# Clean previous build artifacts:
make mrproper

# Configure defconfig (e.g. gki_defconfig):
make ARCH=arm64 gki_defconfig

# Compile kernel Image and modules:
make -j$(nproc) \
     ARCH=arm64 \
     LLVM=1 \
     LLVM_IAS=1 \
     Image modules
```

---

## 3. Compiling Qualcomm Snapdragon Kernels (MSM8937 / SM6225 / etc.)

For legacy and vendor Snapdragon kernels with 32-bit vDSO support:

```bash
make -j$(nproc) \
     ARCH=arm64 \
     SUBARCH=arm64 \
     CC=clang \
     LD=ld.lld \
     AR=llvm-ar \
     NM=llvm-nm \
     OBJCOPY=llvm-objcopy \
     OBJDUMP=llvm-objdump \
     READELF=llvm-readelf \
     STRIP=llvm-strip \
     CROSS_COMPILE=aarch64-linux-gnu- \
     CROSS_COMPILE_COMPAT=arm-linux-gnueabi- \
     LLVM=1 \
     LLVM_IAS=1 \
     Image.gz-dtb dtbo.img
```

---

## 4. Key Compiler Flags for High Performance

- `LLVM=1`: Instructs the kernel build system to use `clang`, `ld.lld`, `llvm-ar`, `llvm-nm`, and `llvm-objcopy` across all compilation stages.
- `LLVM_IAS=1`: Enables Clang's integrated assembler for faster parsing and optimized machine code generation.
- `LD=ld.lld`: Uses the LLVM high-performance ELF linker with multi-threaded section layout.
