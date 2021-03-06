%% BICM-OFDM-ML-ZP-MMSE-LinearMMSE
% Author: Sidong Guo
% Date: Feb 19th 
% N=4 tentatively, rate 1/2 coded into n=8, 4 subcarriers. 
% More subcarriers would be too costly for MLE
clear;clc;close all;
%% Parameter initialization
N=4;
P=6;
L=2;
tp=2;
LC=3;
Block_Num=5;
M=4;

%% 1/2 Conv coded bits generation into block form
Bits=randi(0:1,[1,N,Block_Num]);
Trellis=poly2trellis(3,[7,5]);
Coded_bits=zeros(1,N/0.5,Block_Num);

for i=1:Block_Num
    Coded_bits(:,:,i)=convenc(Bits(:,:,i),Trellis);
end

%% 4-QAM Modulation
Coded_bits_dec=zeros(1,N,Block_Num);
for i=1:Block_Num
    for k=1:log2(M):2*N/log2(M)
        Coded_bits_dec(:,(k+1)/2,i)=bin2dec(num2str(Coded_bits(:,k:k+log2(M)-1,i)));
    end
end
Symbols=qammod(Coded_bits_dec,4)*sqrt(0.5);

%% FFT matrix for faster computation
F_inv=zeros(N);
for a=1:N
    for b=1:N
        F_inv(a,b)=exp(1i*2*pi*(a-1)*(b-1)/N);
    end 
end
F_inv=F_inv*1/sqrt(N);
Symbols_CP=zeros(size(Symbols));
for b=1:Block_Num
    Symbols_CP(:,:,b)=(F_inv*Symbols(:,:,b).').';
end

%% Cyclic Prefix 
S=eye(N);
T=[S(2*N-P+1:N,:);S];
Symbols_CP2=zeros(1,P,Block_Num);
for c=1:Block_Num
    Symbols_CP2(:,:,c)=(T*Symbols_CP(:,:,c).').';
end

%% Channel
for num=1:10
    h=(1/sqrt(2*(LC)))*(randn(1,LC)+1i*randn(1,LC));
    H0=zeros(P); %Preallocating for speed, H0 is the P by P matrix have the (i,j)th entry h(i-j)
    H1=zeros(P); %Preallocating for speed, H1 is the P by P matrix have the (i,j)th entry h(P+i-j)
    a=1;
    while a<P+1  %generate the channel matrces
        b=1;
        while b<P+1
            if a-b<0 || a-b>LC-1
                H0(a,b)=0;
            else
                H0(a,b)=h(a-b+1);
            end
            if P+a-b<0 || P+a-b>LC-1
                H1(a,b)=0;
            else
                H1(a,b)=h(P+a-b+1);
            end
            b=b+1;
        end
        a=a+1;
    end
    
    for SNRdb=0:2:10
        Noise=(sqrt(2)/2)*(randn(P,1,Block_Num)+1i*randn(P,1,Block_Num));
        SNR=10^(SNRdb/10);
        Symbol_rec=zeros(1,P,Block_Num);
        for a=1:Block_Num
            if a==1
                Insertion2=zeros(P,1);
            else
                Insertion2=Symbols_CP2(:,:,a-1).';
            end
            Symbol_rec(:,:,a)=(H0*Symbols_CP2(:,:,a).'+H1*Insertion2+(1/sqrt(SNR))*Noise(:,:,a)).';
        end
    end
    
end






