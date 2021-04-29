
% 1) Use a suitable theoretical model able to predict the output of the Envelope Detector and Voltage Regulator circuits
% 2) Produce the same plots as in simulation by theoretical analysis
% 3) Compute the output DC level and the voltage ripple 

%Envelope Detector

%%%Data

A=14;
f=50;
t=linspace(0, 1/2/f, 1000);
%linspace(base,limit,n);
w=2*pi*f;
R=1000
C=100e-6


%%%Equations

vS = A * cos(w*t);
vOhr = zeros(1, length(t));
vO = zeros(1, length(t));

tOFF = 1/w * atan(1/w/R/C);

vOnexp = A*cos(w*tOFF)*exp(-(t-tOFF)/R/C)


%%%I CHANGED THIS TO A FULL-WAVE BRIDGE RECTIFIER, AM I RIGHT?
for i=1:length(t)
  if (vS(i) > 0)
    vOhr(i) = vS(i);
  else
    vOhr(i) = -vS(i);
  endif
endfor

%%%ENVELOPE DETECTOR

for i=1:length(t)
  if t(i) < tOFF
    vO(i) = vOhr(i);
  elseif vOnexp(i) > vOhr(i)
    vO(i) = vOnexp(i);
  else 
    vO(i) = vOhr(i);
  endif
endfor


%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
figure
plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("Output")
print ("envelope.eps", "-depsc");


%%%%Calculating tON using Newton Raphson 


function f = f(tON)
A=14;
w=2*pi*50;
R=1000
C=100e-6
tOFF = 1/w * atan(1/w/R/C);

f=A*cos(w*tON)-A*cos(w*tOFF)*exp(-(tON-tOFF)/R/C);
endfunction

function fd = fd(tON)
A=14;

w=2*pi*50;
R=1000
C=100e-6
tOFF = 1/w * atan(1/w/R/C);

fd=-A*sin(w*tON)+exp(-(tON-tOFF)/R/C)*A*cos(w*tOFF)/R/C;
endfunction


function tON_root = solve_tON ()
  delta = 1e-6;
  x_next = 1/f/5;

  do 
    x=x_next;
    x_next = x  - f(x)/fd(x);
  until (abs(x_next-x) < delta)

  tON_root = x_next;

 return;
endfunction



