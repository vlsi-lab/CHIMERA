/* Copyright 2018 ETH Zurich and University of Bologna.
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the “License”); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 *
 * Description: Contains common system definitions.
 *
 */

package core_v_mini_mcu_pkg;

  import addr_map_rule_pkg::*;
  import power_manager_pkg::*;

  typedef enum logic [1:0] {
    cv32e40p,
    cv32e20,
    cv32e40x,
    cv32e40px
  } cpu_type_e;

  localparam cpu_type_e CpuType = cv32e40px;

  typedef enum logic {
    NtoM,
    onetoM
  } bus_type_e;

  localparam bus_type_e BusType = NtoM;

  //master idx
  localparam logic [31:0] CORE_INSTR_IDX = 0;
  localparam logic [31:0] CORE_DATA_IDX = 1;
  localparam logic [31:0] DEBUG_MASTER_IDX = 2;
  localparam logic [31:0] DMA_READ_CH0_IDX = 3;
  localparam logic [31:0] DMA_WRITE_CH0_IDX = 4;
  localparam logic [31:0] DMA_ADDR_CH0_IDX = 5;

  localparam SYSTEM_XBAR_NMASTER = 6;

  // Internal slave memory map and index
  // -----------------------------------
  //must be power of two
  localparam int unsigned MEM_SIZE = 32'h00080000;

  localparam SYSTEM_XBAR_NSLAVE = 21;

  localparam int unsigned LOG_SYSTEM_XBAR_NMASTER = SYSTEM_XBAR_NMASTER > 1 ? $clog2(
      SYSTEM_XBAR_NMASTER
  ) : 32'd1;
  localparam int unsigned LOG_SYSTEM_XBAR_NSLAVE = SYSTEM_XBAR_NSLAVE > 1 ? $clog2(
      SYSTEM_XBAR_NSLAVE
  ) : 32'd1;

  localparam int unsigned NUM_BANKS = 16;
  localparam int unsigned NUM_BANKS_IL = 0;
  localparam int unsigned EXTERNAL_DOMAINS = 1;

  localparam logic [31:0] ERROR_START_ADDRESS = 32'hBADACCE5;
  localparam logic [31:0] ERROR_SIZE = 32'h00000001;
  localparam logic [31:0] ERROR_END_ADDRESS = ERROR_START_ADDRESS + ERROR_SIZE;
  localparam logic [31:0] ERROR_IDX = 32'd0;

  localparam logic [31:0] RAM0_IDX = 32'd1;
  localparam logic [31:0] RAM0_SIZE = 32'h00008000;
  localparam logic [31:0] RAM0_START_ADDRESS = 32'h00000000;
  localparam logic [31:0] RAM0_END_ADDRESS = 32'h00008000;
  localparam logic [31:0] RAM1_IDX = 32'd2;
  localparam logic [31:0] RAM1_SIZE = 32'h00008000;
  localparam logic [31:0] RAM1_START_ADDRESS = 32'h00008000;
  localparam logic [31:0] RAM1_END_ADDRESS = 32'h00010000;
  localparam logic [31:0] RAM2_IDX = 32'd3;
  localparam logic [31:0] RAM2_SIZE = 32'h00008000;
  localparam logic [31:0] RAM2_START_ADDRESS = 32'h00010000;
  localparam logic [31:0] RAM2_END_ADDRESS = 32'h00018000;
  localparam logic [31:0] RAM3_IDX = 32'd4;
  localparam logic [31:0] RAM3_SIZE = 32'h00008000;
  localparam logic [31:0] RAM3_START_ADDRESS = 32'h00018000;
  localparam logic [31:0] RAM3_END_ADDRESS = 32'h00020000;
  localparam logic [31:0] RAM4_IDX = 32'd5;
  localparam logic [31:0] RAM4_SIZE = 32'h00008000;
  localparam logic [31:0] RAM4_START_ADDRESS = 32'h00020000;
  localparam logic [31:0] RAM4_END_ADDRESS = 32'h00028000;
  localparam logic [31:0] RAM5_IDX = 32'd6;
  localparam logic [31:0] RAM5_SIZE = 32'h00008000;
  localparam logic [31:0] RAM5_START_ADDRESS = 32'h00028000;
  localparam logic [31:0] RAM5_END_ADDRESS = 32'h00030000;
  localparam logic [31:0] RAM6_IDX = 32'd7;
  localparam logic [31:0] RAM6_SIZE = 32'h00008000;
  localparam logic [31:0] RAM6_START_ADDRESS = 32'h00030000;
  localparam logic [31:0] RAM6_END_ADDRESS = 32'h00038000;
  localparam logic [31:0] RAM7_IDX = 32'd8;
  localparam logic [31:0] RAM7_SIZE = 32'h00008000;
  localparam logic [31:0] RAM7_START_ADDRESS = 32'h00038000;
  localparam logic [31:0] RAM7_END_ADDRESS = 32'h00040000;
  localparam logic [31:0] RAM8_IDX = 32'd9;
  localparam logic [31:0] RAM8_SIZE = 32'h00008000;
  localparam logic [31:0] RAM8_START_ADDRESS = 32'h00040000;
  localparam logic [31:0] RAM8_END_ADDRESS = 32'h00048000;
  localparam logic [31:0] RAM9_IDX = 32'd10;
  localparam logic [31:0] RAM9_SIZE = 32'h00008000;
  localparam logic [31:0] RAM9_START_ADDRESS = 32'h00048000;
  localparam logic [31:0] RAM9_END_ADDRESS = 32'h00050000;
  localparam logic [31:0] RAM10_IDX = 32'd11;
  localparam logic [31:0] RAM10_SIZE = 32'h00008000;
  localparam logic [31:0] RAM10_START_ADDRESS = 32'h00050000;
  localparam logic [31:0] RAM10_END_ADDRESS = 32'h00058000;
  localparam logic [31:0] RAM11_IDX = 32'd12;
  localparam logic [31:0] RAM11_SIZE = 32'h00008000;
  localparam logic [31:0] RAM11_START_ADDRESS = 32'h00058000;
  localparam logic [31:0] RAM11_END_ADDRESS = 32'h00060000;
  localparam logic [31:0] RAM12_IDX = 32'd13;
  localparam logic [31:0] RAM12_SIZE = 32'h00008000;
  localparam logic [31:0] RAM12_START_ADDRESS = 32'h00060000;
  localparam logic [31:0] RAM12_END_ADDRESS = 32'h00068000;
  localparam logic [31:0] RAM13_IDX = 32'd14;
  localparam logic [31:0] RAM13_SIZE = 32'h00008000;
  localparam logic [31:0] RAM13_START_ADDRESS = 32'h00068000;
  localparam logic [31:0] RAM13_END_ADDRESS = 32'h00070000;
  localparam logic [31:0] RAM14_IDX = 32'd15;
  localparam logic [31:0] RAM14_SIZE = 32'h00008000;
  localparam logic [31:0] RAM14_START_ADDRESS = 32'h00070000;
  localparam logic [31:0] RAM14_END_ADDRESS = 32'h00078000;
  localparam logic [31:0] RAM15_IDX = 32'd16;
  localparam logic [31:0] RAM15_SIZE = 32'h00008000;
  localparam logic [31:0] RAM15_START_ADDRESS = 32'h00078000;
  localparam logic [31:0] RAM15_END_ADDRESS = 32'h00080000;


  localparam logic [31:0] DEBUG_START_ADDRESS = 32'h10000000;
  localparam logic [31:0] DEBUG_SIZE = 32'h00100000;
  localparam logic [31:0] DEBUG_END_ADDRESS = DEBUG_START_ADDRESS + DEBUG_SIZE;
  localparam logic [31:0] DEBUG_IDX = 32'd17;

  localparam logic [31:0] AO_PERIPHERAL_START_ADDRESS = 32'h20000000;
  localparam logic [31:0] AO_PERIPHERAL_SIZE = 32'h00100000;
  localparam logic[31:0] AO_PERIPHERAL_END_ADDRESS = AO_PERIPHERAL_START_ADDRESS + AO_PERIPHERAL_SIZE;
  localparam logic [31:0] AO_PERIPHERAL_IDX = 32'd18;

  localparam logic [31:0] PERIPHERAL_START_ADDRESS = 32'h30000000;
  localparam logic [31:0] PERIPHERAL_SIZE = 32'h00100000;
  localparam logic [31:0] PERIPHERAL_END_ADDRESS = PERIPHERAL_START_ADDRESS + PERIPHERAL_SIZE;
  localparam logic [31:0] PERIPHERAL_IDX = 32'd19;

  localparam logic [31:0] FLASH_MEM_START_ADDRESS = 32'h40000000;
  localparam logic [31:0] FLASH_MEM_SIZE = 32'h01000000;
  localparam logic [31:0] FLASH_MEM_END_ADDRESS = FLASH_MEM_START_ADDRESS + FLASH_MEM_SIZE;
  localparam logic [31:0] FLASH_MEM_IDX = 32'd20;

  localparam addr_map_rule_t [SYSTEM_XBAR_NSLAVE-1:0] XBAR_ADDR_RULES = '{
      '{idx: ERROR_IDX, start_addr: ERROR_START_ADDRESS, end_addr: ERROR_END_ADDRESS},
      '{idx: RAM0_IDX, start_addr: RAM0_START_ADDRESS, end_addr: RAM0_END_ADDRESS},
      '{idx: RAM1_IDX, start_addr: RAM1_START_ADDRESS, end_addr: RAM1_END_ADDRESS},
      '{idx: RAM2_IDX, start_addr: RAM2_START_ADDRESS, end_addr: RAM2_END_ADDRESS},
      '{idx: RAM3_IDX, start_addr: RAM3_START_ADDRESS, end_addr: RAM3_END_ADDRESS},
      '{idx: RAM4_IDX, start_addr: RAM4_START_ADDRESS, end_addr: RAM4_END_ADDRESS},
      '{idx: RAM5_IDX, start_addr: RAM5_START_ADDRESS, end_addr: RAM5_END_ADDRESS},
      '{idx: RAM6_IDX, start_addr: RAM6_START_ADDRESS, end_addr: RAM6_END_ADDRESS},
      '{idx: RAM7_IDX, start_addr: RAM7_START_ADDRESS, end_addr: RAM7_END_ADDRESS},
      '{idx: RAM8_IDX, start_addr: RAM8_START_ADDRESS, end_addr: RAM8_END_ADDRESS},
      '{idx: RAM9_IDX, start_addr: RAM9_START_ADDRESS, end_addr: RAM9_END_ADDRESS},
      '{idx: RAM10_IDX, start_addr: RAM10_START_ADDRESS, end_addr: RAM10_END_ADDRESS},
      '{idx: RAM11_IDX, start_addr: RAM11_START_ADDRESS, end_addr: RAM11_END_ADDRESS},
      '{idx: RAM12_IDX, start_addr: RAM12_START_ADDRESS, end_addr: RAM12_END_ADDRESS},
      '{idx: RAM13_IDX, start_addr: RAM13_START_ADDRESS, end_addr: RAM13_END_ADDRESS},
      '{idx: RAM14_IDX, start_addr: RAM14_START_ADDRESS, end_addr: RAM14_END_ADDRESS},
      '{idx: RAM15_IDX, start_addr: RAM15_START_ADDRESS, end_addr: RAM15_END_ADDRESS},
      '{idx: DEBUG_IDX, start_addr: DEBUG_START_ADDRESS, end_addr: DEBUG_END_ADDRESS},
      '{
          idx: AO_PERIPHERAL_IDX,
          start_addr: AO_PERIPHERAL_START_ADDRESS,
          end_addr: AO_PERIPHERAL_END_ADDRESS
      },
      '{
          idx: PERIPHERAL_IDX,
          start_addr: PERIPHERAL_START_ADDRESS,
          end_addr: PERIPHERAL_END_ADDRESS
      },
      '{idx: FLASH_MEM_IDX, start_addr: FLASH_MEM_START_ADDRESS, end_addr: FLASH_MEM_END_ADDRESS}
  };

  // External slave address map
  // --------------------------
  localparam logic [31:0] EXT_SLAVE_START_ADDRESS = 32'hF0000000;
  localparam logic [31:0] EXT_SLAVE_SIZE = 32'h01000000;
  localparam logic [31:0] EXT_SLAVE_END_ADDRESS = EXT_SLAVE_START_ADDRESS + EXT_SLAVE_SIZE;

  // Forward crossbars address map and index
  // ---------------------------------------
  // These crossbar connect each muster to the internal crossbar and to the
  // corresponding external master port.
  localparam logic [31:0] DEMUX_XBAR_INT_SLAVE_IDX = 32'd0;
  localparam logic [31:0] DEMUX_XBAR_EXT_SLAVE_IDX = 32'd1;

  // Address map
  // NOTE: the internal address space is chosen by default by the system bus,
  // so it is not defined here.
  localparam addr_map_rule_t [0:0] DEMUX_XBAR_ADDR_RULES = '{
      '{
          idx: DEMUX_XBAR_EXT_SLAVE_IDX,
          start_addr: EXT_SLAVE_START_ADDRESS,
          end_addr: EXT_SLAVE_END_ADDRESS
      }
  };

  // always-on peripherals
  // ---------------------
  localparam AO_PERIPHERALS = 12;
  localparam DMA_CH_NUM = 1;

  localparam logic [31:0] SOC_CTRL_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00000000;
  localparam logic [31:0] SOC_CTRL_SIZE = 32'h00010000;
  localparam logic [31:0] SOC_CTRL_END_ADDRESS = SOC_CTRL_START_ADDRESS + SOC_CTRL_SIZE;
  localparam logic [31:0] SOC_CTRL_IDX = 32'd0;

  localparam logic [31:0] BOOTROM_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00010000;
  localparam logic [31:0] BOOTROM_SIZE = 32'h00010000;
  localparam logic [31:0] BOOTROM_END_ADDRESS = BOOTROM_START_ADDRESS + BOOTROM_SIZE;
  localparam logic [31:0] BOOTROM_IDX = 32'd1;

  localparam logic [31:0] SPI_FLASH_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00020000;
  localparam logic [31:0] SPI_FLASH_SIZE = 32'h00008000;
  localparam logic [31:0] SPI_FLASH_END_ADDRESS = SPI_FLASH_START_ADDRESS + SPI_FLASH_SIZE;
  localparam logic [31:0] SPI_FLASH_IDX = 32'd2;

  localparam logic [31:0] SPI_MEMIO_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00028000;
  localparam logic [31:0] SPI_MEMIO_SIZE = 32'h00008000;
  localparam logic [31:0] SPI_MEMIO_END_ADDRESS = SPI_MEMIO_START_ADDRESS + SPI_MEMIO_SIZE;
  localparam logic [31:0] SPI_MEMIO_IDX = 32'd3;

  localparam logic [31:0] DMA_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00030000;
  localparam logic [31:0] DMA_SIZE = 32'h00010000;
  localparam logic [31:0] DMA_END_ADDRESS = DMA_START_ADDRESS + DMA_SIZE;
  localparam logic [31:0] DMA_IDX = 32'd4;

  localparam logic [31:0] POWER_MANAGER_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00040000;
  localparam logic [31:0] POWER_MANAGER_SIZE = 32'h00010000;
  localparam logic [31:0] POWER_MANAGER_END_ADDRESS = POWER_MANAGER_START_ADDRESS + POWER_MANAGER_SIZE;
  localparam logic [31:0] POWER_MANAGER_IDX = 32'd5;

  localparam logic [31:0] RV_TIMER_AO_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00050000;
  localparam logic [31:0] RV_TIMER_AO_SIZE = 32'h00010000;
  localparam logic [31:0] RV_TIMER_AO_END_ADDRESS = RV_TIMER_AO_START_ADDRESS + RV_TIMER_AO_SIZE;
  localparam logic [31:0] RV_TIMER_AO_IDX = 32'd6;

  localparam logic [31:0] FAST_INTR_CTRL_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00060000;
  localparam logic [31:0] FAST_INTR_CTRL_SIZE = 32'h00010000;
  localparam logic [31:0] FAST_INTR_CTRL_END_ADDRESS = FAST_INTR_CTRL_START_ADDRESS + FAST_INTR_CTRL_SIZE;
  localparam logic [31:0] FAST_INTR_CTRL_IDX = 32'd7;

  localparam logic [31:0] EXT_PERIPHERAL_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00070000;
  localparam logic [31:0] EXT_PERIPHERAL_SIZE = 32'h00010000;
  localparam logic [31:0] EXT_PERIPHERAL_END_ADDRESS = EXT_PERIPHERAL_START_ADDRESS + EXT_PERIPHERAL_SIZE;
  localparam logic [31:0] EXT_PERIPHERAL_IDX = 32'd8;

  localparam logic [31:0] PAD_CONTROL_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00080000;
  localparam logic [31:0] PAD_CONTROL_SIZE = 32'h00010000;
  localparam logic [31:0] PAD_CONTROL_END_ADDRESS = PAD_CONTROL_START_ADDRESS + PAD_CONTROL_SIZE;
  localparam logic [31:0] PAD_CONTROL_IDX = 32'd9;

  localparam logic [31:0] GPIO_AO_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h00090000;
  localparam logic [31:0] GPIO_AO_SIZE = 32'h00010000;
  localparam logic [31:0] GPIO_AO_END_ADDRESS = GPIO_AO_START_ADDRESS + GPIO_AO_SIZE;
  localparam logic [31:0] GPIO_AO_IDX = 32'd10;

  localparam logic [31:0] UART_START_ADDRESS = AO_PERIPHERAL_START_ADDRESS + 32'h000A0000;
  localparam logic [31:0] UART_SIZE = 32'h00010000;
  localparam logic [31:0] UART_END_ADDRESS = UART_START_ADDRESS + UART_SIZE;
  localparam logic [31:0] UART_IDX = 32'd11;


  localparam addr_map_rule_t [AO_PERIPHERALS-1:0] AO_PERIPHERALS_ADDR_RULES = '{
      '{idx: SOC_CTRL_IDX, start_addr: SOC_CTRL_START_ADDRESS, end_addr: SOC_CTRL_END_ADDRESS},
      '{idx: BOOTROM_IDX, start_addr: BOOTROM_START_ADDRESS, end_addr: BOOTROM_END_ADDRESS},
      '{
          idx: SPI_FLASH_IDX,
          start_addr: SPI_FLASH_START_ADDRESS,
          end_addr: SPI_FLASH_END_ADDRESS
      },
      '{
          idx: SPI_MEMIO_IDX,
          start_addr: SPI_MEMIO_START_ADDRESS,
          end_addr: SPI_MEMIO_END_ADDRESS
      },
      '{idx: DMA_IDX, start_addr: DMA_START_ADDRESS, end_addr: DMA_END_ADDRESS},
      '{
          idx: POWER_MANAGER_IDX,
          start_addr: POWER_MANAGER_START_ADDRESS,
          end_addr: POWER_MANAGER_END_ADDRESS
      },
      '{
          idx: RV_TIMER_AO_IDX,
          start_addr: RV_TIMER_AO_START_ADDRESS,
          end_addr: RV_TIMER_AO_END_ADDRESS
      },
      '{
          idx: FAST_INTR_CTRL_IDX,
          start_addr: FAST_INTR_CTRL_START_ADDRESS,
          end_addr: FAST_INTR_CTRL_END_ADDRESS
      },
      '{
          idx: EXT_PERIPHERAL_IDX,
          start_addr: EXT_PERIPHERAL_START_ADDRESS,
          end_addr: EXT_PERIPHERAL_END_ADDRESS
      },
      '{
          idx: PAD_CONTROL_IDX,
          start_addr: PAD_CONTROL_START_ADDRESS,
          end_addr: PAD_CONTROL_END_ADDRESS
      },
      '{idx: GPIO_AO_IDX, start_addr: GPIO_AO_START_ADDRESS, end_addr: GPIO_AO_END_ADDRESS},
      '{idx: UART_IDX, start_addr: UART_START_ADDRESS, end_addr: UART_END_ADDRESS}
  };

  localparam int unsigned AO_PERIPHERALS_PORT_SEL_WIDTH = AO_PERIPHERALS > 1 ? $clog2(
      AO_PERIPHERALS
  ) : 32'd1;

  // Relative DMA channels addresses
  localparam logic [7:0] DMA_CH0_START_ADDRESS = 8'h0;
  localparam logic [7:0] DMA_CH0_SIZE = 8'h1;
  localparam logic [7:0] DMA_CH0_END_ADDRESS = DMA_CH0_START_ADDRESS + DMA_CH0_SIZE;
  localparam logic [7:0] DMA_CH0_IDX = 8'd0;


  localparam addr_map_rule_8bit_t [DMA_CH_NUM-1:0] DMA_ADDR_RULES = '{
      '{idx: DMA_CH0_IDX, start_addr: DMA_CH0_START_ADDRESS, end_addr: DMA_CH0_END_ADDRESS}
  };

  localparam int unsigned DMA_CH_PORT_SEL_WIDTH = DMA_CH_NUM > 1 ? $clog2(DMA_CH_NUM) : 32'd1;

  // switch-on/off peripherals
  // -------------------------
  localparam PERIPHERALS = 8;

  localparam logic [31:0] RV_PLIC_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00000000;
  localparam logic [31:0] RV_PLIC_SIZE = 32'h00010000;
  localparam logic [31:0] RV_PLIC_END_ADDRESS = RV_PLIC_START_ADDRESS + RV_PLIC_SIZE;
  localparam logic [31:0] RV_PLIC_IDX = 32'd0;

  localparam logic [31:0] SPI_HOST_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00010000;
  localparam logic [31:0] SPI_HOST_SIZE = 32'h00010000;
  localparam logic [31:0] SPI_HOST_END_ADDRESS = SPI_HOST_START_ADDRESS + SPI_HOST_SIZE;
  localparam logic [31:0] SPI_HOST_IDX = 32'd1;

  localparam logic [31:0] GPIO_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00020000;
  localparam logic [31:0] GPIO_SIZE = 32'h00010000;
  localparam logic [31:0] GPIO_END_ADDRESS = GPIO_START_ADDRESS + GPIO_SIZE;
  localparam logic [31:0] GPIO_IDX = 32'd2;

  localparam logic [31:0] I2C_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00030000;
  localparam logic [31:0] I2C_SIZE = 32'h00010000;
  localparam logic [31:0] I2C_END_ADDRESS = I2C_START_ADDRESS + I2C_SIZE;
  localparam logic [31:0] I2C_IDX = 32'd3;

  localparam logic [31:0] RV_TIMER_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00040000;
  localparam logic [31:0] RV_TIMER_SIZE = 32'h00010000;
  localparam logic [31:0] RV_TIMER_END_ADDRESS = RV_TIMER_START_ADDRESS + RV_TIMER_SIZE;
  localparam logic [31:0] RV_TIMER_IDX = 32'd4;

  localparam logic [31:0] SPI2_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00050000;
  localparam logic [31:0] SPI2_SIZE = 32'h00010000;
  localparam logic [31:0] SPI2_END_ADDRESS = SPI2_START_ADDRESS + SPI2_SIZE;
  localparam logic [31:0] SPI2_IDX = 32'd5;

  localparam logic [31:0] PDM2PCM_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00060000;
  localparam logic [31:0] PDM2PCM_SIZE = 32'h00010000;
  localparam logic [31:0] PDM2PCM_END_ADDRESS = PDM2PCM_START_ADDRESS + PDM2PCM_SIZE;
  localparam logic [31:0] PDM2PCM_IDX = 32'd6;

  localparam logic [31:0] I2S_START_ADDRESS = PERIPHERAL_START_ADDRESS + 32'h00070000;
  localparam logic [31:0] I2S_SIZE = 32'h00010000;
  localparam logic [31:0] I2S_END_ADDRESS = I2S_START_ADDRESS + I2S_SIZE;
  localparam logic [31:0] I2S_IDX = 32'd7;

  localparam addr_map_rule_t [PERIPHERALS-1:0] PERIPHERALS_ADDR_RULES = '{
      '{idx: RV_PLIC_IDX, start_addr: RV_PLIC_START_ADDRESS, end_addr: RV_PLIC_END_ADDRESS},
      '{idx: SPI_HOST_IDX, start_addr: SPI_HOST_START_ADDRESS, end_addr: SPI_HOST_END_ADDRESS},
      '{idx: GPIO_IDX, start_addr: GPIO_START_ADDRESS, end_addr: GPIO_END_ADDRESS},
      '{idx: I2C_IDX, start_addr: I2C_START_ADDRESS, end_addr: I2C_END_ADDRESS},
      '{idx: RV_TIMER_IDX, start_addr: RV_TIMER_START_ADDRESS, end_addr: RV_TIMER_END_ADDRESS},
      '{idx: SPI2_IDX, start_addr: SPI2_START_ADDRESS, end_addr: SPI2_END_ADDRESS},
      '{idx: PDM2PCM_IDX, start_addr: PDM2PCM_START_ADDRESS, end_addr: PDM2PCM_END_ADDRESS},
      '{idx: I2S_IDX, start_addr: I2S_START_ADDRESS, end_addr: I2S_END_ADDRESS}
  };

  localparam int unsigned PERIPHERALS_PORT_SEL_WIDTH = PERIPHERALS > 1 ? $clog2(
      PERIPHERALS
  ) : 32'd1;

  // Interrupts
  // ----------
  localparam PLIC_NINT = 64;
  localparam PLIC_USED_NINT = 52;
  localparam NEXT_INT = PLIC_NINT - PLIC_USED_NINT;

  localparam PAD_CLK = 0;
  localparam PAD_RST = 1;
  localparam PAD_BOOT_SELECT = 2;
  localparam PAD_EXECUTE_FROM_FLASH = 3;
  localparam PAD_JTAG_TCK = 4;
  localparam PAD_JTAG_TMS = 5;
  localparam PAD_JTAG_TRST = 6;
  localparam PAD_JTAG_TDI = 7;
  localparam PAD_JTAG_TDO = 8;
  localparam PAD_UART_RX = 9;
  localparam PAD_UART_TX = 10;
  localparam PAD_EXIT_VALID = 11;
  localparam PAD_GPIO_0 = 12;
  localparam PAD_GPIO_1 = 13;
  localparam PAD_GPIO_2 = 14;
  localparam PAD_GPIO_3 = 15;
  localparam PAD_GPIO_4 = 16;
  localparam PAD_GPIO_5 = 17;
  localparam PAD_GPIO_6 = 18;
  localparam PAD_GPIO_7 = 19;
  localparam PAD_GPIO_8 = 20;
  localparam PAD_GPIO_9 = 21;
  localparam PAD_GPIO_10 = 22;
  localparam PAD_GPIO_11 = 23;
  localparam PAD_GPIO_12 = 24;
  localparam PAD_GPIO_13 = 25;
  localparam PAD_GPIO_14 = 26;
  localparam PAD_GPIO_15 = 27;
  localparam PAD_GPIO_16 = 28;
  localparam PAD_GPIO_17 = 29;
  localparam PAD_SPI_FLASH_SCK = 30;
  localparam PAD_SPI_FLASH_CS_0 = 31;
  localparam PAD_SPI_FLASH_CS_1 = 32;
  localparam PAD_SPI_FLASH_SD_0 = 33;
  localparam PAD_SPI_FLASH_SD_1 = 34;
  localparam PAD_SPI_FLASH_SD_2 = 35;
  localparam PAD_SPI_FLASH_SD_3 = 36;
  localparam PAD_SPI_SCK = 37;
  localparam PAD_SPI_CS_0 = 38;
  localparam PAD_SPI_CS_1 = 39;
  localparam PAD_SPI_SD_0 = 40;
  localparam PAD_SPI_SD_1 = 41;
  localparam PAD_SPI_SD_2 = 42;
  localparam PAD_SPI_SD_3 = 43;
  localparam PAD_PDM2PCM_PDM = 44;
  localparam PAD_PDM2PCM_CLK = 45;
  localparam PAD_I2S_SCK = 46;
  localparam PAD_I2S_WS = 47;
  localparam PAD_I2S_SD = 48;
  localparam PAD_SPI2_CS_0 = 49;
  localparam PAD_SPI2_CS_1 = 50;
  localparam PAD_SPI2_SCK = 51;
  localparam PAD_SPI2_SD_0 = 52;
  localparam PAD_SPI2_SD_1 = 53;
  localparam PAD_SPI2_SD_2 = 54;
  localparam PAD_SPI2_SD_3 = 55;
  localparam PAD_I2C_SCL = 56;
  localparam PAD_I2C_SDA = 57;

  localparam NUM_PAD = 58;
  localparam NUM_PAD_MUXED = 14;

  localparam int unsigned NUM_PAD_PORT_SEL_WIDTH = NUM_PAD > 1 ? $clog2(NUM_PAD) : 32'd1;

  typedef enum logic [1:0] {
    TOP,
    RIGHT,
    BOTTOM,
    LEFT
  } pad_side_e;

endpackage
