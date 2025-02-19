# Copyright PoliTO contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0


# Makefile to generates keccak-x-heep files and build the design with fusesoc

MAKE                       = make
ROOT_DIR			:= $(realpath .)
BUILD_DIR			:= $(ROOT_DIR)/build
LOG_DIR				:= $(BUILD_DIR)/logs

# Get the absolute path
mkfile_path := $(shell dirname "$(realpath $(firstword $(MAKEFILE_LIST)))")


# Target options are 'sim' (default) and 'pynq-z2'
TARGET   			?= sim

# Linker options are 'on_chip' (default),'flash_load','flash_exec','freertos'
LINKER   			?= on_chip

# X-HEEP configuration
HEEP				?= $(ROOT_DIR)/hw/vendor/esl_epfl_x_heep
MCU_CFG				?= $(ROOT_DIR)/config/mcu-gen.hjson
PAD_CFG				?= $(ROOT_DIR)/config/heep-pads.hjson
APP_DIR				:= $(ROOT_DIR)/sw/applications
EXTERNAL_DOMAINS 	:= 1 
MCU_GEN_OPTS		:= \
	MCU_CFG=$(MCU_CFG) \
	PAD_CFG=$(PAD_CFG) \
	EXTERNAL_DOMAINS=$(EXTERNAL_DOMAINS)
MCU_GEN_LOCK		:= $(BUILD_DIR)/.mcu-gen.lock

# RTL simulation configuration
FIRMWARE 			?= $(ROOT_DIR)/sw/build/main.hex
BYPASS_FLL			?= 1 # 0: use FLL, 1: bypass FLL
FUSESOC_FLAGS		?=
FUSESOC_ARGS		?=

