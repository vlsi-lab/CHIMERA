# CHIMERA

## Overview

CHIMERA is an ASIP designed for ASCON encryption on 32-bit RISC processors, interfacing via CV-X-IF. It supports AEAD (ASCON-128, ASCON-128a) and hashing (Hash, Hasha). Implemented on Zynq Ultrascale+ FPGA and ASIC platforms.
CHIMERA is evaluated on FPGA and ASIC, comparing CR and BRU versions against state-of-the-art solutions.

## Branches

- CR
  - High-performance, higher hardware cost.
  - Uses a dedicated 320-bit state register file to minimize memory access.
  - Custom instructions for permutation, load, and store operations.
- BRU
  - Lower efficiency, minimal area.
  - Optimizes bitwise rotation in ASCON’s Linear Diffusion Layer.
  - Uses scalar register file and six custom instructions.
  - Fixed shifting constants for area efficiency.


## Getting started

Once you have cloned the repository:
```
make mcu-gen
make x_heep-sync
make questasim-sim
```

Then, depending on the applications you want to run, you need to do:
```
make app-$(ACC)-LWC-ASCON-$(VERSION) SCHEME=LWC ALG=ASCON VERSION=$(VERSION)$ ACC=$(ACC)

make run-$(ACC)-LWC-ASCON-$(VERSION) SCHEME=LWC ALG=ASCON VERSION=$(VERSION)$ ACC=$(ACC)
```

With (ACC) = original, optimized, and (VERSION) = asconhashav12, asconhashv12, asconxofav12, asconxofv12, ascon128av12, ascon128v12, ascon80pqv12.

