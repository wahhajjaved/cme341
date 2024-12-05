module lab_exam_card_lock(
	input CLOCK_27,
	input [1:0]SW,
	output [17:0]LEDR,
	output [7:0]LEDG,
	output [41:0]HEXd,
	output [13:0]rest
);


(*noprune*)wire [15:0]number;
(*noprune*)wire [1:0]card_type;
(*noprune*)wire rise, fall;
(*noprune*)wire trip;
(*keep*)wire [7:0]test_state;
(*noprune*)wire [9:0]score;

electronic_card_lock ec1(
	.key_0(~fall),
	.key_1(~rise),
	.card_read(LEDR[17]),
	.entry_code_on_card(number),
	.card_type(card_type),
	.trip_lock_for_guest(trip)
);

magic_exam_card mxc(
	.clk(CLOCK_27),
	.trip(trip),
	.number(number),
	.v1(SW[1:0]),
	.v2(16'hcabb),
	.ctype(card_type),
	.key_1(rise),
	.key_0(fall),
	.state(test_state),
	.score(score),
	.HEX(HEXd)
);


assign LEDR[9:0] = score;
assign LEDR[16:10] = 7'd0;
assign LEDG[7:0] = test_state;
assign rest = {14{1'b1}};

endmodule
