// Copyright 2022 OpenHW Group
// Solderpad Hardware License, Version 2.1, see LICENSE.md for details.
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

#ifndef _POWER_MANAGER_H_
#define _POWER_MANAGER_H_

#include <stddef.h>
#include <stdint.h>

#include "mmio.h"
#include "power_manager_regs.h"


#ifdef __cplusplus
extern "C" {
#endif

/**
 * Results.
 */
typedef enum power_manager_result {
  kPowerManagerOk_e    = 0,
  kPowerManagerError_e = 1,
} power_manager_result_t;


/**
 * Domain states.
 */
typedef enum power_manager_sel_state {
  kOn_e     = 0,
  kOff_e    = 1,
  kRetOn_e  = 2,
  kRetOff_e = 3,
} power_manager_sel_state_t;

/**
 * Interrupt source.
 */
typedef enum power_manager_sel_intr {
  kTimer_0_pm_e  = 0,
  kPlic_pm_e     = 1,
  kTimer_1_pm_e  = 2,
  kTimer_2_pm_e  = 3,
  kTimer_3_pm_e  = 4,
  kDma_pm_e      = 5,
  kSpi_pm_e      = 6,
  kSpiFlash_pm_e = 7,
  kGpio_0_pm_e   = 8,
  kGpio_1_pm_e   = 9,
  kGpio_2_pm_e   = 10,
  kGpio_3_pm_e   = 11,
  kGpio_4_pm_e   = 12,
  kGpio_5_pm_e   = 13,
  kGpio_6_pm_e   = 14,
  kGpio_7_pm_e   = 15,
  kExt_0_pm_e    = 16,
  kExt_1_pm_e    = 17,
  kExt_2_pm_e    = 18,
  kExt_3_pm_e    = 19,
} power_manager_sel_intr_t;

/**
 * Monitor signals.
 */
typedef struct monitor_signals {
  uint32_t kSwitch_e;
  uint32_t kIso_e;
  uint32_t kReset_e;
} monitor_signals_t;

/**
 * Initialization parameters for POWER MANAGER.
 *
 */
typedef struct power_manager {
  /**
   * The base address for the power_manager hardware registers.
   */
  mmio_region_t base_addr;
} power_manager_t;

typedef struct power_manager_counters {
  /**
   * The counter to set and unset the reset and switch of the CPU.
   */
  uint32_t reset_off;
  uint32_t reset_on;
  uint32_t switch_off;
  uint32_t switch_on;
  uint32_t iso_off;
  uint32_t iso_on;
  uint32_t retentive_off;
  uint32_t retentive_on;
} power_manager_counters_t;

typedef struct power_manager_ram_map_t {
  uint32_t clk_gate;
  uint32_t power_gate_ack;
  uint32_t switch_off;
  uint32_t wait_ack_switch;
  uint32_t iso;
  uint32_t retentive;
  uint32_t monitor_power_gate;
} power_manager_ram_map_t;

static power_manager_ram_map_t power_manager_ram_map[16] = {
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_0_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_0_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_0_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_0_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_0_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_0_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_0_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_1_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_1_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_1_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_1_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_1_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_1_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_1_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_2_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_2_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_2_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_2_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_2_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_2_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_2_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_3_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_3_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_3_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_3_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_3_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_3_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_3_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_4_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_4_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_4_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_4_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_4_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_4_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_4_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_5_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_5_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_5_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_5_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_5_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_5_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_5_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_6_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_6_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_6_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_6_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_6_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_6_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_6_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_7_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_7_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_7_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_7_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_7_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_7_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_7_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_8_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_8_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_8_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_8_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_8_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_8_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_8_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_9_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_9_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_9_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_9_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_9_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_9_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_9_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_10_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_10_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_10_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_10_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_10_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_10_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_10_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_11_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_11_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_11_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_11_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_11_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_11_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_11_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_12_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_12_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_12_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_12_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_12_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_12_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_12_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_13_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_13_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_13_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_13_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_13_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_13_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_13_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_14_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_14_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_14_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_14_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_14_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_14_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_14_REG_OFFSET
  },
  (power_manager_ram_map_t) {
    .clk_gate = POWER_MANAGER_RAM_15_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_RAM_BLOCK_15_ACK_REG_OFFSET,
    .switch_off = POWER_MANAGER_RAM_15_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_RAM_15_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_RAM_15_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_RAM_15_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_RAM_BLOCK_15_REG_OFFSET
  },
};

typedef struct power_manager_external_map_t {
  uint32_t clk_gate;
  uint32_t power_gate_ack;
  uint32_t reset;
  uint32_t switch_off;
  uint32_t wait_ack_switch;
  uint32_t iso;
  uint32_t retentive;
  uint32_t monitor_power_gate;
} power_manager_external_map_t;

static power_manager_external_map_t power_manager_external_map[1] = {
  (power_manager_external_map_t) {
    .clk_gate = POWER_MANAGER_EXTERNAL_0_CLK_GATE_REG_OFFSET,
    .power_gate_ack = POWER_MANAGER_POWER_GATE_EXTERNAL_0_ACK_REG_OFFSET,
    .reset = POWER_MANAGER_EXTERNAL_0_RESET_REG_OFFSET,
    .switch_off = POWER_MANAGER_EXTERNAL_0_SWITCH_REG_OFFSET,
    .wait_ack_switch = POWER_MANAGER_EXTERNAL_0_WAIT_ACK_SWITCH_ON_REG_OFFSET,
    .iso = POWER_MANAGER_EXTERNAL_0_ISO_REG_OFFSET,
    .retentive = POWER_MANAGER_EXTERNAL_RAM_0_RETENTIVE_REG_OFFSET,
    .monitor_power_gate = POWER_MANAGER_MONITOR_POWER_GATE_EXTERNAL_0_REG_OFFSET,
  },
};

power_manager_result_t power_gate_counters_init(power_manager_counters_t* counters, uint32_t reset_off, uint32_t reset_on, uint32_t switch_off, uint32_t switch_on, uint32_t iso_off, uint32_t iso_on, uint32_t retentive_off, uint32_t retentive_on);

power_manager_result_t power_gate_core(const power_manager_t *power_manager, power_manager_sel_intr_t sel_intr, power_manager_counters_t* cpu_counters);

power_manager_result_t power_gate_periph(const power_manager_t *power_manager, power_manager_sel_state_t sel_state, power_manager_counters_t* periph_counters);

power_manager_result_t power_gate_ram_block(const power_manager_t *power_manager, uint32_t sel_block, power_manager_sel_state_t sel_state, power_manager_counters_t* ram_block_counters);

power_manager_result_t power_gate_external(const power_manager_t *power_manager, uint32_t sel_external, power_manager_sel_state_t sel_state, power_manager_counters_t* external_counters);

uint32_t periph_power_domain_is_off(const power_manager_t *power_manager);

uint32_t ram_block_power_domain_is_off(const power_manager_t *power_manager, uint32_t sel_block);

uint32_t external_power_domain_is_off(const power_manager_t *power_manager, uint32_t sel_external);

monitor_signals_t monitor_power_gate_core(const power_manager_t *power_manager);

monitor_signals_t monitor_power_gate_periph(const power_manager_t *power_manager);

monitor_signals_t monitor_power_gate_ram_block(const power_manager_t *power_manager, uint32_t sel_block);

monitor_signals_t monitor_power_gate_external(const power_manager_t *power_manager, uint32_t sel_external);


#ifdef __cplusplus
}
#endif

#endif  // _POWER_MANAGER_H_
