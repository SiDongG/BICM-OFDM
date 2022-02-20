function [Symbols4]=COFDM_FFTRE(Symbols3,NN,Block_Num,P,F_inv)
R=[zeros(NN,P-NN),eye(NN)]; 
Symbols4=zeros(NN,1,Block_Num);
for a=1:Block_Num
    Symbols4(:,:,a)=R*Symbols3(:,:,a);
end
NN=conj(F_inv);

for count=1:Block_Num
    Symbols4(:,:,count)=NN*Symbols4(:,:,count);
end
end