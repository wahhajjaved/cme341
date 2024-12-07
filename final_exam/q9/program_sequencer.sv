module program_sequencer (
	input wire clk,
	input wire sync_reset,
	input wire jmp,
	input wire jmp_nz,
	input wire [3:0] jmp_addr,
	input wire dont_jmp,
	input wire NOPC8,
	input wire load_instr,

	output reg [7:0] pm_addr,
	output reg [7:0] pc,
	output reg [7:0] from_PS
);

always @ (posedge clk)
	pc = pm_addr;


always @ (*)
	if(sync_reset)
		pm_addr = 8'h0;
	else if(jmp)
		pm_addr = {jmp_addr, 4'h0};
	else if (jmp_nz && !dont_jmp)
		pm_addr = {jmp_addr, 4'h0};
	else if (pc == 8'hff)
		pm_addr = 8'h0;
	else
		pm_addr = pc + 8'h1;

//exam code

reg [7:0] counter;
always @ (posedge clk)
	if(sync_reset)
		counter = 8'h0;
	else if (NOPC8)
		counter = counter + 1'b1;
	else if (load_instr)
		counter = counter + jmp_addr;
	else
		counter = counter;


always @(*)
	from_PS = counter;
	// from_PS = pc;

endmodule