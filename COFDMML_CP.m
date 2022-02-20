function [Symbols_CP,F_inv]=COFDMML_CP(Symbols,N,Block_Num)
F_inv=zeros(N);
for a=1:N
    for b=1:N
        F_inv(a,b)=exp(1i*2*pi*(a-1)*(b-1)/N);
    end 
end
F_inv=F_inv*1/sqrt(N);
Symbols_CP=zeros(size(Symbols));
for b=1:Block_Num
    Symbols_CP=F_inv*Symbols(:,:,b);
end
S=eye(N);
T=[S(2*N-P+1:N,:);S];
for c=1:Block_Num
    Symbols_CP(:,:,c)=T*Symbols_CP(:,:,c);
end
end
