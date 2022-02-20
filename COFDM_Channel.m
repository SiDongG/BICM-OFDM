function [Symbols3,H0]=COFDM_Channel(Symbols2,SNR,P,Block_Num,L)
L_C=L+1;
h=(1/sqrt(2*(L_C)))*(randn(1,L_C)+1i*randn(1,L_C));
H0=zeros(P); 
H1=zeros(P); 
a=1;
while a<P+1  
    b=1;
    while b<P+1
        if a-b<0 || a-b>L_C-1
            H0(a,b)=0;
        else
            H0(a,b)=h(a-b+1);
        end
        if P+a-b<0 || P+a-b>L_C-1
            H1(a,b)=0;
        else
            H1(a,b)=h(P+a-b+1);
        end
        b=b+1;
    end
    a=a+1;
end
nr=randn(P,1,Block_Num);
ni=randn(P,1,Block_Num);
Noise=(sqrt(2)/2)*(nr+1i*ni);
Symbols3=zeros(P,1,Block_Num);
for a=1:Block_Num
    if a==1
        Insertion2=zeros(P,1);
    else
        Insertion2=Symbols2(:,:,a-1);
    end
    Symbols3(:,:,a)=H0*Symbols2(:,:,a)+H1*Insertion2+(1/sqrt(SNR))*Noise(:,:,a);
end
end