
% 1) Use a suitable theoretical model able to predict the output of the Envelope Detector and Voltage Regulator circuits
% 2) Produce the same plots as in simulation by theoretical analysis
% 3) Compute the output DC level and the voltage ripple 

%Envelope Detector

%%%Data

A=AMPLITUDE;
t=linspace(0, 1e-3, 100);
%linspace(base,limit,n);
f=FREQUENCY;
w=2*pi*f;

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
endfor

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("rectified","envelope")
print ("venvlope.eps", "-depsc");


%%%VOLTAGE REGULATOR CIRCUIT
%%%1 RESISTANCE, n DIODES 

n=NUMBER OF DIODES;
vs=INITIAL VOLTAGE;
R=RESISTANCE;
eta=ETA;
vt=XXX;
vd=XXX;
is=XXX;

rd=eta*vt\is\exp(vd/eta/vt);
vout=n*rd/(n*rd+R)*vs;

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
plot(t*1000, vout)
title("voltage regulator (t)")
xlabel ("t[ms]")
legend("rectified","envelope")
print ("venvlope.eps", "-depsc");


%%%VOLTAGE RIPPLE (WITH FULL WAVE RETIFIER CIRCUIT)
T=1/f;
R=RESISTANCE;
C=CAPACITANCE;
vripple=A(1-exp(-T/2/R/C);

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
plot(t*1000, vripple)
title("Ripple voltage (t)")
xlabel ("t[ms]")
legend("rectified","envelope")
print ("venvlope.eps", "-depsc");

