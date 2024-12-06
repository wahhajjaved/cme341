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

typedef enum {RESET, LOAD, MOVE, ALU, JUMP, CONDITIONAL_JUMP} instruction_t;


module instruction_decoder (
	input wire clk,
	input wire sync_reset,
	input wire [7:0] next_instr,

	output reg jmp,
	output reg jmp_nz,
	output reg [3:0] ir_nibble,
	output reg i_sel,
	output reg y_sel,
	output reg x_sel,
	output reg [3:0] source_sel,
	output reg [8:0] reg_en,

	output reg [7:0] ir,
	output reg [7:0] from_ID,
	output reg NOPC8, NOPCF, NOPD8, NOPDF
);
instruction_t instr;

always @(posedge clk)
	ir <= next_instr;


// Decode Instruction
always @(*)
	if(ir[7] == 1'b0)
		instr = LOAD;
	else if(ir[7:6] == 2'b10)
		instr = MOVE;
	else if(ir[7:5] == 3'b110)
		instr = ALU;
	else if(ir[7:4] == 4'b1110)
		instr = JUMP;
	else
		instr = CONDITIONAL_JUMP;

//jmp
always @(*)
	if(sync_reset)
		jmp = 1'b0;
	else if(instr == JUMP)
		jmp = 1'b1;
	else
		jmp = 1'b0;

//jmp_nz
always @(*)
	if(sync_reset)
		jmp_nz = 1'b0;
	else if(instr == CONDITIONAL_JUMP)
		jmp_nz = 1'b1;
	else
		jmp_nz = 1'b0;

//ir_nibble
always @(*)
	ir_nibble = ir[3:0];

//i_sel
always @(*)
	if(sync_reset)
		i_sel = 1'b0;
	else if(instr == LOAD && `LOAD_DST == `I_REG)
		i_sel = 1'b0;
	else if(instr == MOVE && `MOVE_DST == `I_REG)
		i_sel = 1'b0;
	else
		i_sel = 1'b1;

//x_sel
always @(*)
	if(sync_reset)
		x_sel = 1'b0;
	else
		x_sel = `X_SEL;

//y_sel
always @(*)
	if(sync_reset)
		y_sel = 1'b0;
	else
		y_sel = `Y_SEL;

//source_sel
always @(*)
	if(sync_reset)
		source_sel = 4'd10;
	else if (instr == MOVE && `MOVE_SRC == `MOVE_DST)
		source_sel = 4'd9;
	else if (instr == MOVE)
		source_sel = {1'b0, `MOVE_SRC};
	else
		source_sel = 4'd8;


// reg_en
always @(*)
	if(sync_reset)
		reg_en = 9'h1ff;

	else begin
		reg_en = 9'h0;
		case(instr)
			LOAD: begin
				if(`LOAD_DST == `DM_REG) begin
					//special case i = i + m so i must be enabled
					reg_en[`LOAD_DST] = 1'b1;
					reg_en[`I_REG] = 1'b1;
				end
				else if(`LOAD_DST == `O_REG) begin
					//r only written to in ALU instruction
					reg_en[8] = 1'b1;
				end
				else begin
					//enable dst
					reg_en[`LOAD_DST] = 1'b1;
				end
			end

			MOVE: begin
				if(`MOVE_DST == `O_REG && `MOVE_SRC == `I_REG) begin
					// move r to o_reg
					reg_en[8] = 1'b1;
				end
				else if(`MOVE_DST == `DM_REG || (`MOVE_SRC == `DM_REG && `MOVE_DST != `I_REG)) begin
					//to or from dm, i = i + m so i must be enabled
					reg_en[`MOVE_DST] = 1'b1;
					reg_en[`I_REG] = 1'b1;
				end
				else if(`MOVE_DST == `O_REG) begin
					reg_en[8] = 1'b1;
				end
				else begin
					reg_en[`MOVE_DST] = 1'b1;
				end
			end

			ALU: begin
				reg_en[`R_REG] = 1'b1;
			end

			default: begin
				reg_en = 9'b0;
			end

		endcase
	end



//NOPC8	1100 1000	110 = alu instruction, x_sel = 0, y_sel = 1, func = 000
always @ *
	if (sync_reset)
		NOPC8 = 1'b0;
	else
		NOPC8 = next_instr == 8'hc8;


//NOPCF	1100 1111	110 = alu instruction, x_sel = 0, y_sel = 1, func = 111
always @ *
	if (sync_reset)
		NOPCF = 1'b0;
	else
		NOPCF = next_instr == 8'hcf;


//NOPD8	1101 1000	110 = alu instruction, x_sel = 1, y_sel = 1, func = 000
always @ *
	if (sync_reset)
		NOPD8 = 1'b0;
	else
		NOPD8 = next_instr == 8'hd8;


//NOPDF	1101 1111	110 = alu instruction, x_sel = 1, y_sel = 1, func = 000
always @ *
	if (sync_reset)
		NOPDF = 1'b0;
	else
		NOPDF = next_instr == 8'hdf;

//exam code
always @(*)
	// from_ID = 8'h00;
	from_ID = reg_en[7:0];

endmodule