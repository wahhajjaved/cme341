module basic_BCD_counter(
	input clk,
	input sync_clr,
	input count_enable,
	(* keep *) output look_ahead_roll_over,
	(* keep *) output [3:0] BCD_count
);

always @ (posedge clk)
	if (sync_clr)
		BCD_count = 4'b0;
	else if (count_enable)
		// BCD_count == 4'd9 ? BCD_count = 0 : BCD_count = BCD_count + 4'd1;
		if (BCD_count == 4'd9)
			BCD_count = 0;
		else
			BCD_count = BCD_count + 4'd1;
	else
		BCD_count = BCD_count;

always @ *
	if (count_enable && BCD_count == 4'd9)
		look_ahead_roll_over = 1'b1;
	else
		look_ahead_roll_over = 1'b0;




endmodule