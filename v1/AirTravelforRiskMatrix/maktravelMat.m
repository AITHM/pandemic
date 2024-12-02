% get data for international flights and turn it into a transitional
% probability matrix
clear all  
D=xlsread('ODS.xls'); %read in a vector file
%turn vector file into matrix, who travels out=row; destination=column
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
image(MOD/1000)

image(MOD/1000)
M=sum(MOD, 2);
POD=diag(1./M)*MOD;

figure(2)
image(POD*1000)


stay1=0.2;
stay2=0.2;
stay3=0.29;
POD2=POD*POD*(1-stay1);
POD3=POD2*POD*(1-stay2);
figure(3)
image(POD3*1000)
POD4=POD3*POD*(1-stay3);

figure(4)
image(POD4*10000)

PP4=M'*POD4;
PP4(168)
PP4(205)

MZ=zeros(size(M'));
MZ71=MZ;
MZ71(71)=M(71);
MZ67=MZ;
MZ67(67)=M(67);
MZ75=MZ;
MZ75(75)=M(75);
MZ90=MZ;
MZ90(90)=M(90);
MZAfrica=MZ;
MZAfrica(45:102)=M(45:102);

MZ163=MZ;
MZ163(163)=M(163);

PODend=(stay1*POD+stay2*POD2+stay3*POD3+POD4);
P4P71=MZ71*PODend;
P4P67=MZ67*POD4;
P4P75=MZ75*POD4;
P4P90=MZ90*POD4;
P4PAfrica=MZAfrica*POD4;
p4Pchina=MZ163*POD4;

lastPOD=diag(M)*PODend;
figure(5)
image(lastPOD)
cs=[168 197 205 209 222 217 227]; %these are the outgoings for IND, TL, AUS, FIJI, PNG NZ VUT
ccs=[168 222 209 197 217 227 224 182 188 202 162 196 179 184 184 172 176 175 115 205];
as=[224, 182, 188, 202, 162, 196, 179, 184, 184, 172, 176, 175, 6];
fromLiberia=P4P71(cs)*12
fromGuinea=P4P67(cs)*12
fromMali=P4P75(cs)*12
fromSL=P4P90(cs)*12
fromAfrica=P4PAfrica(cs)*12
fromChina=p4Pchina(cs)*12


afromLiberia=P4P71(as)*12
afromGuinea=P4P67(as)*12
afromMali=P4P75(as)*12
afromSL=P4P90(as)*12
afromAfrica=P4PAfrica(as)*12
afromChina=p4Pchina(as)*12

alle=[afromGuinea;afromSL; afromLiberia; afromMali; afromChina];

popGLS=[10.6 4.4 6.2]*10^6;
currentincpermonth=[500 1200 3000]; %from Guinea Liberia and Sierra Leone

onwardinc(1, :)=currentincpermonth;
onwardprev(1, :)=onwardinc(1, :)./(popGLS)*(9+4)/30;
for a=2:24
onwardinc(a, :)=2*onwardinc(a-1, :).*(1-sum(onwardinc(1:(a-1), :))./popGLS);
onwardprev(a, :)=onwardinc(a, :)./(popGLS)*(9+4)/30;
end


llcs=lastPOD([67  90 71 75 163], ccs)*12


GSL=[67  90 71];


travelGSL_ITAFP=lastPOD(GSL, cs(1:5))
currentprevGSL=[4.7 46.7 27.3]*(9+4)/30*10^-5

riskpermonth=diag(currentprevGSL)*lastPOD(GSL, :)

onejump=sum(riskpermonth)
oneAU=riskpermonth(:, 205)

m=1;
nextjump=[];nextrisk=[];
 while m>.1
    
    [m n]=max(onejump);
    nextjump=[nextjump; n];
    nextrisk=[nextrisk;m];
    onejump(n)=0;
 end
   nextrisk=nextrisk/sum(nextrisk);
riskpermonth2=10^-4*diag(nextrisk)*lastPOD(nextjump, :)
 
 twojumpout=[nextjump, riskpermonth2(:, 205)]
 
 twojump=sum(riskpermonth2);
 m=1;
nextjump=[];nextrisk=[];
 while m>.1
    
    [m n]=max(twojump);
    nextjump=[nextjump; n];
    nextrisk=[nextrisk;m];
    twojump(n)=0;
 end
  nextrisk=nextrisk/sum(nextrisk);
 riskpermonth3=10^-4*diag(nextrisk)*lastPOD(nextjump, :)
 
 threejump=[nextjump, riskpermonth3(:, 205)]