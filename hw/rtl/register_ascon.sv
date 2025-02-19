//////////////////////////////////////////////////////////////////////////////////////////
// Engineer:      Federica Bader                        //
//                                                                                      //
// Design Name:    Top level module                                                     //
// Project Name:   TYRCA:                                                               //
//                 Tightly-coupled Accelerator for RISC-V with Code-based Algorithms    //
// File name:      register_ascon.sv                                                   //
// Language:       SystemVerilog                                                        //
//                                                                                      //
// Description:    TYRCA register_ascon.                                               //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////

module register_ascon (
    input clk_i,
    input rst_ni,  
    input logic [31:0] register_ascon_0_i,  
    input logic [31:0] register_ascon_1_i,  
    input logic register_ascon_enable_i,
    input logic [3:0] register_ascon_index_i,
    output logic[319:0] register_ascon_o   
);

  parameter NUM_VARIABLES = 10;
  parameter VARIABLE_WIDTH = 32;

  // Define register with 10 variables, each 32 bits wide
  logic [VARIABLE_WIDTH-1:0] register_array [0:NUM_VARIABLES-1];

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      register_array = '{'0, '0, '0, '0, '0, '0, '0, '0, '0, '0};
    end else if (register_ascon_enable_i) begin
      // Write data_in_0 to index
      register_array[register_ascon_index_i] = register_ascon_0_i;
      register_array[register_ascon_index_i + 1] = register_ascon_1_i;
    end
  end

  assign register_ascon_o = { register_array[9], register_array[8], register_array[7], register_array[6], register_array[5], register_array[4], register_array[3], register_array[2], register_array[1], register_array[0]};


endmodule
