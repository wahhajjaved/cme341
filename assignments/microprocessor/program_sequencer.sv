module program_sequencer (
	input wire clk,
	input wire sync_reset,
	input wire [3:0] jmp_addr,
	input wire jmp,
	input wire jmp_nz,
	input wire dont_jmp,
	output reg [7:0] pm_addr
);

reg [7:0] pc;
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

endmodule