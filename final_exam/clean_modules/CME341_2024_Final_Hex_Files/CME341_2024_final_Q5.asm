        org 8'H00;
     load i, #4'H8;  i = 8
    load dm, 4'H7; dm[8] = 7
    load x1, 4'H1;     x1 = 1
    mov x0, x1;        x0 = 1
    load x0, #4'H2;   x0 = 2
    jmp monitor;
   ALIGN
main:   mov x1, x0;     x1 = 2
     mov x1, dm;        part (a)    x1 = dm[8] = F
                      ;         part (b)    x1 = dm_2[8] = 7
          jmp trap;
   ALIGN
trap:    jmp trap;
      org 8'HF0
monitor:               
         load x0, #4'H4;          x0_1 = 4
        mov y0, x0;                y0  = 4
         mov x0, x1;               x0_1 = 1
        load dm, #4'HF;       part (a):  dm[8] = F
                             ;         part (b):  dm_1[8] = F
        mov x1, dm;         parts (a) and (b):    x1 = F
        jmp main;







   



 = F
                          ;         part (b):    x1 = dm_2[8] = F
        jmp main;





   



