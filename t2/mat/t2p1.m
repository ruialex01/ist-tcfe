format long

%%These are the given values of all of the circuits' components

filename = "data.txt";
fid = fopen (filename, "r");


data=textscan(fid, '%s = %f', 'headerlines', 6)



r1=data{2}(1)*1000
r2=data{2}(2)*1000
r3=data{2}(3)*1000
r4=data{2}(4)*1000
r5=data{2}(5)*1000
r6=data{2}(6)*1000
r7=data{2}(7)*1000
Vs=data{2}(8)
C=data{2}(9)*0.000001
Kb=data{2}(10)*0.001
Kd=data{2}(11)*1000

fclose(fid);


%auxiliary to the last topic
vs_1=Vs;
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

p=X\Y


ix=p(9)

req=abs(Vx/ix)

printf("A resistencia equivalente é %f \n", req)

tau=req*C

printf("A Constante do Tempo equivalente é %f \n", tau)




file3=fopen('theo_second.tex', 'w');

fprintf(file3, '\n Node Voltage 1 & %.11e \\\\ \\hline ', p(1));
fprintf(file3, '\n Node Voltage 2 & %.11e \\\\ \\hline ', p(2));
fprintf(file3, '\n Node Voltage 3 & %.11e \\\\ \\hline ', p(3));
fprintf(file3, '\n Node Voltage 5 & %.11e \\\\ \\hline ', p(4));
fprintf(file3, '\n Node Voltage 6 & %.11e \\\\ \\hline ', p(5));
fprintf(file3, '\n Node Voltage 7 & %.11e \\\\ \\hline ', p(6));
fprintf(file3, '\n Node Voltage 8 & %.11e \\\\ \\hline ', p(7));
fprintf(file3, '\n Req, Equivalent Resistor & %f \\\\ \\hline ', req);
fprintf(file3, '\n Time Constant & %f \\\\ \\hline ', tau);

fclose(file3);

%%%%%%%%%%%%%%%%%%%%%%NATURAL%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%THEO - P3%%%%%%%%%%

t=0:1e-6:20e-3;

v6n=Vx*exp(-t/tau);


hn = figure ();
plot(t,v6n,"g");


xlabel ("t[s]");
ylabel ("v6n(t) [V]");
print (hn, "natural.eps", "-depsc");



file4=fopen('datafrom2.txt', 'w');

fprintf(file4, '.ic v(n6)=%.11e v(n8)=%.11e\n', p(5), p(7));

fclose(file4);


%%%%%%%%%%%%%%%%%%%%%%FORCED%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%THEO - P4%%%%%%%%%%

f = 1000 %Hz
w = 2*pi*f; %rad/s


Zc = 1/(j*w*C)

%This is the phasor Vs
Vs=e.^(j*(-pi/2));

K=[1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0;

1/r1 , (-1/r1 -1/r2 -1/r3) , 1/r2 , 1/r3, 0 , 0 , 0 , 0 , 0, 0;

0 , 1/r2 , -1/r2 , 0 , 0 , 0 , 0 , 1 , 0, 0;

0 , 0 , 0 , 1 , 0 , 0 , -1 , 0 , 0, -Kd;

0 , 0 , 0 , -1/r5 , 1/r5 , 0 , 0 , 1 , 1, 0;

0 , 0 , 0 , 0 ,  0 , 1/r7, -1/r7 , 0 , 0, -1;

0 , -Kb , 0 , Kb , 0 , 0 , 0 , 1 , 0, 0;

0 , 1/r3 , 0 , (-1/r3-1/r4-1/r5) , 1/r5 , 0 , 0 , 0 , 1 , 1;

0 , 0 , 0 , 0 , 0 , 1/r6 , 0 , 0, 0, 1;

0 , 0 , 0 , 0 , 1 , 0    , -1 , 0, -Zc, 0 ]

M=[Vs;0;0;0;0;0;0;0;0;0]

l=K\M


