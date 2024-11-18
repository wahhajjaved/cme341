module instruction_decoder (
	input wire clk,
	input wire sync_reset,
	input wire [7:0] next_instr,
	output reg jmp,
	output reg jmp_nz,
	output reg [3:0] ir_nibble,
	output reg i_sel,
	output reg x_sel,
	output reg y_sel,
	output reg [3:0] source_sel,
	output reg [8:0] reg_en,
	output reg [7:0] ir,
	output reg [7:0] from_ID
);
import defs::*;

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
	else
		case(instr)
			LOAD: begin
				source_sel = 4'd8;
			end

			MOVE: begin
				source_sel = {1'b0, `MOVE_SRC};
			end

			default:
				source_sel = 4'b0;
		endcase


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
					reg_en = 1'b1 << 8;
				end
				else begin
					//enable dst
					reg_en[`LOAD_DST] = 1'b1;
				end
			end

			MOVE: begin
				if(`MOVE_DST == 3'h4 && `MOVE_SRC == 3'h4) begin
					// move r to o_reg
					reg_en[8] = 1'b1;
				end
				else if(`MOVE_DST == `DM_REG || (`MOVE_SRC == `DM_REG && `MOVE_DST != `I_REG)) begin
					//to or from dm, i = i + m so i must be enabled
					reg_en[`MOVE_DST] = 1'b1;
					reg_en[`I_REG] = 1'b1;
				end
				else if(`MOVE_DST == `O_REG) begin
					reg_en = 1'b1 << 8;
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

//exam code
always @(*)
	from_ID = 8'h00;
	// from_ID = ir;

endmodule