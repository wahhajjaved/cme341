        org 8'H00;
   NOPDF;  should not increment counter
   NOPC8; increment counter
   load x1, #4'H2
   mov x0, x1;
   load M,#4'H3;
   load dm, #4'H4;
   jmp trap;
   ALIGN
trap: jmp trap;

   



