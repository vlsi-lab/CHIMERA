//////////////////////////////////////////////////////////////////////////////////////////
// Engineer:      Alessandra Dolmeta - alessandra.dolmeta@polito.it                     //
//                                                                                      //                            
// Design Name:    Top level module                                                     //
// File name:      chimera_top.sv                                                         //
// Language:       SystemVerilog                                                        //
//////////////////////////////////////////////////////////////////////////////////////////



module chimera_top 
  import cv32e40px_pkg::*;
  import cv32e40px_core_v_xif_pkg::*;
(
  input clk_i,
  input rst_ni,

  cv32e40px_if_xif.coproc_compressed xif_compressed_if,
  cv32e40px_if_xif.coproc_issue      xif_issue_if,
  cv32e40px_if_xif.coproc_commit     xif_commit_if,
  cv32e40px_if_xif.coproc_mem        xif_mem_if,
  cv32e40px_if_xif.coproc_mem_result xif_mem_result_if,
  cv32e40px_if_xif.coproc_result     xif_result_if
);


chimera_pkg::mode_t mode_ascon_xif_i;
chimera_pkg::in_t in_xif_o;
chimera_pkg::out_t res_register;
chimera_pkg::funct7_t funct7_ascon_xif_i;
chimera_pkg::funct2_t funct2_ascon_xif_i;
chimera_pkg::immediate_t immediate_ascon_xif_i;
logic [1:0] insr_ascon_xif_i;
logic ascon_done_o, ascon_store_i;


chimera i_chimera (
    .clk_i (clk_i),
    .rst_ni(rst_ni),

    .x_issue_req_i(xif_issue_if.issue_req),

    .mode_i(mode_ascon_xif_i),
    .funct7_i(funct7_ascon_xif_i),
    .funct2_i(funct2_ascon_xif_i),
    .immediate_i(immediate_ascon_xif_i),
    .in_i(in_xif_o),
    .insr_i(insr_ascon_xif_i),
    .ascon_i(ascon_i),
    .ascon_done_o(ascon_done_o),
    .ascon_store_i(ascon_store_i),

    .out_o (res_register)
);

xif_controller i_xif_controller (
    .clk_i (clk_i),
    .rst_ni(rst_ni),

    // Compressed Interface
    .x_compressed_valid_i(xif_compressed_if.compressed_valid),
    .x_compressed_ready_o(xif_compressed_if.compressed_ready),
    .x_compressed_req_i  (xif_compressed_if.compressed_req),
    .x_compressed_resp_o (xif_compressed_if.compressed_resp),

    // Issue Interface
    .x_issue_valid_i(xif_issue_if.issue_valid),
    .x_issue_ready_o(xif_issue_if.issue_ready),
    .x_issue_req_i  (xif_issue_if.issue_req),
    .x_issue_resp_o (xif_issue_if.issue_resp),

    // Commit Interface
    .x_commit_valid_i(xif_commit_if.commit_valid),
    .x_commit_i(xif_commit_if.commit),

    // Memory Request/Response Interface
    .x_mem_valid_o(xif_mem_if.mem_valid),
    .x_mem_ready_i(xif_mem_if.mem_ready),
    .x_mem_req_o  (xif_mem_if.mem_req),
    .x_mem_resp_i (xif_mem_if.mem_resp),

    // Memory Result Interface
    .x_mem_result_valid_i(xif_mem_result_if.mem_result_valid),
    .x_mem_result_i(xif_mem_result_if.mem_result),

    // Result Interface
    .x_result_valid_o(xif_result_if.result_valid),
    .x_result_ready_i(xif_result_if.result_ready),
    .x_result_o(xif_result_if.result),

    .mode_o(mode_ascon_xif_i), 
    .in_o(in_xif_o),
    .funct7_o(funct7_ascon_xif_i),
    .funct2_o(funct2_ascon_xif_i),
    .immediate_o(immediate_ascon_xif_i),
    .insr_o(insr_ascon_xif_i),
    .res_register_i(res_register),

    .ascon_start_o(ascon_i),
    .ascon_store_o(ascon_store_i),
    .ascon_done_i(ascon_done_o)
);


endmodule
