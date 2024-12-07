        org 8'H00;
     load y0, #4'H9;
     load x0, #4'H5;
     load y1, #4'H1;
     NOPDF; 
loop1:  add x0, y1;
           mov x0, r;    increment x0
           neg x0;
end1:  mov dm,r;
        jmp trap;
       ALIGN
trap: jmp trap;

