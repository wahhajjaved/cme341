        org 8'H00;
     load m, #4'H1;  m=1
     load x0, #4'H1;   load loop_count instruction
loop1:    load dm, #4'H1;   
     mov y1,i;
     add x1, y1;      
end1:    NOPC8;   part (a) does not get past here
    load i,#4'H0; reset i to 0
    load x0, #4'H4;   load loop_count instruction
loop2:  load dm, #4'H1;    dm = 1 and i = i+1
     mov y1,i
     add x1, y1;      
end2:    NOPC8; 
         jmp trap;
     ALIGN
trap:   jmp trap;
