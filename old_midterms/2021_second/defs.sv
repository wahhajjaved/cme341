package defs;

//Registers

`define X0_REG 		3'b000
`define X1_REG 		3'b001
`define Y0_REG 		3'b010
`define Y1_REG 		3'b011
`define R_REG 		3'b100
`define O_REG 		3'b100
`define M_REG 		3'b101
`define I_REG 		3'b110
`define DM_REG 		3'b111


//Instructions

// LOAD: 0, dst, dst, dst, data, data, data, data
// MOVE: 1, 0, dst, dst, dst, src, src, src
// ALU: 1, 1, 0, x_sel, y_sel, func, func, func
// JUMP: 1, 1, 1, 0, dst, dst, dst, dst
// CONDITIONAL_JUMP: 1, 1, 1, 1, dst, dst, dst, dst

`define LOAD_DST ir[6:4]
`define LOAD_DATA 4'd8
`define MOVE_DST ir[5:3]
`define MOVE_SRC ir[2:0]
`define X_SEL ir[4]
`define Y_SEL ir[3]
`define FUNC ir[2:0]
`define JUMP_DST ir[4:0]
`define C_JUMP_DST ir[4:0]

typedef enum {RESET, LOAD, MOVE, ALU, JUMP, CONDITIONAL_JUMP, JUMP_NEXT} instruction_t;

endpackage