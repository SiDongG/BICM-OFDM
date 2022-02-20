function [Symbols5]=COFDM_Equal(Est,Block_Num,H0,Symbols4,P,F,F_inv)
Symbols5=zeros(F,1,Block_Num);
S=eye(F);
T=[S(2*F-P+1:F,:);S]; 
R=[zeros(F,P-F),eye(F)];
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
    G_MMSE=Var_s^2*D'/(Var_n^2*eye(P)+Var_s^2*(D*D'));
    for a=1:Block_Num
        Symbols5(:,:,a)=G_MMSE*Symbols4(:,:,a);
    end
end
end