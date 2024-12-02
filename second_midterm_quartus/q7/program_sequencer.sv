module program_sequencer (
	input wire clk,
	input wire sync_reset,
	input wire [3:0] jmp_addr,
	input wire jmp,
	input wire jmp_nz,
	input wire dont_jmp,
	output reg [7:0] pm_addr,
	output reg [7:0] pc,
	output reg [7:0] from_PS
);

always @ (posedge clk)
	pc = pm_addr;

reg jump_waiting;
reg [3:0] jump_waiting_addr;
always @ (posedge clk)
	if(sync_reset)
		jump_waiting = 1'b0;
	else if (jmp)
		jump_waiting = 1'b1;
	else
		jump_waiting = 1'b0;

always @(*)
	if(jmp)
		jump_waiting_addr = jmp_addr;
	else
		jump_waiting_addr = 4'b0;

always @ (*)
	if(sync_reset)
		pm_addr = 8'h0;
	else if(jump_waiting)
		pm_addr = {jump_waiting_addr, 4'h0};
	else if (jmp_nz && !dont_jmp)
		pm_addr = {jmp_addr, 4'h0};
	else if (pc == 8'hff)
		pm_addr = 8'h0;
	else
		pm_addr = pc + 8'h1;

//exam code
always @(*)
	from_PS = 8'h00;
	// from_PS = ~pc;

endmodule