v6_mod=abs(l(5));
v6_phase=-angle(l(5));

v8_mod=abs(l(7));
v8_phase=-angle(l(7));


file5=fopen('theo_fourth.tex', 'w');

fprintf(file5, '\n Phasor of Node 1 & %.11e+i%.11e \\\\ \\hline ',real(l(1)), angle(l(1)));
fprintf(file5, '\n Phasor of Node 2 & %.11e+i%.11e \\\\ \\hline ',real(l(2)), angle(l(2)));
fprintf(file5, '\n Phasor of Node 3 & %.11e+i%.11e \\\\ \\hline ',real(l(3)), angle(l(3)));
fprintf(file5, '\n Phasor of Node 5 & %.11e+i%.11e \\\\ \\hline ',real(l(4)), angle(l(4)));
fprintf(file5, '\n Phasor of Node 6 & %.11e+i%.11e \\\\ \\hline ',real(l(5)), angle(l(5)));
fprintf(file5, '\n Phasor of Node 7 & %.11e+i%.11e \\\\ \\hline ',real(l(6)), angle(l(6)));
fprintf(file5, '\n Phasor of Node 8 & %.11e+i%.11e \\\\ \\hline ',real(l(7)), angle(l(7)));

fclose(file5);


%%%%%%%%%%%%%%%%%%%%%%%TOTAL
%%%%%%%%%%THEO - P5%%%%%%%%%%



%%%%%%%%%%%%ATENÇAO AO INTERVALO DE TEMPO!!!!!%%%%%%%%%
%This part is divided in two


taux_1=-5e-3:1e-6:0;

v6_1=s(5);


taux=0:1e-6:20e-3;

vst_2=sin(w*taux);
v6ft_2=v6_mod*cos(w*taux-v6_phase);
v6nt_2=Vx*exp(-taux/tau);

v6t_2=v6nt_2.+v6ft_2;

ht=figure ();
hold on;
plot(taux, v6t_2,"g");
plot(taux, vst_2,"r"); 



line([-5e-3 0], [vs_1 vs_1], "linestyle", "-", "color", "r")
line([-5e-3 0], [v6_1 v6_1], "linestyle", "-", "color", "g")


xlabel ("v6t(t)-green vs(t)-red        t[s]");
ylabel (" [V]");
legend("v6t_2","vst_2");
print (ht, "total.eps", "-depsc");
hold off;

%%%%%%%%%%%%%%%FREQUENCY%%%

freq=logspace(-1,6,400);

Vs=e.^(j*(-pi/2));




for o = 1:400

w(o)=2*pi*freq(o);
Z(o)= 1/(j*w(o)*C);



G=[1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0;

1/r1 , (-1/r1 -1/r2 -1/r3) , 1/r2 , 1/r3, 0 , 0 , 0 , 0 , 0, 0;

0 , 1/r2 , -1/r2 , 0 , 0 , 0 , 0 , 1 , 0, 0;

0 , 0 , 0 , 1 , 0 , 0 , -1 , 0 , 0, -Kd;

0 , 0 , 0 , -1/r5 , 1/r5 , 0 , 0 , 1 , 1, 0;

0 , 0 , 0 , 0 ,  0 , 1/r7, -1/r7 , 0 , 0, -1;

0 , -Kb , 0 , Kb , 0 , 0 , 0 , 1 , 0, 0;

0 , 1/r3 , 0 , (-1/r3-1/r4-1/r5) , 1/r5 , 0 , 0 , 0 , 1 , 1;

0 , 0 , 0 , 0 , 0 , 1/r6 , 0 , 0, 0, 1;

0 , 0 , 0 , 0 , 1 , 0   , -1 , 0, -Z(o), 0 ]

I=[Vs;0;0;0;0;0;0;0;0;0]


h=G\I

v6fq(o)=h(5);
v8fq(o)=h(7);

vcfq(o)=v6fq(o)-v8fq(o);

endfor


