
% 1) Use a suitable theoretical model able to predict the output of the Envelope Detector and Voltage Regulator circuits
% 2) Produce the same plots as in simulation by theoretical analysis
% 3) Compute the output DC level and the voltage ripple 

%Envelope Detector

%%%Data

A=14;

t=linspace(0, 1/2/50, 1000);
%linspace(base,limit,n);
w=2*pi*50;
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


function tON_root =solve_tON ()
  delta = 2e-4;
  x_next = 0.0085;

  do 
    x=x_next;
    x_next = x-f(x)/fd(x);
  until (abs(x_next-x) < delta)

  tON_root = x_next;

 return;
endfunction

a=solve_tON ()


