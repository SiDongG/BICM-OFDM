function [Symbols5]=COFDM_Equal(Est,Block_Num,H0,Symbols4,P,NN,F_inv,SNR)
Symbols5=zeros(NN,1,Block_Num);
S=eye(NN);
T=[S(2*NN-P+1:NN,:);S]; 
R=[zeros(NN,P-NN),eye(NN)];
H=R*H0*T;
D=conj(F_inv)*H*F_inv;
if Est==1   %Zero-forcing equalizer
    G_ZF=pinv(D); %Zero-forcing with pesudoinverse
    for a=1:Block_Num
        Symbols5(:,:,a)=G_ZF*Symbols4(:,:,a);
    end       
end
if Est==2   %Minimum Mean Square Error Equalizer
    Var_n=1/sqrt(2*SNR); %Noise and Symbol both equal to 1
    Var_s=1;
    G_MMSE=Var_s^2*D'/(Var_n^2*eye(length(D))+Var_s^2*(D*D'));
    for a=1:Block_Num
        Symbols5(:,:,a)=G_MMSE*Symbols4(:,:,a);
    end
end
end