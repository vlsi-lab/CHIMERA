module chimera
  import cv32e40px_core_v_xif_pkg::*;
  import chimera_pkg::*;
(
    input logic clk_i,
    input logic rst_ni,

    input  x_issue_req_t x_issue_req_i,

    input chimera_pkg::mode_t mode_i,
    input chimera_pkg::funct7_t funct7_i,
    input chimera_pkg::funct2_t funct2_i,
    input chimera_pkg::immediate_t immediate_i,
    input chimera_pkg::in_t in_i,
    input logic [1:0] insr_i,
    input logic ascon_i,
    output logic ascon_done_o,
    input logic ascon_store_i, 
    output chimera_pkg::out_t out_o
);

  //--------signals declarations ----------------------------------------------------------------------------
  chimera_pkg::out_t zero;
  chimera_pkg::out_t trailing_zero_bits_count_result, laci_gf2m_mul_low_result;
  chimera_pkg::out_t laci_gf2m_mul_low_reg;
  chimera_pkg::out_t gf_reduce_result;
  chimera_pkg::out_t gf_carryless_result; //, gf_carryless_result_reg;
  chimera_pkg::out_t gf_square_result;
  chimera_pkg::out_t reed_solomon_result;
  chimera_pkg::out_t ftt_result;
  chimera_pkg::out_t encode_result;
  chimera_pkg::out_t vector_result;

  logic [31:0] gf_reduce_z2;
  logic enable, enable_reg;
  logic [319:0] ascon_input, ascon_result;
  logic ascon_enable;

  chimera_pkg::out_t mux_out;
  chimera_pkg::out_t ascon_32out;
  logic [31:0] lim1, lim2;
  logic [9:0] [31:0] ascon_32out_packed;
  logic ascon_mux_reg;
  chimera_pkg::instruction_u instruction; 
  
  assign zero = '0;

  assign ascon_32out_packed = ascon_result;
  
  assign enable = (mode_i == chimera_pkg::OP_R_R1) && (funct7_i == chimera_pkg::FUNCT7_2);
  assign ascon_enable = (mode_i == chimera_pkg::OP_R4_R4) && (funct2_i == chimera_pkg::FUNCT2_0);
	// register_ascon_enable
  assign instruction = x_issue_req_i.instr;
  assign ascon_mux = (instruction.as_chimera_R4.funct3 == chimera_pkg::OP_R4_R4) && (instruction.as_chimera_R4.funct2 == chimera_pkg::FUNCT2_2);

  //register for ascon
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      ascon_32out.rd1 = '0;
      ascon_32out.rd2 = '0;
    end else begin
      if (ascon_mux == 1'b1) begin
         ascon_32out.rd1 = '0;
         ascon_32out.rd2 = ascon_32out_packed[x_issue_req_i.rs[0]];
      end else
          ascon_32out = '0;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      enable_reg <= '0;
      ascon_mux_reg <= '0;
    end else begin
      enable_reg <= enable;
      ascon_mux_reg <= ascon_mux;
    end
  end

  // Register for storing laci_gf2m_mul_low_result only when en=1
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      laci_gf2m_mul_low_reg <= '0;
    end else if ( enable) begin
      laci_gf2m_mul_low_reg <= laci_gf2m_mul_low_result;
    end else if ( enable_reg) begin
      laci_gf2m_mul_low_reg.rd2 <= laci_gf2m_mul_low_reg.rd1;
      laci_gf2m_mul_low_reg.rd1 <= laci_gf2m_mul_low_reg.rd2;
    end
  end

  register_ascon i_register_ascon (
    .clk_i(clk_i),
    .rst_ni(rst_ni),  
    .register_ascon_0_i(in_i.rs1_0),  
    .register_ascon_1_i(in_i.rs2_0),  
    .register_ascon_enable_i(ascon_enable),
    .register_ascon_index_i(in_i.rs3_0[3:0]),
    .register_ascon_o(ascon_input)
  );

  ascon i_ascon (
    .clk(clk_i),   
    .rst_n(rst_ni),
    .start(ascon_i),
	.number_rounds_in(in_i.rs2_0),
    .din(ascon_input),
    .dout(ascon_result),
    .done(ascon_done_o)
  );

  always_comb begin
      if (ascon_mux == 1'b1) begin
          //lim1 = in_i.rs1_0;
          out_o.rd2 = ascon_32out.rd2;
          out_o.rd1 = '0;
      end else
          out_o = '0;
  end




endmodule
