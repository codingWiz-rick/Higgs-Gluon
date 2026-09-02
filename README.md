```
  _    _ _                 _____ _                     
 | |  | (_)               / ____| |                    
 | |__| |_  __ _  __ _ __| |  __| |_   _  ___  _ __   
 |  __  | |/ _` |/ _` / __| | |_ | | | | |/ _ \| '_ \  
 | |  | | | (_| | (_| \__ \ |__| | | |_| | (_) | | | | 
 |_|  |_|_|\__, |\__, |___/\_____|_|\__,_|\___/|_| |_| 
            __/ | __/ |                                
           |___/ |___/   [HIGGS-GLUON MASTER TOOLCHAIN SUITE]
```

# Higgs-Gluon Toolchain Suite

[![Target Architecture](https://img.shields.io/badge/Architecture-AArch64%20(Little--Endian)-722ed1.svg?style=flat-square)]()
[![LLVM Version](https://img.shields.io/badge/LLVM-24.0.0git-2f54eb.svg?style=flat-square&logo=llvm)](https://github.com/llvm/llvm-project)
[![Musl Version](https://img.shields.io/badge/Musl%20Libc-1.2.6-009688.svg?style=flat-square)](https://musl.libc.org/)
[![Host Linkage](https://img.shields.io/badge/Host%20Linkage-100%25%20Static%20(Portable)-fa8c16.svg?style=flat-square)]()
[![License](https://img.shields.io/badge/License-Apache%202.0%20%2F%20MIT-fadb14.svg?style=flat-square)](LICENSE)

> [!NOTE]
> **Higgs-Gluon** is an umbrella suite of high-performance, 100% statically linked cross-compilation toolchains targeting **AArch64 (ARM64 Little-Endian)** architectures. The suite is engineered to provide specialized, production-ready toolchain distributions for kernel engineering, embedded Linux systems, and native Android development.

---

## Suite Architecture & Portfolio

```
                                  ╔═══════════════════════════════════════════════════════════════╗
                                  ║                          HIGGS-GLUON                          ║
                                  ║                (Master Toolchain Suite Brand)                 ║
                                  ╚══════════════════════════════╦════════════════════════════════╝
                                                                 ║
              ╔══════════════════════════════════════════════════╬══════════════════════════════════════════════════╗
              ▼                                                  ▼                                                  ▼
┌───────────────────────────────┐              ┌──────────────────────────────────┐               ┌──────────────────────────────────┐
│        1. KERNEL SUITE        │              │        2. EMBEDDED SUITE         │               │          3. NDK SUITE            │
│   (CS-PGO + BOLT + ThinLTO)   │              │           (Musl Libc)            │               │      (Android Bionic / NDK)      │
├───────────────────────────────┤              ├──────────────────────────────────┤               ├──────────────────────────────────┤
│ • Focus: Android/Linux Kernels│              │ • Focus: Embedded Linux Userspace│               │ • Focus: Native Android Apps/CLI │
│ • C Library: Freestanding     │              │ • C Library: Musl 1.2.6          │               │ • C Library: Android Bionic Libc │
│ • Target: aarch64-linux-gnu-  │              │ • Target: aarch64-higgs_gluon-   │               │ • Target: aarch64-linux-android- │
│ • Host: 100% Static (Jemalloc)│              │           linux-musl             │               │ • Status: On Roadmap             │
│ • Submodule:                  │              │ • Submodules:                    │               │                                  │
│   higgs-gluon-kernel          │              │   🔹 higgs-gluon-musl-clang      │               │                                  │
│ • Status: Released & Live     │              │   🔹 higgs-gluon-musl-gcc (TBD)  │               │                                  │
│                               │              │ • Status: Released & Live        │               │                                  │
└───────────────────────────────┘              └──────────────────────────────────┘               └──────────────────────────────────┘
```

---

## Toolchain Editions & Submodules

### 1. [Higgs-Gluon Kernel Edition](higgs-gluon-kernel)
* **Repository Submodule**: [`higgs-gluon-kernel`](higgs-gluon-kernel) / [`codingWiz-rick/higgs-gluon-kernel`](https://github.com/codingWiz-rick/higgs-gluon-kernel)
* **Engine**: LLVM 24.0.0git + 2-Tier Context-Sensitive PGO + BOLT (Ext-TSP / CDSort) + Cross-module ThinLTO + Embedded Jemalloc.
* **Target Focus**: Android Generic Kernel Images (GKI 5.10, 6.1, 6.6), Qualcomm Snapdragon (MSM8937, SM6225 Bengal), and Upstream Mainline Linux.
* **Performance**: **240.49s** GKI 6.1 compilation (0.96 IPC) vs Neutron Clang's 252.02s.

### 2. [Higgs-Gluon Musl Clang Edition](higgs-gluon-musl-clang)
* **Repository Submodule**: [`higgs-gluon-musl-clang`](higgs-gluon-musl-clang) / [`codingWiz-rick/higgs-gluon-musl-clang`](https://github.com/codingWiz-rick/higgs-gluon-musl-clang)
* **Engine**: 100% Static Clang 24 toolchain bundled with **Musl 1.2.6** libc, Compiler-RT builtins, and full ARM64 target sysroot.
* **Target Focus**: Raspberry Pi (3/4/5), `systemd-nspawn` container environments, single-board computers, and secure static userspace binaries.
* **Target Tuple**: `aarch64-higgs_gluon-linux-musl` *(with `aarch64-higgs-gluon-linux-musl` aliases)*

### 3. Higgs-Gluon Musl GCC Edition *(Planned)*
* **Target Focus**: Complete GNU GCC + Musl toolchain variant for legacy C/C++ codebases requiring GCC extensions.

### 4. Higgs-Gluon NDK Edition *(Roadmap)*
* **Target Focus**: Native Android CLI daemons, Magisk modules, and native C/C++ applications linked against Android Bionic libc across API levels 29–36 (Android 10–16).

---

## Hardware & Architecture Support

All Higgs-Gluon toolchains are built and optimized for **Little-Endian AArch64 (ARMv8-A / ARMv8.2-A+)**:

| Microarchitecture / Platform | Target Devices | Optimization Profile |
| :--- | :--- | :--- |
| **ARM Cortex-A53** | Xiaomi Redmi 8 (mi439), Snapdragon 439, Raspberry Pi 3 | `-mcpu=cortex-a53+crc+crypto` |
| **ARM Cortex-A57 / A72 / A73 / A75** | Qualcomm SM6225, Snapdragon 680, Raspberry Pi 4/5 | `-mcpu=cortex-a57` / `-mcpu=cortex-a72` |
| **ARMv8-A Generic** | All 64-bit ARM Linux/Android Devices | `-march=armv8-a+crc+crypto` |

---

## Documentation & Guides

Detailed guides for building with each toolchain edition:

- 📊 [**Performance & Telemetry Benchmarks**](docs/benchmarks.md) — Real cold-cache GKI 6.1 build benchmarks & hardware performance counters (`perf stat`).
- 🐧 [**Kernel Compilation Guide**](docs/kernel-guide.md) — Instructions for compiling Android GKI, Qualcomm vendor kernels, and Mainline Linux.
- 📦 [**Embedded Musl Guide**](docs/embedded-guide.md) — Cross-compiling lightweight dynamic and static userspace binaries targeting Musl libc.

---

## Cloning the Full Suite

To clone the master repository along with all toolchain submodules:

```bash
git clone --recurse-submodules https://github.com/codingWiz-rick/Higgs-Gluon.git
```

Or clone individual sub-repositories directly:

```bash
# Clone the Kernel Toolchain:
git clone https://github.com/codingWiz-rick/higgs-gluon-kernel.git

# Clone the Embedded Musl Clang Toolchain:
git clone https://github.com/codingWiz-rick/higgs-gluon-musl-clang.git
```

---

## License

The **Higgs-Gluon Toolchain Suite** is distributed under the **Apache License v2.0 with LLVM Exceptions**. Musl libc components are licensed under the **MIT License**.
