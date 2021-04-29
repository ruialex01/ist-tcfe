
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


%%%VOLTAGE REGULATOR CIRCUIT
%%%1 RESISTANCE, n DIODES 

n=17;
vout=zeros(1, length(t));
vOUT=zeros(1, length(t));
R2=10e3;
eta=1;
vt=25e-3;
vd=0.7;
is=1e-14;

rd=eta*vt/is/exp(vd/eta/vt);
vout=n*rd/(n*rd+R2)*vO;
VOUT=n*vd;
vOUT=vout+VOUT;

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
figure
plot(t*1000, vOUT)
title("voltage regulator (t)")
xlabel ("t[ms]")
legend("Voltage Regulator Output")
print ("output.eps", "-depsc");

%%%VOLTAGE RIPPLE (WITH FULL WAVE RETIFIER CIRCUIT)

vripple=max(vOUT)-min(vOUT);

printf("The output ripple is %d V",vripple)

%%%PLOT (CHANGE SUBTITLES, LEGEND AND PRINTS)
figure
plot(t*1000, vOUT-12 )
title("vOUT-12 voltage (t)")
xlabel ("t[ms]")
legend("Output difference")
print ("outputdiff.eps", "-depsc");


%%%%%%%%%%%%Figure of Merit

cost=(R+R2)*0.001+C*0.000001+0.1*(4+n)

M=1/cost/(vripple+average+0.000001)

printf("The merit figure is %f MU", M)




