
% 1) Use a suitable theoretical model able to predict the output of the Envelope Detector and Voltage Regulator circuits
% 2) Produce the same plots as in simulation by theoretical analysis
% 3) Compute the output DC level and the voltage ripple 

%Envelope Detector

%%%Data

A=14;
f=50;
t=linspace(0, 10/f, 100);
%linspace(base,limit,n);
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
  tOFF=tOFF+1/f/2;
endfor

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("rectified","envelope")
print ("venvlope.eps", "-depsc");


%%%VOLTAGE REGULATOR CIRCUIT
%%%1 RESISTANCE, n DIODES 

n=17;
vout(i)=zeros(1, length(t));
vOUT(i)=zeros(1, length(t));
R=10e3;
eta=1;
vt=25e-3;
vd=0.7;
is=1e-14;

rd=eta*vt\is\exp(vd/eta/vt);
vout(i)=n*rd/(n*rd+R)*vO(i);
VOUT=n*vd;
vOUT(i)=vout(i)+VOUT;

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
plot(t*1000, vOUT(i))
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

