%gain stage

VT=25e-3
BFN=178.7
VAFN=69.7
RE1=100
RC1=800
RB1=80000
RB2=18000
VBEON=0.7
VCC=12
RS=100

RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1


gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

RSB=RB*RS/(RB+RS)

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

RE1=0
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

RE1=100
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)))
ZX = ro1*(   1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB)  )/(   1/RE1+1/(rpi1+RSB) ) 
ZO1 = 1/(1/ZX+1/RC1)

RE1=0
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZO1 = 1/(1/ro1+1/RC1)

%ouput stage
BFP = 227.3
VAFP = 37.2
RE2 = 750
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

AV2 = gm2/(gm2+gpi2+go2+ge2)
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)
ZO2 = 1/(gm2+gpi2+go2+ge2)


%total
gB = 1/(1/gpi2+ZO1)
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1
AV_DB = 20*log10(abs(AV))
ZI=ZI1
ZO=1/(go2+gm2/gpi2*gB+ge2+gB)
%%%%%%%%%%%Lower Cut-Off Frequency%%%%%%%%%%%%%%%

CI=50e-6
CE=50e-6
CO=1e-6

f_low=1/(min([ZI1*CI,ZO2*CO,1/gm1*CE]))/2/pi()



%%%%%%%%%%%%%%Frequency Analysis Graph%%%%%%%%%%%


freq=logspace(10,1e8,70);

for o = 1:70

if(freq(o)>f_low)
y(o)=AV_DB
else
y(o)=-o
endif

endfor


ht=figure ();
hold on;

plot(freq,y,"g");

xlim([0,1e8]);
ylim([0,80]);
xlabel ("Frequency [Hz]");
ylabel ("Gain [dB]");
legend("vo(f)/vi(f)");
print (ht, "gain.eps", "-depsc");
hold off;

%%%%%%%%%%%%%%End of Frequency Analysis Graph%%%%





%%%%%%%%Theoretical Analysis Tables%%%%%%%%%%%%%%
%%%%%%%%Gain Stage table%%%%%%%%%%%%%%%%%%%%%%%%%

file1=fopen('gain_stage_values.tex', 'w');
fprintf(file1,'\n Voltage Gain     &  %f   \\\\ \\hline', AV1);
fprintf(file1,'\n Input Impedance  &  %f   \\\\ \\hline', ZI1);
fprintf(file1,'\n Output Impedance &  %f   \\\\ \\hline', ZO1);
fclose(file1)


%%%%%%%%Output Stage Table%%%%%%%%%%%%%%%%%%%%%%%

file2=fopen('output_stage_values.tex', 'w');
fprintf(file2,'\n Voltage Gain     &  %f   \\\\ \\hline', AV2);
fprintf(file2,'\n Input Impedance  &  %f   \\\\ \\hline', ZI2);
fprintf(file2,'\n Output Impedance &  %f   \\\\ \\hline', ZO2);
fclose(file2)

%%%%%%%End of Stage Tables %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%Merit Figure%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c_resistors=(RS+RE1+RC1+RB1+RB2+RE2+8)*0.001
c_capacitors=(CI+CE+CO)*1e6
c_transistors=0.2

cost=c_resistors+c_capacitors+c_transistors

voltage_gain=10^(37.93/20)

merit=(2.180e6*voltage_gain)/(cost*(1.005e4))

file3=fopen('merit.tex', 'w');
fprintf(file3,"Merit Figure & %f \\\\ \\hline", merit);     
fclose(file3)




