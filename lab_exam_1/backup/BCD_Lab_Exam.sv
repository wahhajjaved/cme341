module BCD_Lab_Exam(
	input CLOCK_27,
	input [17:0]SW,
	output [17:0]LEDR,
	output [6:0]HEX0,
	output [6:0]HEX1,
	output [6:0]HEX2,
	output [6:0]HEX3,
	output [6:0]HEX4,
	output [6:0]HEX5,
	output [6:0]HEX6,
	output [6:0]HEX7
);


wire [11:0] value;
wire [55:0] Hex_display;
wire [6:0] a0, a1, a2, a3, a4, a5, a6, a7;

assign HEX0 = Hex_display[6:0];
assign HEX1 = Hex_display[13:7];
assign HEX2 = Hex_display[20:14];
assign HEX3 = Hex_display[27:21];
assign HEX4 = Hex_display[34:28];
assign HEX5 = Hex_display[41:35];
assign HEX6 = Hex_display[48:42];
assign HEX7 = Hex_display[55:49];

assign LEDR = {18{1'b0}};


BCD_exam exam_1(
	.clk(CLOCK_27),
	.speed(SW[0]),
	.v1(value),
	.v2(a0),
	.v3(a1),
	.v4(a2),
	.v5(a3),
	.v6(a4),
	.v7(a5),
	.v8(a6),
	.v9(a7),
	.result(Hex_display)
);


//Instantiate your module here ======================
//===================================================

sequential_B_to_BCD_converter sbcd1(
	.sw(value),
	.clk(CLOCK_27),
	.hex0(a0),
	.hex1(a1),
	.hex2(a2)
);



endmodule
