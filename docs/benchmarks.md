# Higgs-Gluon Performance & Telemetry Benchmarks

## 1. Full Kernel Build: Android GKI 6.1 (AArch64)

Testing conducted on an **AMD Ryzen 7 6800HS** (8 cores / 16 threads, Zen 3+, 16MB L3, DDR5-4800 RAM, Fedora Linux 44) executing a full cold-cache compilation of the **Android Generic Kernel Image (GKI 6.1)** under Linux hardware performance counters (`perf stat`):

| Toolchain | Binary Linkage | Total Build Time | Core IPC | L1-iCache Misses | Branch Miss Rate | Output Image |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| **Higgs-Gluon BOLT** | **100% Static (283 MB)** | **240.49s** | **0.96 IPC** | 13.69 B | **4.38%** | **37 MB** |
| **Higgs-Gluon Release** | **100% Static (347 MB)** | **248.98s** | **0.95 IPC** | 12.35 B | **4.40%** | **37 MB** |
| **Neutron Clang 24** | Dynamic Host (87 MB) | 252.02s | 0.94 IPC | 10.51 B | 4.39% | 37 MB |

> [!TIP]
> **Measured Result**: In a full 16-threaded GKI 6.1 kernel build, **Higgs-Gluon BOLT** completed compilation in **240.49s** compared to Neutron Clang 24's **252.02s** (an 11.53s reduction in build time) with an average **0.96 IPC**, while operating as a self-contained static executable with no host library dependencies.

---

## 2. Micro-Benchmark Telemetry (ARM64 Kernel Subsystems, 50 Iterations)

Hardware performance counters measured via `perf stat` compiling kernel core subsystems (CFS Scheduler, ChaCha20/Murmur3 Crypto, SLUB Allocator, SIMD Vector loops) with `-target aarch64-linux-gnu -O3`:

| Toolchain | Total Wall Time | Throughput | Peak RSS | Page Faults | Startup Latency | L1-iCache Misses | i-MPKI | Branch Miss Rate |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Higgs-Gluon Release** | **697 ms** | **71.7 units/s** | 72.9 MB | 2,272 | **6.9 ms** | 68,387 | 0.90 | 4.84% |
| **Neutron Clang 24** | 774 ms | 64.6 units/s | 57.1 MB | 1,269 | 27.0 ms | 55,518 | 0.97 | 5.55% |
| **Proton Clang 13** | 774 ms | 64.6 units/s | 48.5 MB | 1,779 | 5.3 ms | 70,515 | 1.13 | 5.97% |
| **Higgs-Gluon BOLT** | 850 ms | 58.8 units/s | 62.7 MB | 2,278 | 11.4 ms | 67,843 | **0.89** | 4.82% |
| **Google AOSP Clang 18** | 955 ms | 52.4 units/s | 47.3 MB | 2,982 | 8.5 ms | 84,775 | 1.14 | 6.20% |
| **Higgs-Gluon Bootstrap (No PGO)** | 1030 ms | 48.5 units/s | 71.2 MB | 2,367 | 7.2 ms | 123,327 | 1.35 | 4.91% |

---

## 3. Hardware Testbench Configuration

- **Host Machine**: ASUS ROG Zephyrus G14 (GA402RK)
- **CPU**: AMD Ryzen 7 6800HS (8 Cores, 16 Threads, up to 4.7 GHz, Zen 3+)
- **Memory**: 16 GB DDR5-4800 Dual-Channel
- **OS**: Fedora Linux 44 (Rawhide), Kernel 7.1.3
- **Test Workloads**: Android Generic Kernel Image (GKI 6.1.75 LTS), Qualcomm MSM8937 (Linux 4.19), Qualcomm SM6225 (Linux 4.19).