# Application-specific makefile
APP_MAKE  			:= $(wildcard sw/applications/$(PROJECT)/*akefile)
APP_MAKE_PARAMS		?=

# Compiler options are 'gcc' (default) and 'clang'
COMPILER ?= gcc
# Compiler prefix options are 'riscv32-unknown-' (default)
COMPILER_PREFIX ?= riscv32-unknown-
# Arch options are any RISC-V ISA string supported by the CPU. Default 'rv32imc'
ARCH     ?= rv32imc
# Path relative from the location of sw/Makefile from which to fetch source files. The directory of that file is the default value.
SOURCE 	 ?= "."
# 1 external domain for the KECCAK
EXTERNAL_DOMAINS = 1
# Keccak application flags
USE_DMA   ?= 1

ifndef CONDA_DEFAULT_ENV
$(info USING VENV)
FUSESOC = $(PWD)/$(VENV)/fusesoc
PYTHON  = $(PWD)/$(VENV)/python
else
$(info USING MINICONDA $(CONDA_DEFAULT_ENV))
FUSESOC := $(shell which fusesoc)
PYTHON  := $(shell which python)
endif


.PHONY: vendor-update-heep
vendor-update-heep: clean-lock
	@echo "### Updating vendored IPs..."
	find hw/vendor -maxdepth 1 -type f -name "esl_*.vendor.hjson" -exec python3 util/vendor.py -vU '{}' \;

x_heep-sync:
	@echo "### Modifiying esl_epfl_x_heep repository..."
	rsync -a config/x_heep_system.sv hw/vendor/esl_epfl_x_heep/hw/system/x_heep_system.sv
	rsync -a config/core_v_mini_mcu.sv hw/vendor/esl_epfl_x_heep/hw/core-v-mini-mcu/core_v_mini_mcu.sv
	rsync -a config/cpu_subsystem.sv hw/vendor/esl_epfl_x_heep/hw/core-v-mini-mcu/cpu_subsystem.sv

mcu-gen:
	@sed -i 's/stack_size: 0x[0-9a-fA-F]*,/stack_size: 0x35000,/g' hw/vendor/esl_epfl_x_heep/mcu_cfg.hjson
	@sed -i 's/heap_size: 0x[0-9a-fA-F]*,/heap_size: 0x35000,/g' hw/vendor/esl_epfl_x_heep/mcu_cfg.hjson
#	@sed -i 's/CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {[0-9]\+}/CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50}/g' hw/vendor/esl_epfl_x_heep/hw/fpga/scripts/zcu104/xilinx_generate_clk_wizard.tcl
	$(MAKE) -f $(XHEEP_MAKE) $(MAKECMDGOALS) CPU=cv32e40px BUS=NtoM MEMORY_BANKS=16 EXTERNAL_DOMAINS=$(EXTERNAL_DOMAINS)


# Applications
app-helloworld:
	$(MAKE) -C sw x_heep_applications/hello_world/hello_world.hex  TARGET=$(TARGET)

app-$(ACC)-$(SCHEME)-$(ALG)-$(VERSION):
	$(MAKE) -C sw applications/$(ACC)/$(SCHEME)/$(ALG)/$(VERSION)/main.hex 
	@echo "### DONE! App app-$(ACC)-$(SCHEME)-$(ALG)-$(VERSION) generated successfully for $(ACC)-version!"


#  riscv32-unknown-elf-objdump -d applications/vendor/CRYPTO-VLSI-SW/original/$(SCHEME)/$(ALG)/$(VERSION)/main.elf > dis/test-$(SCHEME)-$(ALG)-$(VERSION).s

# Simulation
questasim-sim:
	$(FUSESOC) --cores-root . run --no-export --target=sim --tool=modelsim $(FUSESOC_FLAGS) --setup --build vlsi:polito:mcu_chimera 2>&1 | tee buildsim.log

verilator-sim: 
	fusesoc --cores-root . run --no-export --target=sim --tool=verilator $(FUSESOC_FLAGS) --setup --build vlsi:polito:mcu_chimera 2>&1 | tee buildsim.log

run-helloworld-questasim: questasim-sim app-helloworld
	cd ./build/vlsi_polito_mcu_chimera_0/sim-modelsim; \
	make run PLUSARGS="c firmware=../../../sw/x_heep_applications/hello_world/hello_world.hex"; \
	cat uart0.log; \
	cd ../../..;

run-helloworld-verilator: verilator-sim app-helloworld
	cd ./build/vlsi_polito_mcu_chimera_0/sim-verilator; \
	./Vtestharness +firmware=../../../sw/x_heep_applications/hello_world/hello_world.hex; \
	cat uart0.log; \
	cd ../../..;

run-$(ACC)-$(SCHEME)-$(ALG)-$(VERSION):
	cd ./build/vlsi_polito_mcu_chimera_0/sim-modelsim; \
	make run PLUSARGS="c firmware=../../../sw/applications/$(ACC)/$(SCHEME)/$(ALG)/$(VERSION)/main.hex"; \
	cat uart0.log; \
	cd ../../..;

## @section Vivado

## Builds (synthesis and implementation) the bitstream for the FPGA version using Vivado
## @param FPGA_BOARD=nexys-a7-100t,pynq-z2
## @param FUSESOC_FLAGS=--flag=<flagname>

## @section Design Compiler
asic:
	$(FUSESOC) --cores-root . run --no-export --target=asic_synthesis $(FUSESOC_FLAGS) --setup vlsi:polito:mcu_chimera ${FUSESOC_PARAM} 2>&1 | tee builddesigncompiler.log

vivado-keccak-fpga:
	$(FUSESOC) --cores-root . run --no-export --target=$(FPGA_BOARD) $(FUSESOC_FLAGS) --setup --build vlsi:polito:mcu_chimera 2>&1 | tee buildvivado.log

vivado-keccak-fpga-nobuild:
	$(FUSESOC) --cores-root . run --no-export --target=$(FPGA_BOARD) $(FUSESOC_FLAGS) --setup vlsi:polito:mcu_chimera 2>&1 | tee buildvivado.log



# Clean rules
.PHONY: clean clean-build clean-app clean-lock
clean: clean-app clean-sim clean-build

clean-sim:
	@rm -rf build
clean-app:
	$(MAKE) -C sw clean
clean-build:
	$(RM) -rf $(BUILD_DIR)
clean-lock:
	$(RM) $(BUILD_DIR)/.*.lock


export HEEP_DIR = hw/vendor/esl_epfl_x_heep/
XHEEP_MAKE = $(HEEP_DIR)external.mk
#include $(XHEEP_MAKE)

