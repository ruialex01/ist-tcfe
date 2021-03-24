format long

r1 = 1.04362094375e3
r2 = 2.01060713289e3  
r3 = 3.1012701442e3  
r4 = 4.18822801798e3  
r5 = 3.09414786857e3  
r6 = 2.02739936235e3  
r7 = 1.0022809037e3  
va = 5.02924600001 
idd = 1.03087754949e-3  
kb = 7.2492497599e-3  
kc = 8.29575903566e3 



A=[r1+r3+r4,r3,0,0,0,r4,0;
r4,0,0,0,0,r4+r6+r7-kc,0;
1,0,0,-1,0,1,0;
1/(1-kb*r3),0,-1,0,0,0,0;
0,0,0,0,0,1,-1;
0,1,0,0,1,0,0;
-1,-1,1,0,0,0,0]
C=[va;0;0;0;idd;idd;0]

b=A\C

ia=b(1)
ib=b(2)
i3=b(3)
i4=b(4)
i5=b(5)
ic=b(6)
ivc=b(7)




R=[0,0,0,1,0,0,-1,0,-kc;
 0,0,-1,0,0,0,0,0,0;

 
0,0,0,-1/r5,1/r5,0,0,1,0;
-1/r2,1/r2,0,0,0,0,0,-1,0;
  
  
   0,0,1/r6,0,0,(-1/r6-1/r7),(1/r7),0,0;
  (-1/r1-1/r2-1/r3),1/r2,0,1/r3,0,0,0,0,0;
  kb,0,0,-kb,0,0,0,-1,0;
  
  0,0,1/r6,0,0,-1/r6,0,0,-1;
  
  1/r3,0,1/r4,-1/r3-1/r4-1/r5,1/r5,0,0,0,1;
  
  ]

T=[0;va;idd;0;0;0;0;0;idd]

s=R\T



file1=fopen('octave_tab_current.tex', 'w');

fprintf(file1, '\n Mesh Current Ia & %.11e \\\\ \\hline ', ia);
fprintf(file1, '\n Mesh Current Ib & %.11e \\\\ \\hline ', ib);
fprintf(file1, '\n Mesh Current Ic & %.11e \\\\ \\hline ', ic);
fprintf(file1, '\n Mesh Current Id & %.11e \\\\ \\hline ', idd);
fprintf(file1, '\n Branch Current Ia & %.11e \\\\ \\hline ', ia);
fprintf(file1, '\n Branch Current Ib & %.11e \\\\ \\hline ', ib);
fprintf(file1, '\n Branch Current I3 & %.11e \\\\ \\hline ', i3);
fprintf(file1, '\n Branch Current I4 & %.11e \\\\ \\hline ', i4);
fprintf(file1, '\n Branch Current I5 & %.11e \\\\ \\hline ', i5);
fprintf(file1, '\n Branch Current Ic & %.11e \\\\ \\hline ', ic);
fprintf(file1, '\n Branch Current Ivc & %.11e \\\\ \\hline ', ivc);
fprintf(file1, '\n Branch Current Id & %.11e \\\\ \\hline ', idd);

fclose(file1);

file2=fopen('octave_tab_voltage.tex', 'w');

fprintf(file2, '\n Node Voltage 1 & %.11e \\\\ \\hline ', s(1));
fprintf(file2, '\n Node Voltage 2 & %.11e \\\\ \\hline ', s(2));
fprintf(file2, '\n Node Voltage 3 & %.11e \\\\ \\hline ', s(3));
fprintf(file2, '\n Node Voltage 4 & %.11e \\\\ \\hline ', s(4));
fprintf(file2, '\n Node Voltage 5 & %.11e \\\\ \\hline ', s(5));
fprintf(file2, '\n Node Voltage 6 & %.11e \\\\ \\hline ', s(6));
fprintf(file2, '\n Node Voltage 7 & %.11e \\\\ \\hline ', s(7));


fclose(file2);



%%The following lines until the end of the document have the sole purpose of calculating the rekative errors

%%These are the Ngspice values used to calculate the relative error

%%The symetric of hc#branch was applied due to reasons explained in the report


y=[ 2.354321e-04,
   -2.46392e-04 ,
   -1.09596e-05 ,
   1.150256e-03 ,
   1.277269e-03 ,
   9.148235e-04,
 -1.160540e-04 ,
 -2.45702e-01,
 -7.41099e-01,
 -5.02925e+00,
 -2.11713e-01,
 3.740346e+00,
 -6.88396e+00,
 -7.80087e+00]

z=[ia, ib, i3, i4, i5, ic, ivc, s(1), s(2), s(3), s(4), s(5), s(6), s(7)]


	for i=1:14 
	x(i) = (abs(y(i)-z(i))/abs(y(i)))*100
	endfor


file3=fopen('error_tab.tex', 'w');
     fprintf(file3,'\n Current $I_A$ & %.11e \\\\ \\hline ', x(1));
     fprintf(file3,'\n Current $I_B$ & %.11e \\\\ \\hline ', x(2));
     fprintf(file3,'\n Current $I_3$ & %.11e \\\\ \\hline ', x(3));
     fprintf(file3,'\n Current $I_4$ & %.11e \\\\ \\hline ', x(4));
     fprintf(file3,'\n Current $I_5$ & %.11e \\\\ \\hline ', x(5));
     fprintf(file3,'\n Current $I_C$ & %.11e \\\\ \\hline ', x(6));
     fprintf(file3,'\n Current $I_{Vc}$ & %.11e \\\\ \\hline ', x(7));
     fprintf(file3,'\n Node 1 & %.11e \\\\ \\hline ', x(8));
     fprintf(file3,'\n Node 2 & %.11e \\\\ \\hline ', x(9));
     fprintf(file3,'\n Node 3 & %.11e \\\\ \\hline ', x(10));
     fprintf(file3,'\n Node 4 & %.11e \\\\ \\hline ', x(11));
     fprintf(file3,'\n Node 5 & %.11e \\\\ \\hline ', x(12));
     fprintf(file3,'\n Node 6 & %.11e \\\\ \\hline ', x(13));
     fprintf(file3,'\n Node 7 & %.11e \\\\ \\hline ', x(14));
fclose(file3)














