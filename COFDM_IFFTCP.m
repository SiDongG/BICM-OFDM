function [Symbols2,F_inv]=COFDM_IFFTCP(NN,L,Symbols,Block_Num)
P=NN+L;
F_inv=zeros(NN);
for a=1:NN
    for b=1:NN
        F_inv(a,b)=exp(1i*2*pi*(a-1)*(b-1)/NN);
    end 
end
F_inv=F_inv*1/sqrt(NN);
Symbols1=zeros(size(Symbols));
for b=1:Block_Num
    Symbols1(:,:,b)=F_inv*Symbols(:,:,b);
end
S=eye(NN);
T=[S(2*NN-P+1:NN,:);S];
Symbols2=zeros(P,1,Block_Num);
for c=1:Block_Num
    Symbols2(:,:,c)=T*Symbols1(:,:,c);
end
end