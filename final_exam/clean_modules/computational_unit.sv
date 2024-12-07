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

module computational_unit(
	input clk,
	input sync_reset,
	input [3:0] nibble_ir, //pm_data
	input i_sel,
	input y_sel,
	input x_sel,
	input [3:0] source_sel,
	input [9:0] reg_en,
	input [3:0] i_pins,
	input [3:0] dm,

	output reg [3:0] i,
	output reg [3:0] data_bus,
	output reg [3:0] o_reg,
	output reg r_eq_0, //zero_flag

	output reg [3:0] x0, x1, y0, y1, r, m,
	output reg [7:0] from_CU,

	//my debug signals
	output reg [3:0] alu_out
);

reg [3:0] x, y;
reg alu_out_eq_0;



//use source_sel to load data on to the data bus
always @ *
	case(source_sel)

		4'd0: data_bus = x0;
		4'd1: data_bus = x1;
		4'd2: data_bus = y0;
		4'd3: data_bus = y1;
		4'd4: data_bus = r;
		4'd5: data_bus = m;
		4'd6: data_bus = i;
		4'd7: data_bus = dm;
		4'd8: data_bus = nibble_ir;
		4'd9: data_bus = i_pins;

		default: data_bus = 4'h0;

	endcase


// i
always @ (posedge clk)
	if (reg_en[6])
		if (i_sel == 1'b0)
			i <= data_bus;
		else
			i <= i + m;
	else
		i <= i;


// m
always @ (posedge clk)
	if (reg_en[5])
		m <= data_bus;
	else
		m <= m;


// o_reg
always @ (posedge clk)
	if (reg_en[8])
		o_reg <= data_bus;
	else
		o_reg <= o_reg;


// x0
always @ (posedge clk)
	if (reg_en[0])
		x0 <= data_bus;
	else
		x0 <= x0;


// x1
always @ (posedge clk)
	if (reg_en[1])
		x1 <= data_bus;
	else
		x1 <= x1;


// y0
always @ (posedge clk)
	if (reg_en[2])
		y0 <= data_bus;
	else
		y0 <= y0;


// y1
always @ (posedge clk)
	if (reg_en[3])
		y1 <= data_bus;
	else
		y1 <= y1;


// r_eq_0
always @ (posedge clk)
	if (sync_reset)
		r_eq_0 <= 1'b1;
	else if (reg_en[4])
		r_eq_0 <= alu_out == 4'b0000;
	else
		r_eq_0 <= r_eq_0;


// r
always @ (posedge clk)
	if (sync_reset)
		r <= 4'h0;
	else if (reg_en[4])
		r <= alu_out;
	else
		r <= r;


// x
always @ *
	if (x_sel == 1'b0)
		x = x0;
	else
		x = x1;

// y
always @ *
	if (y_sel == 1'b0)
		y = y0;
	else
		y = y1;



//ALU
always @ *

	case(nibble_ir[2:0])

		3'b000:
			if (y_sel == 1'b0)
				alu_out = -x; //2's complement of x
			else if (x_sel == 1'b0)
				alu_out = r; //NOPC8
			else
				alu_out = r; //NOPD8

		3'b001: alu_out = x - y; //unsigned subtraction

		3'b010: alu_out = x + y; //unsigned addition

		3'b011: begin
			reg [7:0] result;
			result = x * y;
			alu_out = result[7:4]; //upper 4 bits of unsigned multiplication
		end

		3'b100: begin
			reg [7:0] result;
			result = x * y;
			alu_out = result[3:0]; //lower 4 bits of unsigned multiplication
		end

		3'b101: alu_out = x ^ y; //bitwise xor

		3'b110: alu_out = x & y; //bitwise and

		3'b111:
			if (y_sel == 1'b0)
				alu_out = ~x; //1's complement of x / bitwise negation of x
			else if (x_sel == 1'b0)
				alu_out = r; //NOPCF
			else
				alu_out = r; //NOPDF

	endcase




always @ *
	from_CU = 8'h0;
	// from_CU = {x1, x0};

endmodule