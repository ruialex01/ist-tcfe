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

%%%%%%%%%%THEO - P1%%%%%%%%%%

%%In this part, all of the node voltages will be calculated using the Nodal Analysis Method

R=[1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0;

1/r1 , (-1/r1 -1/r2 -1/r3) , 1/r2 , 1/r3, 0 , 0 , 0 , 0 , 0, 0;

0 , 1/r2 , -1/r2 , 0 , 0 , 0 , 0 , 1 , 0, 0;

0 , 0 , 0 , 1 , 0 , 0 , -1 , 0 , 0, -Kd;

0 , 0 , 0 , -1/r5 , 1/r5 , 0 , 0 , 1 , 1, 0;

0 , 0 , 0 , 0 ,  0 , 1/r7, -1/r7 , 0 , 0, -1;

0 , -Kb , 0 , Kb , 0 , 0 , 0 , 1 , 0, 0;

0 , 1/r3 , 0 , (-1/r3-1/r4-1/r5) , 1/r5 , 0 , 0 , 0 , 1 , 1;

0 , 0 , 0 , 0 , 0 , 1/r6 , 0 , 0, 0, 1;

0 , 0 , 0 , 0 , 0 , 0    , 0 , 0, 1, 0 ]

T=[Vs;0;0;0;0;0;0;0;0;0]

s=R\T

%%This will print the results of the Nodal Analysis in a table

file1=fopen('theo_first.tex', 'w');

fprintf(file1, '\n Node Voltage 1 & %.11e \\\\ \\hline ', s(1));
fprintf(file1, '\n Node Voltage 2 & %.11e \\\\ \\hline ', s(2));
fprintf(file1, '\n Node Voltage 3 & %.11e \\\\ \\hline ', s(3));
fprintf(file1, '\n Node Voltage 5 & %.11e \\\\ \\hline ', s(4));
fprintf(file1, '\n Node Voltage 6 & %.11e \\\\ \\hline ', s(5));
fprintf(file1, '\n Node Voltage 7 & %.11e \\\\ \\hline ', s(6));
fprintf(file1, '\n Node Voltage 8 & %.11e \\\\ \\hline ', s(7));

fclose(file1);

vaux=s(5)-s(7) 

file2=fopen('datafrom1.txt', 'w');

fprintf(file2, 'Vx n6 n8 %.11e\n', vaux);

fclose(file2);

%%%%%%%%%%THEO - P2%%%%%%%%%%

Vs=0
Vx=s(5)-s(7)

X=[1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0;

1/r1 , (-1/r1 -1/r2 -1/r3) , 1/r2 , 1/r3, 0 , 0 , 0 , 0 , 0, 0;

0 , 1/r2 , -1/r2 , 0 , 0 , 0 , 0 , 1 , 0, 0;

0 , 0 , 0 , 1 , 0 , 0 , -1 , 0 , 0, -Kd;

0 , 0 , 0 , -1/r5 , 1/r5 , 0 , 0 , 1 , 1, 0;

0 , 0 , 0 , 0 ,  0 , 1/r7, -1/r7 , 0 , 0, -1;

0 , -Kb , 0 , Kb , 0 , 0 , 0 , 1 , 0, 0;

0 , 1/r3 , 0 , (-1/r3-1/r4-1/r5) , 1/r5 , 0 , 0 , 0 , 1 , 1;

0 , 0 , 0 , 0 , 0 , 1/r6 , 0 , 0, 0, 1;

0 , 0 , 0 , 0 , 1 , 0    , -1 , 0, 0, 0 ]

Y=[Vs;0;0;0;0;0;0;0;0;Vx]

w=X\Y

ix=w(9)

req=abs(Vx/ix)

printf("A resistencia equivalente é %f \n", req)

tau=req*C

printf("A Constante do Tempo equivalente é %f \n", tau)




file3=fopen('theo_second.tex', 'w');

fprintf(file3, '\n Node Voltage 1 & %.11e \\\\ \\hline ', w(1));
fprintf(file3, '\n Node Voltage 2 & %.11e \\\\ \\hline ', w(2));
fprintf(file3, '\n Node Voltage 3 & %.11e \\\\ \\hline ', w(3));
fprintf(file3, '\n Node Voltage 5 & %.11e \\\\ \\hline ', w(4));
fprintf(file3, '\n Node Voltage 6 & %.11e \\\\ \\hline ', w(5));
fprintf(file3, '\n Node Voltage 7 & %.11e \\\\ \\hline ', w(6));
fprintf(file3, '\n Node Voltage 8 & %.11e \\\\ \\hline ', w(7));
fprintf(file3, '\n Req, Equivalent Resistor & %f \\\\ \\hline ', req);
fprintf(file3, '\n Time Constant & %f \\\\ \\hline ', tau);

fclose(file3);

%%%%%%%%%%%%%%%%%%%%%%NATURAL%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%THEO - P3%%%%%%%%%%

t=0:1e-6:20e-3;

v6n=Vx*exp(-t/tau);


hn = figure ();
plot(t,v6n,"g");


xlabel ("t[ms]");
ylabel ("v6n(t) [V]");
print (hn, "natural.eps", "-depsc");



file4=fopen('datafrom2.txt', 'w');

fprintf(file4, '.ic v(n6)=%.11e v(n8)=%.11e\n', w(5), w(7));

fclose(file4);


%%%%%%%%%%%%%%%%%%%%%%FORCED%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%THEO - P4%%%%%%%%%%

f = 1000 %Hz
w = 2*pi*f; %rad/s


Zc = 1/(j*w*C)
Cgain = Zc/(req+Zc)
Gain = abs(Cgain)
Phase = angle(Cgain)


%Vs=sin(wt)=cos(pi/2-wt)=e.^j(pi/2-w*(20e-3))=e.^j(pi/2-40*pi)=e.^j(pi/2) 


