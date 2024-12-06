module microprocessor (
	input clk, reset,
	input [3:0] i_pins,
	output wire [3:0] o_reg,

	output wire [7:0] pm_data,

	output wire [7:0] pc, from_PS, pm_address,

	output wire [7:0] ir, from_ID,
	output wire [8:0] register_enables,
	output wire NOPC8, NOPCF, NOPD8, NOPDF,

	output wire [7:0] from_CU,
	output wire [3:0] x0, x1, y0, y1, m, i, r,
	output wire zero_flag
);

wire jump, conditional_jump;
wire [3:0] LS_nibble_ir;
wire i_mux_select, y_reg_select, x_reg_select;
wire [3:0] source_select;
wire [8:0] reg_enables;

reg sync_reset;
always @ (posedge clk)
	sync_reset = reset;

program_memory prog_memory(
	.address(pm_address),
	.clock(~clk),
	.q(pm_data)
);

program_sequencer prog_sequencer (
	.clk(clk),
	.sync_reset(sync_reset),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.jmp_addr(LS_nibble_ir),
	.dont_jmp(zero_flag),

	.pm_addr(pm_address),

	//for exam
	.pc(pc),
	.from_PS(from_PS)
);

instruction_decoder inst_decoder(
	.clk(clk),
	.sync_reset(sync_reset),
	.next_instr(pm_data),

	.jmp(jump),
	.jmp_nz(conditional_jump),
	.ir_nibble(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_select),
	.source_sel(source_select),
	.reg_en(reg_enables),

	//for exam
	.ir(instr_register),
	.from_ID(from_ID)
);




endmodule