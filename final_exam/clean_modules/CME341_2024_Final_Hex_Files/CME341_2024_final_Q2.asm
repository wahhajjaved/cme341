        org 8'H00;
   load m, 4'H0; This is done to turn off the auto increment of i
   load y0, 4'H2; This means reading or writing
                       ; dm[2] will cause a jump to monitor
   load i, 4'H1;  i = 1
   load dm, #4'H1;  dm[1] = 1
   load i, #4'H2;
   load dm, #4'HF;  jmp to monitor, do not load dm so
                          ; so do not enable dm
   jmp trap
   ALIGN
trap:  jmp trap;

     ORG 8'HF0
monitor:   add x0,y0;
               NOPC8;  a no-operation in part a
               jmp trap;  this instruction not executed in part b











   



