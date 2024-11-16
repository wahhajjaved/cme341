module microprocessor(
	input wire clk,
	input wire reset,
	input wire [3:0] i_pins,
	output wire [3:0] o_reg
);

wire [7:0] pm_data;
reg sync_reset;
wire [7:0] pm_address;
wire jump;
wire conditional_jump;
wire [3:0] LS_nibble_ir;
wire zero_flag;
wire i_mux_select;
wire x_reg_select;
wire y_reg_select;
wire [3:0] source_select;
wire [8:0] reg_enables;
wire [3:0] data_mem_addr;
wire [3:0] data_bus;
wire [3:0] dm;



always @ (posedge clk)
	sync_reset = reset;




program_sequencer prog_sequencer(
	.clk(clk),
	.sync_reset(sync_reset),
	.pm_addr(pm_address),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.jmp_addr(LS_nibble_ir),
	.dont_jmp(zero_flag)
);






endmodule