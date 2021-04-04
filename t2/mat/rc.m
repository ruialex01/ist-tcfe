

filename = "data.txt";
fid = fopen (filename, "r");


data=textscan(fid, '%s = %f', 'headerlines', 6)


celldisp(data)



r1=data{2}(1)
r2=data{2}(2)
r3=data{2}(3)
r4=data{2}(4)
r5=data{2}(5)
r6=data{2}(6)
r7=data{2}(7)
Vs=data{2}(8)
C=data{2}(9)
Kb=data{2}(10)
Kd=data{2}(11)



fclose(fid);











