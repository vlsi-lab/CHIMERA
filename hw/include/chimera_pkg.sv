package chimera_pkg;

// funct3 for chimera_R intruction
typedef enum logic [2:0] {
  OP_R_R1 = 3'b001, //1  - GF
  OP_R_R2 = 3'b010, //2
  OP_R_R3 = 3'b011, //3
  OP_R_R4 = 3'b100, //4
  OP_R_R5 = 3'b101, //5
  OP_R_R6 = 3'b110, //6
  OP_R_R7  = 3'b111  //7
} chimera_r_op;

// funct3 for chimera_R4 intruction
typedef enum logic [2:0] {
  OP_R4_R1 = 3'b001, //1
  OP_R4_R2 = 3'b010, //2
  OP_R4_R3 = 3'b011, //3
  OP_R4_R4 = 3'b100, //4
  OP_R4_R5 = 3'b101, //5
  OP_R4_R6 = 3'b110, //6
  OP_R4_R7 = 3'b111  //7
} chimera_r4_op;

// funct3 for chimera_I intruction
typedef enum logic [2:0] {
  OP_I_R1   = 3'b001,
  OP_I_R2   = 3'b010,
  OP_I_R3   = 3'b011,
  OP_I_R4   = 3'b100,
  OP_I_R5   = 3'b101,
  OP_I_R6   = 3'b110,
  OP_I_R7   = 3'b111
} chimera_i_op;

// New instruction definition
typedef union packed {
  struct packed {
    logic [6:0] funct7;  // 31:25
    logic [4:0] rs2;     // 24:20
    logic [4:0] rs1;     // 19:15
    chimera_r_op funct3;  // 14:12
    logic [4:0] rd;      // 11:7
    logic [6:0] opcode;  // 6:0
  } as_chimera_R;
  struct packed {
    logic [4:0] rs3;  // 31:27
    logic [1:0] funct2;  // 26:25
    logic [4:0] rs2;     // 24:20
    logic [4:0] rs1;     // 19:15
    chimera_r4_op funct3;  // 14:12
    logic [4:0] rd;      // 11:7
    logic [6:0] opcode;  // 6:0
  } as_chimera_R4;
  struct packed {
    logic [11:0] immediate;
    logic [4:0]  rs1;
    chimera_i_op  funct3;
    logic [4:0]  rd;
    logic [6:0]  opcode;
  } as_chimera_I;
  logic [31:0] raw;
} instruction_u;

// Opcode of the new instruction
typedef enum logic [6:0] {
  chimera_I  = 7'b0001011,
  chimera_R  = 7'b0111011, //3b
  chimera_R4 = 7'b1001011  //4b
} chimera_op;


// Mode of operation of chimera
typedef enum logic [6:0] {
  FUNCT7_0         = 7'b0000000, //0
  FUNCT7_1         = 7'b0000001, //1
  FUNCT7_2         = 7'b0000010, //2
  FUNCT7_3         = 7'b0000011, //3
  FUNCT7_4         = 7'b0000100, //4
  FUNCT7_5         = 7'b0000101, //5
  FUNCT7_6         = 7'b0000110, //6
  FUNCT7_7         = 7'b0000111, //7
  FUNCT7_8         = 7'b0001000, //8
  FUNCT7_9         = 7'b0001001, //9
  FUNCT7_10        = 7'b0001010, //10
  FUNCT7_11        = 7'b0001011, //11
  FUNCT7_12        = 7'b0001100, //12
  FUNCT7_13        = 7'b0001101, //13
  FUNCT7_14        = 7'b0001110, //14
  FUNCT7_15        = 7'b0001111, //15
  FUNCT7_16        = 7'b0010000, //16
  FUNCT7_17        = 7'b0010001, //17
  FUNCT7_18        = 7'b0010010, //18
  FUNCT7_19        = 7'b0010011, //19
  FUNCT7_20        = 7'b0010100, //20
  FUNCT7_21        = 7'b0010101, //21
  FUNCT7_22        = 7'b0010110, //22
  FUNCT7_23        = 7'b0010111, //23
  FUNCT7_24        = 7'b0011000, //24
  FUNCT7_25        = 7'b0011001, //25
  FUNCT7_26        = 7'b0011010, //26
  FUNCT7_27        = 7'b0011011, //27
  FUNCT7_28        = 7'b0011100, //28
  FUNCT7_29        = 7'b0011101, //29
  FUNCT7_30        = 7'b0011110, //30
  FUNCT7_31        = 7'b0011111, //31
  FUNCT7_32        = 7'b0100000, //32
  FUNCT7_33        = 7'b0100001, //33
  FUNCT7_34        = 7'b0100010, //34
  FUNCT7_35        = 7'b0100011, //35
  FUNCT7_36        = 7'b0100100, //36
  FUNCT7_37        = 7'b0100101, //37
  FUNCT7_38        = 7'b0100110, //38
  FUNCT7_39        = 7'b0100111 //39
} chimera_funct7;

// Mode of operation of chimera
typedef enum logic [1:0] {
  FUNCT2_0         = 2'b00, //0
  FUNCT2_1         = 2'b01, //1
  FUNCT2_2         = 2'b10, //2
  FUNCT2_3         = 2'b11 //3
} chimera_funct2;


// State of the FSM of the controller
typedef enum logic [2:0] {
  RESET_S,
  WAIT_S,
  LOAD_S,
  ASCON_S, 
  PROCESS_S,
  COMPUTE_S,
  STORE_S, 
  DONE_S
} controller_state_t;


typedef struct packed {
  logic [2:0] mode_chimera;
} mode_t;

typedef struct packed {
  logic [6:0] funct7_chimera;
} funct7_t;

typedef struct packed {
  logic [1:0] funct2_chimera;
} funct2_t;

typedef struct packed {
  logic [11:0] immediate_chimera;
} immediate_t;


typedef struct packed {
  logic [31:0] rs1_0;
  logic [31:0] rs2_0;
  logic [31:0] rs3_0;
  logic [31:0] rs1_1;  
  logic [31:0] rs2_1;
  logic [31:0] rs3_1;  
} in_t;

typedef struct packed {
    logic [31:0] rd1;
    logic [31:0] rd2;
} out_t;


endpackage
