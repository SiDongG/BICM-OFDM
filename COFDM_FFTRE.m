function [Symbols4]=COFDM_FFTRE(Symbols3,F,Block_Num,P,F_inv)
R=[zeros(F,P-F),eye(F)]; 
Symbols4=zeros(F,1,Block_Num);
for a=1:Block_Num
    Symbols4(:,:,a)=R*Symbols3(:,:,a);
end
F=conj(F_inv);

for count=1:Block_Num
    Symbols4(:,:,count)=F*Symbols4(:,:,count);
end
end