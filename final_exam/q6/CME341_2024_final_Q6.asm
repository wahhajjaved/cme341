        org 8'H00;
  load x0,#4'H2;
  load y0,#4'H7;
  neg x0;   r = E, x0 = 3
  neg x1;   r = 0
  NOPC8;
  NOPD8;
  mov x0,r;  x0 = 0
  com x0;   r = F
  neg x0;   r = 0, x0 = 1;
  jmp trap;
  ALIGN
trap: jmp trap;

