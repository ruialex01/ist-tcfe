function f = f(tON)
A=14;
w=2*pi*50;
R=1000
C=100e-6
tOFF = 1/w * atan(1/w/R/C);

f=-A*cos(w*tON)-A*cos(w*tOFF)*exp(-(tON-tOFF)/R/C);
endfunction

