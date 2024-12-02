% load in the data

load workkspace('vectors_orig_dest_numpermonth').mat

% make it usable
L=length(origin2letters);

originasnumber=zeros(L, 1);
destasnumber=zeros(L, 1)

letterdictlettercell=unique(origin2letters);
for aa=1:length(letterdictlettercell)
    
letterdictletter(aa, :)=letterdictlettercell{aa};
end
b=length(letterdictletter);
letterdictnumber=[1:b]';


for a=1:L
   
    letters2=dest2letters{a};
    
   f=find(letterdictletter(:, 1)==letters2(1)&letterdictletter(:, 2)==letters2(2)); 
   
       
    destasnumber(a)=letterdictnumber(f);
    
    
    letters=origin2letters{a};
     f=find(letterdictletter(:, 1)==letters(1)&letterdictletter(:, 2)==letters(2)); 
   
       
   originasnumber(a)=letterdictnumber(f);
 
end

%%
bb=225;
%make matrix
M=zeros(bb);
for c=1:bb
    for d=1:bb
        f=find(originasnumber==c &destasnumber==d);
        if length(f)>0, M(c, d)=peoplepermonth(f);
        end
    end
end

%%

%image(M)



s=sum(M);
[so, no]=sort(s);

Msorted=M(no, no);



figure(1)
image(Msorted)



[V, E]=eigs(Msorted);
E=sum(E);
[DE, DEplace]=max(E);

DV=V(:, DEplace);
DVnorm=DV/sum(DV)

[Vl, E]=eigs(M');
E=sum(E);
[DE, DEplace]=max(E);

DV=Vl(:, DEplace);
DVlnorm=DV/sum(DV);
influenceMat=DVlnorm*DVnorm';

%%
figure(2)
image(influenceMat*10000000)
%%
letterdictlettersorted=letterdictletter(no, :)
