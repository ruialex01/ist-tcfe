
A=14;
f=50;
t=linspace(0, 10/f, 100);
%linspace(base,limit,n);
w=2*pi*f;
R=100;
C=100e-6

%%%Equations

vS = A * cos(w*t);
vOhr = zeros(1, length(t));
vO = zeros(1, length(t));

tOFF = 1/w * atan(1/w/R/C);

vOnexp = A*cos(w*tOFF)*exp(-(t-tOFF)/R/C)

figure
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
    vO(i) = vS(i);
  elseif vOnexp(i) > vOhr(i)
    vO(i) = vOnexp(i);
  else 
    vO(i) = vS(i);
  endif
  tOFF=tOFF+1/f/2;
endfor

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("rectified","envelope")
print ("venvlope.eps", "-depsc");


