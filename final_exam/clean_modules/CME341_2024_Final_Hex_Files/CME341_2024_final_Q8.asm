        org 8'H00;
  load x0, #4'HF;
  com x0;    r = 4'H0
  jnz loop;   should not jump
  NOPCF;
  NOPD8;
  NOPC8;     jump to 8'H07
  jmp loop; shouldn't get here
  neg x0;   r = 4'H1
  jnz loop;  should jump
 ALIGN
loop: jmp loop;   trap here



