format long

%%These are the given values of all of the circuits' components

r1 = 1.04362094375e3 
r2 = 2.01060713289e3 
r3 = 3.1012701442e3
r4 = 4.18822801798e3 
r5 = 3.09414786857e3 
r6 = 2.02739936235e3 
r7 = 1.0022809037e3 
Vs = 5.02924600001 
C = 1.03087754949e-6
Kb = 7.2492497599e-3 
Kd = 8.29575903566e3




%%In this part, all of the node voltages will be calculated using the Nodal Analysis Method

R=[1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0;

1/r1 , (-1/r1 -1/r2 -1/r3) , 1/r2 , 0 , 1/r3 , 0 , 0 , 0 , 0, 0;

0 , 1/r2 , -1/r2 , 0 , 0 , 0 , 0 , 1 , 0, 0;

0 , 0 , 0 , 1 , 0 , 0 , -1 , 0 , 0, -Kd;

0 , 0 , 0 , -1/r5 , 1/r5 , 0 , 0 , 1 , 1, 0;

0 , 0 , 1 , 0 ,  0 , 1/r7, -1/r7 , 0 , 0, 1;

0 , -1/Kb , 0 , 1/Kb , 0 , 0 , 0 , 1 , 0, 0;

0 , 1/r3 , 0 , (-1/r3-1/r4-1/r5) , 1/r5 , 0 , 0 , 0 , 1 , 1;

0 , 0 , 0 , 0 , 0 , 1/r6 , 0 , 0, 0, 0;
0 , 0 , 0 , 0 , 0 , 0    , 0 , 0, 1, 0 ]

T=[Vs;0;0;0;0;0;0;0;0;0]

s=R\T




%%This will print the results of the Nodal Analysis in a table

file1=fopen('octave_tab_voltage.tex', 'w');

fprintf(file1, '\n Node Voltage 1 & %.11e \\\\ \\hline ', s(1));
fprintf(file1, '\n Node Voltage 2 & %.11e \\\\ \\hline ', s(2));
fprintf(file1, '\n Node Voltage 3 & %.11e \\\\ \\hline ', s(3));
fprintf(file1, '\n Node Voltage 5 & %.11e \\\\ \\hline ', s(4));
fprintf(file1, '\n Node Voltage 6 & %.11e \\\\ \\hline ', s(5));
fprintf(file1, '\n Node Voltage 7 & %.11e \\\\ \\hline ', s(6));
fprintf(file1, '\n Node Voltage 8 & %.11e \\\\ \\hline ', s(7));


fclose(file1);


Vs=0
Vx=s(5)-s(7)

X=[1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0;

1/r1 , (-1/r1 -1/r2 -1/r3) , 1/r2 , 0 , 1/r3 , 0 , 0 , 0 , 0, 0;

0 , 1/r2 , -1/r2 , 0 , 0 , 0 , 0 , 1 , 0, 0;

0 , 0 , 0 , 1 , 0 , 0 , -1 , 0 , 0, -Kd;

0 , 0 , 0 , -1/r5 , 1/r5 , 0 , 0 , 1 , 1, 0;

0 , 0 , 1 , 0 ,  0 , 1/r7, -1/r7 , 0 , 0, 1;

0 , -1/Kb , 0 , 1/Kb , 0 , 0 , 0 , 1 , 0, 0;

0 , 1/r3 , 0 , (-1/r3-1/r4-1/r5) , 1/r5 , 0, 0 , 0 , 1 , 1;

0 , 0 , 0 , 0 , 0 , 1/r6 , 0 , 0, 0, 0;
0 , 0 , 0 , 0 , 1 , 0    , -1 , 0, 0, 0 ]

Y=[Vs;0;0;0;0;0;0;0;0;Vx]

w=X\Y

ix=w(9)

req=(Vx/ix)

printf("A resistencia equivalente é %f \n", req)

tau=req*C

printf("A Constante do Tempo equivalente é %f \n", tau)


t=0:1e-6:20e-3;

v6n=Vx*exp(-t/tau);


hn = figure ();
plot(t,v6n,"g");

xlabel ("t[ms]");
ylabel ("v6n(t) [V]");
print (hn, "natural.eps", "-depsc");


%%%%%%%%%%%%%%%%%%%%%%FORCED%%%%%%%%%%%%%%%%%%%%%%%%%%%




t=0:1e-6:20e-3;


f = 1000 %Hz
w = 2*pi*f; %rad/s


Zc = 1/(j*w*C)
Cgain = Zc/(req+Zc)
Gain = abs(Cgain)
Phase = angle(Cgain)



v6f=sin(w*t)*(1-exp(-t/tau));

%vs=j(pi/2-w*t);

hf = figure ();
plot(t,v6f,"r");

xlabel ("t[ms]");
ylabel ("v6f(t) [V]");
print (hf, "forced.eps", "-depsc");


%%%%%%%%%%%%%%%%%%%%%%%TOTAL

v6t=v6n+v6f

ht=figure ();
plot(t,v6t,"p");

xlabel ("t[ms]");
ylabel ("v6t(t) [V]");
print (hf, "total.eps", "-depsc");



























