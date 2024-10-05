module set_clear_latch (
    input n_set,
    input n_clear,
    output q,
    output n_q
);

    nand nand1(q, n_set, n_q);
    nand nand2(n_q, q, n_clear);

endmodule