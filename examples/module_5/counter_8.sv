module counter_8(
    input wire clk,
    input wire count_en,
    input wire preload,
    input wire preload_val,

    output reg [7:0] count
);

always @ (posedge clk or posegde preload)
    if (preload == 1'b1)
        count = preload_val;
    else if (count_en == 1'b1)
        count = count + 8'd1;
    else
        count = count;

endmodule