Vs=e.^(j*(pi/2));

K=[1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0;

1/r1 , (-1/r1 -1/r2 -1/r3) , 1/r2 , 1/r3, 0 , 0 , 0 , 0 , 0, 0;

0 , 1/r2 , -1/r2 , 0 , 0 , 0 , 0 , 1 , 0, 0;

0 , 0 , 0 , 1 , 0 , 0 , -1 , 0 , 0, -Kd;

0 , 0 , 0 , -1/r5 , 1/r5 , 0 , 0 , 1 , 1, 0;

0 , 0 , 0 , 0 ,  0 , 1/r7, -1/r7 , 0 , 0, -1;

0 , -Kb , 0 , Kb , 0 , 0 , 0 , 1 , 0, 0;

0 , 1/r3 , 0 , (-1/r3-1/r4-1/r5) , 1/r5 , 0 , 0 , 0 , 1 , 1;

0 , 0 , 0 , 0 , 0 , 1/r6 , 0 , 0, 0, 1;

0 , 0 , 0 , 0 , 0 , 0    , 0 , 0, 1, 0 ]

M=[Vs;0;0;0;0;0;0;0;0;Vx/Zc]

l=K\M

%v6f=j*((pi/2)-w*t).*(1-e.^(-t/tau));


file5=fopen('theo_fourth.tex', 'w');

fprintf(file5, '\n Amplitude of Node Voltage 1 & %.11e \\\\ \\hline ', angle(l(1)));
fprintf(file5, '\n Amplitude of Node Voltage 2 & %.11e \\\\ \\hline ', angle(l(2)));
fprintf(file5, '\n Amplitude of Node Voltage 3 & %.11e \\\\ \\hline ', angle(l(3)));
fprintf(file5, '\n Amplitude of Node Voltage 5 & %.11e \\\\ \\hline ', angle(l(4)));
fprintf(file5, '\n Amplitude of Node Voltage 6 & %.11e \\\\ \\hline ', angle(l(5)));
fprintf(file5, '\n Amplitude of Node Voltage 7 & %.11e \\\\ \\hline ', angle(l(6)));
fprintf(file5, '\n Amplitude of Node Voltage 8 & %.11e \\\\ \\hline ', angle(l(7)));

fclose(file5);


%%%%%%%%%%%%%%%%%%%%%%%TOTAL
%%%%%%%%%%THEO - P5%%%%%%%%%%



%%%%%%%%%%%%ATENÇAO AO INTERVALO DE TEMPO!!!!!%%%%%%%%%

taux=(-5e-3):1e-6:20e-3;

v6ft=sin(w*taux).*(1-e.^(-taux/tau));

v6nt=Vx*exp(-taux/tau);


v6t=v6nt.+v6ft;
ht=figure ();
plot(taux,v6t,"p");
xlabel ("t[ms]");
ylabel ("v6t(t) [V]");
print (ht, "total.eps", "-depsc");


%%%%%%%%%%%%%%%FREQUENCY%%%

f=logspace(-1,6,7*5);

w=2*pi*f;

vsfq=j*(pi/2-w*(20e-3));

v6fq=Vx.*exp(-20e-3/tau).+vsfq.*(1-exp(-20e-3/tau));

v8fq=s(7).*exp(-20e-3/tau).+vsfq*(1-exp(-20e-3/tau));

vcfq=v6fq.-v8fq;



hm=figure ();
plot(f,abs(v6fq),"p",abs(vcfq),"r",abs(vsfq),"g" );
xlabel ("f[Hz]");
ylabel ("v6f(t) [V]");
print (hm, "magnitude.eps", "-depsc");

hph=figure ();
plot(f,angle(v6fq),"p",angle(vcfq),"r",angle(vsfq),"g");
xlabel ("f[Hz]");
ylabel ("v6t(t) [V]");
print (hph, "phase.eps", "-depsc");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%1º ERRO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%The following lines until the end of the document have the sole purpose of calculating the relative errors

%%Matrix y is made of the Ngspice values used to calculate the relative error
%%The symetric of hc#branch was considered due to reasons explained in the report
%%Matrix z are the matching values calculated by octave

e=[ 5.029246e+00,
4.783544e+00,
4.288147e+00,
4.817533e+00,
5.579905e+00,
-1.85471e+00,
-2.77162e+00]



f=[s(1), s(2), s(3), s(4), s(5), s(6), s(7)]

%%This cycle will calculate the relative error in percentage


	for i=1:7 
	g(i) = (abs(e(i)-f(i))/abs(e(i)))*100
	endfor



%%This wil print the relative errors in a latex table on the report

file6=fopen('error_tab1.tex', 'w');
     fprintf(file6,'\n Node 1 & 5.029246e+00         & %.11e & %.11e \\\\ \\hline ', s(1), g(1));
          fprintf(file6,'\n Node 2 & 4.783544e+00         & %.11e & %.11e \\\\ \\hline ', s(2), g(2));
               fprintf(file6,'\n Node 3 & 4.288147e+00        & %.11e & %.11e \\\\ \\hline ', s(3), g(3));
                    fprintf(file6,'\n Node 4 & 4.817533e+00         & %.11e & %.11e \\\\ \\hline ', s(4), g(4));
                         fprintf(file6,'\n Node 5 & 5.579905e+00         & %.11e & %.11e \\\\ \\hline ', s(5), g(5));
                              fprintf(file6,'\n Node 6 & -1.85471e+00         & %.11e & %.11e \\\\ \\hline ', s(6), g(6));
                                   fprintf(file6,'\n Node 7 & -2.77162e+00         & %.11e & %.11e \\\\ \\hline ', s(7), g(7));
fclose(file6)















