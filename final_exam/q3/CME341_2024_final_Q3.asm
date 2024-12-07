       org 8'H00
   load x1, #4'H1;
   jnz 8'H30;   spend 4 clock period in ir, i.e. wait an extra 3 
   load x1, #4'H2;
   jnz 8'H00;  spend just 1 clock period in ir
   load x1, #4'H3;
   jmp 8'H10;
      org 8'H10
    jmp 8'H10;  trap here\




