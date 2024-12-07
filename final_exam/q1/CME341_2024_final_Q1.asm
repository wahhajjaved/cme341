    org 8'H0;
start:  jmp 8'H20;
        align
error:  jmp error;  should not trap here
     org 8'H20
begin:  load x1;4'H0;
        NOPD8; should not jump
        load x1,4'H2;
        load x1,4'H3;
        load x1,4'H4;
        load x1,4'H5;
        load x1,4'H6;
        load x1,4'H7;
        load x1,4'H8;
        load x1,4'H9;
        NOPD8;   should jump to 8'H30
        jmp error;
        align
trap:   jmp trap;  should trap here 
         