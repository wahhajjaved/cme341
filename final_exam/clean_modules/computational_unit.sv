module computational_unit(
	input clk,
	input sync_reset,
	input [3:0] nibble_ir,
	input i_sel,
	input y_sel,
	input x_sel,
	input [3:0] source_sel,
	input [9:0] reg_en,
	input [3:0] dm,

	output [3:0] i,
	output [3:0] data_bus,
	output [3:0] o_reg,

	output [7:0] from_CU
);




endmodule