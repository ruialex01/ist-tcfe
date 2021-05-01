
% 1) Use a suitable theoretical model able to predict the output of the Envelope Detector and Voltage Regulator circuits
% 2) Produce the same plots as in simulation by theoretical analysis
% 3) Compute the output DC level and the voltage ripple 

%Envelope Detector

%%%Data

A=14;
T=1/50;
t=linspace(0, T/2, 1000);
%linspace(base,limit,n);
w=2*pi*(1/T);
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

%%%Newton-Raphson to find tON

function tON_root =solve_tON ()
  delta = 1e-5;
  x_next = 0.008695;

  do 
    x=x_next;
    x_next = x-f(x)/fd(x);
  until (abs(x_next-x) < delta)

  tON_root = x_next;

 return;
endfunction

tON=solve_tON ()

%%%Average 


%integral of vOUT=n*rd/(n*rd+R2)*vOhr+n*vd for [0,tOFF]

sum1=n*rd/(n*rd+R2)*A/w*sin(w*tOFF)+n*vd*tOFF;


%integral of vOUT=n*rd/(n*rd+R2)*vOnexp+n*vd for [tOFF,tON]

sum2=n*rd/(n*rd+R2)*(-A*R*C*cos(tOFF*w)*(exp((tOFF-tON)/R/C)-1))+n*vd*(tON-tOFF)


%integral of vOUT=n*rd/(n*rd+R2)*vOhr+n*vd for [tON,T/2]

sum3=n*rd/(n*rd+R2)*A/w*(sin(w*T/2)-sin(w*tON))+n*vd*(T/2-tON);


average=(sum1+sum2+sum3)/(T/2);

printf("The average is %d V \n", average)

%%%VOLTAGE RIPPLE (WITH FULL WAVE RETIFIER CIRCUIT)

vripple=max(vOUT)-min(vOUT);

printf("The output ripple is %d V \n",vripple)

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

printf("The merit figure is %f MU \n", M)




