module BCD_counter(
	input clk,
	input sync_clr,
	input count_enable,
	(* keep *) output [3:0] digit_001,
	(* keep *) output [3:0] digit_010,
	(* keep *) output [3:0] digit_100
);

reg look_ahead_roll_over_1, look_ahead_roll_over_2;

basic_BCD_counter dg_1 (
	.clk(clk),
	.sync_clr(sync_clr),
	.count_enable(count_enable),
	.look_ahead_roll_over(look_ahead_roll_over_1),
	.BCD_count(digit_001)
);

basic_BCD_counter dg_10 (
	.clk(clk),
	.sync_clr(sync_clr),
	.count_enable(look_ahead_roll_over_1),
	.look_ahead_roll_over(look_ahead_roll_over_2),
	.BCD_count(digit_010)
);

basic_BCD_counter dg_100 (
	.clk(clk),
	.sync_clr(sync_clr),
	.count_enable(look_ahead_roll_over_2),
	.look_ahead_roll_over(),
	.BCD_count(digit_100)
);


endmodule
