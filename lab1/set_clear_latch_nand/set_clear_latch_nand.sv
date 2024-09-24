module set_clear_latch_nand(n_set, n_clear, Q, n_Q);
input n_set, n_clear;
output Q, n_Q;
nand nand_1(Q, n_set, n_Q); 
nand nand_2(n_Q, Q, n_clear);
endmodule 