% get data for international flights and turn it into a transitional
% probability matrix
clear all  
DD=xlsread('origdestOAGnums.xls'); %read in a vector file
%turn vector file into matrix, who travels out=row; destination=column
D=DD(:, 3);
D=[D, DD(:, 5)];
D=[D, DD(:, 1)];

sd=max(D(:, 1));
MOD=zeros(sd);

for a=1:size(D, 1)
    
    MOD(D(a, 1), D(a, 2))=D(a, 3);
end
%now remove all of the diagonals, local travel not interesting here
for a=1:sd
    
    MOD(a, a)=0;
end


figure(1)
image(MOD)


E=DD(:, 2);
E=[E, DD(:, 4)];
E=[E, DD(:, 1)];

sd=max(E(:, 1));
MODE=zeros(sd);

for a=1:size(E, 1)
    
    MODE(E(a, 1), E(a, 2))=E(a, 3);
end
%now remove all of the diagonals, local travel not interesting here
for a=1:sd
    
    MODE(a, a)=0;
end


figure(10)
image(MODE)
arrive=[92	160	65	199	155	218	177	143	161	217	105	197	114	131	206	102	110	109	24	11];
leave=[79	184	118	130	43	161	92];
MYOUTPUT=MODE(leave, arrive)
xlswrite('importdata.xls', MYOUTPUT)
