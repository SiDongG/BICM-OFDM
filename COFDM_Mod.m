function [Symbols,NN,PSF]=COFDM_Mod(N,Block_Num,M,Coded_bits,Rate)
S=zeros(1,length(Coded_bits)/log2(M));
NN=N/(log2(M)*Rate);
Symbols=zeros(NN,1,Block_Num);
for a=1:length(S)
    S(a)=bin2dec(num2str(Coded_bits(2*a-1:2*a+log2(M)-2)));
end
S2=qammod(S,M);
if M==2
    PSF=1;
elseif M==4
    PSF=2;
elseif M==8
    PSF=6;
elseif M==16
    PSF=10;
elseif M==32
    PSF=20;
else
    PSF=42;
end
S2=S2*sqrt(1/PSF);
for a=1:Block_Num
    Symbols(:,:,a)=S2(1+(a-1)*NN:a*NN).';
end