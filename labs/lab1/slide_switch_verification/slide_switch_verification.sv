module slide_switch_verification(
input [17:0] sw, //switches
output [6:0] hex1, //hexadecimal display
output [17:7] led_r // red leds
);

//Assign switches [6:0] assigned to hexadecimal displays
assign hex1 = sw[6:0];

//Assign switches [17:7] to red leds [17:7]
assign led_r = sw[17:7];

endmodule