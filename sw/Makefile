# Copyright 2019 Clifford Wolf
# Copyright 2019 Robert Balas
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

# Author: Robert Balas (balasr@iis.ee.ethz.ch)

MAKE                       = make

# riscv toolchain install path
RISCV                      ?= ~/.riscv
RISCV_EXE_PREFIX           = $(RISCV)/bin/riscv32-unknown-elf-

TARGET                     ?= sim

# GCC configuration
CUSTOM_GCC_FLAGS           = -DPERF_CNT_CYCLES=1

INC_FOLDERS_GCC             = $(addprefix -I ,$(INC_FOLDERS))
LIB_CRT                    = $(wildcard device/lib/crt/crt0.S)
LIB_CRT                    += $(wildcard device/lib/crt/vectors.S)
LIB_CRT_FLASH_EXEC         = $(wildcard device/lib/crt_flash_exec/*.S)
LIB_CRT_FLASH_LOAD         = $(wildcard device/lib/crt_flash_load/*.S)
LIB_BASE                   = $(wildcard device/lib/base/*.c)
LIB_BASE_FREESTD           = device/lib/base/freestanding
LIB_RUNTIME                = $(wildcard device/lib/runtime/*.c)
LIB_DRIVERS                = $(wildcard device/lib/drivers/soc_ctrl/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/uart/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/rv_plic/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/rv_timer/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/gpio/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/i2c/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/dma/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/power_manager/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/fast_intr_ctrl/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/spi_mem/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/spi_host/*.c)
LIB_DRIVERS                += $(wildcard device/lib/drivers/pad_control/*.c)
INC_FOLDERS                = $(sort $(dir $(wildcard device/target/$(TARGET)/)))
INC_FOLDERS                += $(sort $(dir $(wildcard device/lib/drivers/*/)))
INC_FOLDERS                += $(sort $(dir $(wildcard device/lib/base/)))
INC_FOLDERS                += $(sort $(dir $(wildcard device/lib/runtime/)))
INC_FOLDERS                += $(sort $(dir $(wildcard device/lib/crt/)))
INC_FOLDERS                += $(sort $(dir $(wildcard external/lib/drivers/*/)))
INC_FOLDERS                += $(sort $(dir $(wildcard external/lib/runtime/)))

		
$(info "Compiling $(ACC)-$(SCHEME)-$(ALG)-$(VERSION)")
INC_FOLDERS                 += $(sort $(dir $(wildcard applications/$(ACC)/$(SCHEME)/$(ALG)/$(VERSION)/include/*.h)))
INC_FOLDERS                 += $(sort $(dir $(wildcard applications/$(ACC)/$(SCHEME)/$(ALG)/common/include/*.h)))
LIB_DRIVERS 				+= $(wildcard applications/$(ACC)/$(SCHEME)/$(ALG)/$(VERSION)/src/*.c)


# Rules to generate hex (loadable by simulators) from elf
%.hex: %.elf
	$(RISCV_EXE_PREFIX)objcopy -O verilog $< $@

%.flash_exec.hex: %.flash_exec.elf
	$(RISCV_EXE_PREFIX)objcopy -O verilog --adjust-vma=-0x40000000 $< $@

%.flash_load.hex: %.flash_load.elf
	$(RISCV_EXE_PREFIX)objcopy -O verilog --adjust-vma=-0x40000000 $< $@

%.dis: %.elf
	$(RISCV_EXE_PREFIX)objdump -S $^ > $@

%.dump: %.elf
	$(RISCV_EXE_PREFIX)objdump -xD $^ > $@

x_heep_applications/hello_world/hello_world.elf: x_heep_applications/hello_world/main.c
	$(RISCV_EXE_PREFIX)gcc -march=rv32imc -o $@ -w -Os -g -nostdlib -D USE_DMA=$(USE_DMA)\
		$(CUSTOM_GCC_FLAGS) \
		-DHOST_BUILD \
		-T linker/link.ld \
		-I $(RISCV)/riscv32-unknown-elf/include \
		$(INC_FOLDERS_GCC) \
		-static \
		$(LIB_CRT) \
		$^ $(LIB_RUNTIME) \
		$(LIB_BASE) \
		$(LIB_DRIVERS) \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc -flto -ffunction-sections -fdata-sections -specs=nano.specs


applications/$(ACC)/$(SCHEME)/$(ALG)/$(VERSION)/main.elf: applications/$(ACC)/$(SCHEME)/$(ALG)/$(VERSION)/main.c
	$(RISCV_EXE_PREFIX)gcc -march=rv32imc -o $@ -w -O2 -g -nostdlib \
		$(CUSTOM_GCC_FLAGS) \
		-DHOST_BUILD \
		-DPQCLEAN_NAMESPACE=PQCLEAN_$(SCHEME_UPPERCASE)_CLEAN \
		-T linker/link.ld \
		-I $(RISCV)/riscv32-unknown-elf/include \
		$(INC_FOLDERS_GCC) \
		-static \
		$(LIB_CRT) \
		$^ $(LIB_RUNTIME) \
		$(LIB_BASE) \
		$(LIB_DRIVERS) \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc -flto -ffunction-sections -fdata-sections -specs=nano.specs
	size $@



clean:
	rm -rf applications/*/*.elf \
	rm -rf applications/*/*.hex \
	rm -rf applications/*/*.dis \
	rm -rf applications/*/*.map \
	rm -rf applications/*/*.dump \
	rm -rf x_heep_applications/*/*.elf \
	rm -rf x_heep_applications/*/*.hex \
	rm -rf x_heep_applications/*/*.dis \
	rm -rf x_heep_applications/*/*.map \
	rm -rf x_heep_applications/*/*.dump \
	rm -rf applications/original/LWC/ASCON/*/*.elf \
	rm -rf applications/original/LWC/ASCON/*/*.hex \
	rm -rf applications/original/LWC/ASCON/*/*.dis \
	rm -rf applications/original/LWC/ASCON/*/*.map \
	rm -rf applications/original/LWC/ASCON/*/*.dump \
	rm -rf applications/optimized/LWC/ASCON/*/*.elf \
	rm -rf applications/optimized/LWC/ASCON/*/*.hex \
	rm -rf applications/optimized/LWC/ASCON/*/*.dis \
	rm -rf applications/optimized/LWC/ASCON/*/*.map \
	rm -rf applications/optimized/LWC/ASCON/*/*.dump 