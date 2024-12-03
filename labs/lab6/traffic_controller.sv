module traffic_controller (
	input clk_27,
	input not_reset,
	input not_southbound_left_request,
	input debug,
	output [6:0] hex7, //northbound
	output [6:0] hex5, //southbound
	output [6:0] hex3, //eastbound
	output [6:0] hex1, //westbound
	output [6:0] hex0, //counter
	output ledg2
);

wire clk;
wire northbound_green;
wire northbound_amber;
wire northbound_red;
wire southbound_green;
wire southbound_amber;
wire southbound_red;
wire southbound_left;
wire eastbound_green;
wire eastbound_amber;
wire eastbound_red;
wire westbound_green;
wire westbound_amber;
wire westbound_red;


reg [3:0] counter;

//KEY push buttons are active low so reset needs to be inverted
reg reset;
always @ *
	reset = ~not_reset;

always @ *
	ledg2 = reset;

clock clock_1(
	.clk_27(clk_27),
	.debug(debug),
	.reset(reset),
	.clk(clk)
);

traffic_controller_fsm traffic_controller_fsm_1 (
	.clk(clk),
	.reset(reset),
	.southbound_left_request(~not_southbound_left_request),
	.northbound_green(northbound_green),
	.northbound_amber(northbound_amber),
	.northbound_red(northbound_red),
	.southbound_green(southbound_green),
	.southbound_amber(southbound_amber),
	.southbound_red(southbound_red),
	.southbound_left(southbound_left),
	.eastbound_green(eastbound_green),
	.eastbound_amber(eastbound_amber),
	.eastbound_red(eastbound_red),
	.westbound_green(westbound_green),
	.westbound_amber(westbound_amber),
	.westbound_red(westbound_red),
	.t(counter)
);


hex_display_lights northbound_display (
	.colour({1'b0, northbound_green, northbound_amber, northbound_red}),
	.hex_segments(hex7)
);

hex_display_lights southbound_display (
	.colour({southbound_left, southbound_green, southbound_amber, southbound_red}),
	.hex_segments(hex5)
);

hex_display_lights eastbound_display (
	.colour({1'b0, eastbound_green, eastbound_amber, eastbound_red}),
	.hex_segments(hex3)
);

hex_display_lights westbound_display (
	.colour({1'b0, westbound_green, westbound_amber, westbound_red}),
	.hex_segments(hex1)
);





// always @ (posedge clk)
// 	if (reset)
// 		counter = 4'h0;
// 	else if (counter == 4'hf)
// 		counter = 4'h0;
// 	else
// 		counter = counter + 4'h1;

hex_display_driver c (
	.hex_digit(counter),
	.hex_segments(hex0)
);



endmodule
