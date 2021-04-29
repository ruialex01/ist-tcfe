function fd = fd(tON)
A=14;

w=2*pi*50;
R=1000
C=100e-6
tOFF = 1/w * atan(1/w/R/C);

fd=A*sin(w*tON)+exp(-(tON-tOFF)/R/C)*A*cos(w*tOFF)/R/C;
endfunction
