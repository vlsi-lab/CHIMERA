// Copyright EPFL contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#ifndef chimera_X_HEEP_H_
#define chimera_X_HEEP_H_

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

  //#include "core_v_mini_mcu.h"

#define chimera_PERIPH_START_ADDRESS (EXT_PERIPHERAL_START_ADDRESS + 0x0000000)
#define chimera_PERIPH_SIZE 0x0001000
#define chimera_PERIPH_END_ADDRESS (chimera_PERIPH_START_ADDRESS + chimera_PERIPH_SIZE)

#define chimera_IO_START_ADDRESS (EXT_SLAVE_START_ADDRESS + 0x0000000)
#define chimera_IO_SIZE 0x0001000
#define chimera_IO_END_ADDRESS (chimera_IO_START_ADDRESS + chimera_IO_SIZE)


#define chimera_DIN_START_ADDR chimera_IO_START_ADDRESS
#define chimera_DOUT_START_ADDR (chimera_IO_START_ADDRESS+0x0000000c8)

#define chimera_CTRL_START_ADDR chimera_PERIPH_START_ADDRESS
#define chimera_STATUS_START_ADDR (chimera_PERIPH_START_ADDRESS+0x00000004)

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // chimera_X_HEEP_H_
