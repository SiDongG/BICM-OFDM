function [Symbols2,F_inv]=COFDM_IFFTCP(F,L,Symbols,Block_Num)
P=F+L;
F_inv=zeros(F);
for a=1:F
    for b=1:F
        F_inv(a,b)=exp(1i*2*pi*(a-1)*(b-1)/F);
    end 
end
F_inv=F_inv*1/sqrt(F);
Symbols1=zeros(size(Symbols));
for b=1:Block_Num
    Symbols1(:,:,b)=F_inv*Symbols(:,:,b);
end
S=eye(F);
T=[S(2*F-P+1:F,:);S];
Symbols2=zeros(P,1,Block_Num);
for c=1:Block_Num
    Symbols2(:,:,c)=T*Symbols1(:,:,c);
end
end