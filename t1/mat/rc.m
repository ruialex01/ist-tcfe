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



A=[r1+r3+r4-r3*kb*r4-r3*kb*r1,r4-r3*kb*r4;r4,r4+r6+r7-kc]

C=[va-va*r3*kb;0]

b=A\C

i1=b(1)
ic=b(2)

i4=i1+ic
i3=i1/(1-kb*r3)
ivc=ic-idd
i5=i4-i3-ivc
ib=i3-i1


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

fprintf(file1, '\n Current I1 & %.11e \\\\ \\hline ', i1);
fprintf(file1, '\n Current Ib & %.11e \\\\ \\hline ', ib);
fprintf(file1, '\n Current I3 & %.11e \\\\ \\hline ', i3);
fprintf(file1, '\n Current I4 & %.11e \\\\ \\hline ', i4);
fprintf(file1, '\n Current I5 & %.11e \\\\ \\hline ', i5);
fprintf(file1, '\n Current Ic & %.11e \\\\ \\hline ', ic);
fprintf(file1, '\n Current Ivc & %.11e \\\\ \\hline ', ivc);
fprintf(file1, '\n Current Id & %.11e \\\\ \\hline ', idd);

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
