v6magn=20*log10(abs(v6fq))
vcmagn=20*log10(abs(vcfq))
vsmagn=20*log10(abs(Vs))


v6phase=(180/pi)*angle(v6fq)+90;
vcphase=(180/pi)*angle(vcfq)+90;
vsphase=(180/pi)*angle(Vs)+90;



hm=figure ();
hold on;
semilogx(freq,v6magn ,"m",freq, vcmagn,"r",freq,vsmagn,"g" );
ylim([-8,5]);
xlabel ("     f[Hz]");
ylabel ("[Decibel]");
legend("v6magn","vcmagn","vsmagn");
print (hm, "magnitude.eps", "-depsc");
hold off;

hph=figure ();
hold on;
semilogx(freq,v6phase,"m", freq,vcphase,"r",freq,vsphase,"g");
xlabel ("     f[Hz]");
ylabel ("[Degrees]");
legend("v6phase","vcphase","vsphase");
print (hph, "phase.eps", "-depsc");
hold off;

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
fprintf(file6,'\n Node & GNU Octave   & NGSpice & Relative Error \\\\ \\hline ');
     fprintf(file6,'\n Node 1 & 5.029246e+00         & %.11e & %.11e \\\\ \\hline ', s(1), g(1));
          fprintf(file6,'\n Node 2 & 4.783544e+00         & %.11e & %.11e \\\\ \\hline ', s(2), g(2));
               fprintf(file6,'\n Node 3 & 4.288147e+00        & %.11e & %.11e \\\\ \\hline ', s(3), g(3));
                    fprintf(file6,'\n Node 4 & 4.817533e+00         & %.11e & %.11e \\\\ \\hline ', s(4), g(4));
                         fprintf(file6,'\n Node 5 & 5.579905e+00         & %.11e & %.11e \\\\ \\hline ', s(5), g(5));
                              fprintf(file6,'\n Node 6 & -1.85471e+00         & %.11e & %.11e \\\\ \\hline ', s(6), g(6));
                                   fprintf(file6,'\n Node 7 & -2.77162e+00         & %.11e & %.11e \\\\ \\hline ', s(7), g(7));
fclose(file6)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%2º ERRO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%The following lines until the end of the document have the sole purpose of calculating the relative errors

%%Matrix y is made of the Ngspice values used to calculate the relative error
%%The symetric of hc#branch was considered due to reasons explained in the report
%%Matrix z are the matching values calculated by octave

h=[ 0.000000e+00,
0.000000e+00,
0.000000e+00,
0.000000e+00,
8.351528e+00,
0.000000e+00,
0.000000e+00]



j=[p(1), p(2), p(3), p(4), p(5), p(6), p(7)]

%%This cycle will calculate the relative error in percentage


	for i=1:7 
	n(i) = (abs(h(i)-p(i))/abs(h(i)))*100
	endfor



%%This wil print the relative errors in a latex table on the report

file7=fopen('error_tab2.tex', 'w');
fprintf(file7,'\n Node & GNU Octave   & NGSpice & Relative Error \\\\ \\hline ');
     fprintf(file7,'\n Node 1 & 0.000000e+00        & %.11e & - \\\\ \\hline ', j(1));
          fprintf(file7,'\n Node 2 & 0.000000e+00         & %.11e & - \\\\ \\hline ', j(2));
               fprintf(file7,'\n Node 3 & 0.000000e+00        & %.11e & - \\\\ \\hline ', j(3));
                    fprintf(file7,'\n Node 5 & 0.000000e+00         & %.11e & - \\\\ \\hline ', j(4));
                         fprintf(file7,'\n Node 6 & 8.351528e+00       & %.11e & %.11e \\\\ \\hline ', j(5), n(5));
                              fprintf(file7,'\n Node 7 & 0.000000e+00         & %.11e & - \\\\ \\hline ', j(6));
                                   fprintf(file7,'\n Node 8 & 0.000000e+00         & %.11e & - \\\\ \\hline ', j(7));
fclose(file7)





