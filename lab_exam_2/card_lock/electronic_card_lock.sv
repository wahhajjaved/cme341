module electronic_card_lock(
	input key_0,
	input key_1,
	input [15:0] entry_code_on_card,
	input [1:0] card_type,
	input card_read,
	input trip_lock_for_guest
);


always @ *
	if (key_1)
		card_read = 1'b1;
	else if (key_0)
		card_read = 1'b0;
	else
		card_read = card_read;




/********************************************************/
/*						Guest	 						*/
/********************************************************/
reg [15:0] current_guest_code, guest_lfsr;
reg load_guest_data;

always @ (posedge card_read)
	if(load_guest_data)




endmodule