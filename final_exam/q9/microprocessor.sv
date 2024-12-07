module microprocessor (
	input clk, reset,
	input [3:0] i_pins,
	output wire [3:0] o_reg,

	output wire [7:0] pm_data,

	output wire [7:0] pc, from_PS, pm_address,

	output wire [7:0] ir, from_ID,
	output wire [8:0] reg_enables,
	output wire NOPC8, NOPCF, NOPD8, NOPDF,

	output wire [7:0] from_CU,
	output wire [3:0] x0, x1, y0, y1, m, i, r,
	output wire zero_flag,

	//my debug signals
	output wire[3:0] data_bus, source_select, alu_out
);

reg sync_reset;
wire jump, conditional_jump;
wire [3:0] LS_nibble_ir;
wire i_mux_select, y_reg_select, x_reg_select;

wire[3:0] data_mem_addr, dm;

assign i = data_mem_addr;

always @ (posedge clk)
	sync_reset = reset;

program_memory prog_memory(
	.address(pm_address),
	.clock(~clk),
	.q(pm_data)
);

data_memory memory (
	.clock(~clk),
	.address(data_mem_addr),
	.data(data_bus), //data_in
	.wren(reg_enables[7]), //enable writing to memory
	.q(dm) //data_out
);

program_sequencer prog_sequencer (
	.clk(clk),
	.sync_reset(sync_reset),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.jmp_addr(LS_nibble_ir),
	.dont_jmp(zero_flag),
	.load_instr(load_instr),
	.NOPC8(NOPC8),

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
	.load_instr(load_instr),

	//for exam
	.ir(ir),
	.from_ID(from_ID),
	.NOPC8(NOPC8),
	.NOPCF(NOPCF),
	.NOPD8(NOPD8),
	.NOPDF(NOPDF)
);

computational_unit cu (
	.clk(clk),
	.sync_reset(sync_reset),
	.nibble_ir(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_select),
	.source_sel(source_select),
	.reg_en(reg_enables),
	.i_pins(i_pins),
	.dm(dm),

	.i(data_mem_addr),
	.data_bus(data_bus),
	.o_reg(o_reg),
	.r_eq_0(zero_flag),

	.x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m),
	.from_CU(from_CU),

	//my debug signals
	.alu_out(alu_out)
);



endmodule