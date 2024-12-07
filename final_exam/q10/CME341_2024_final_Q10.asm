        org 8'H00;
   load x1, 4'H1;
   load y0, 4'H2;
   mov y1,  y0;  y1 = 4'H2
   neg x1;   r = -4'H1 or r = 4'HF
   load m, 4'H5;
   load y1, 4'b1001;  y1 = y1 + x1 = 3
   load y1, 4'b0100;   y1 = y1 - r = 4
   load y1, 4'b1101;  y1 = y1 + m = 9
   mov i, y1;  i = 9
   load y1, 4'b1011;  y1 = y1 + y1 = 9 + 9 = 2
   load y1, 4'b0110;  y1 = y1 - i = 2 - 9 = -7 = 9
   jmp trap
   ALIGN
trap:  jmp trap;








   



