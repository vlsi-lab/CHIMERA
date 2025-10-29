# CHIMERA: Cryptographic Hardware for Integrated Multipurpose Engine on RISC-V with ASCON

**CHIMERA** is a modular RISC-V hardware–software framework for accelerating the ASCON lightweight cryptographic suite, the NIST-selected standard for Lightweight Cryptography (LWC).
It integrates seamlessly with the [X-HEEP](https://github.com/esl-epfl/x-heep) SoC platform through the Core-V eXtension Interface (CV-X-IF), enabling high-efficiency, tightly coupled cryptographic acceleration.

The framework provides two hardware variants:

- **CR (Complete Round)** – a tightly coupled coprocessor with a dedicated register file for maximum performance.

- **BRU (Bitwise Rotation Unit)** – an ultra-lightweight Instruction Set Extension (ISE) optimized for minimal area usage.


## 📁 Repository Structure
```bash
CHIMERA/
├── config/         # Configuration files for builds and SoC setup
├── hw/             # Hardware modules (RTL, coprocessors, and interface logic)
├── scripts/        # Build and utility scripts
├── sw/             # Software applications and ASCON implementations
├── tb/             # Testbenches for hardware simulation
└── util/           # Utility files and helpers
```

## 🚀 Getting Started

Clone the repository and initialize the environment:
```
git clone <your_repo_url>
cd chimera
make mcu-gen
make x_heep-sync
make questasim-sim
```
Then, to build and run an application:
```
make app-$(ACC)-LWC-ASCON-$(VERSION) SCHEME=LWC ALG=ASCON VERSION=$(VERSION) ACC=$(ACC)
make run-$(ACC)-LWC-ASCON-$(VERSION) SCHEME=LWC ALG=ASCON VERSION=$(VERSION) ACC=$(ACC)
```

Where:
- $(ACC) = original | optimized

- $(VERSION) = asconhashav12, asconhashv12, asconxofav12, asconxofv12, ascon128av12, ascon128v12, ascon80pqv12


## ⚙️ Branch Overview

| **Branch** | **Description**                                                                                                                       |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| **main**   | Stable branch, includes reference CR/BRU designs and simulation scripts.                                                              |
| **CR**     | High-performance Complete Round coprocessor version, with a dedicated 320-bit state register file and custom load/store instructions. |
| **BRU**    | Compact Bitwise Rotation Unit (ISE) version, accelerating rotation-based linear diffusion operations with minimal area footprint.     |


### 🧠 Architecture Overview

CHIMERA integrates into X-HEEP through CV-X-IF, the standard OpenHW Group interface for RISC-V tightly coupled accelerators.

- **CR version**:

  - Implements full ASCON permutation over a 320-bit state.
  - Uses a dedicated state register bank to minimize memory access.
  - Achieves up to 6.0× speed-up vs. software.

- **BRU version**:

  - Implements a set of six custom instructions for ASCON’s diffusion layer rotations.
  - Designed for minimal area and low power.
  - Achieves 1.5× speed-up with only +12% area overhead.


# 📎Reference
To cite our paper:   
A. Dolmeta, V. Piscopo, M. Martina and G. Masera, "CHIMERA: Cryptographic Hardware for Integrated Multipurpose Engine on RISC-V with ASCON," 2025 IEEE Computer Society Annual Symposium on VLSI (ISVLSI), Kalamata, Greece, 2025, pp. 1-6, doi: 10.1109/ISVLSI65124.2025.11130264.

## 📄 License

This repository follows the licensing terms of the respective reference implementations used as the starting point. Please check individual algorithm directories for specific license details.


## 👥 Authors

- Alessandra Dolmeta    - alessandra.dolmeta@polito.it
- Valeria Piscopo       - valeria.piscopo@polito.it