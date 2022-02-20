function [Trellis,Coded_bits,Bits]=COFDM_Code(N,Rate,Block_Num,State)
Bits=randi(0:1,[1,N*Block_Num]);
if Rate==1/2
    Trellis=poly2trellis(3,[7,5]);
elseif Rate==2/3
    Trellis=poly2trellis([2,2],[2,1,2;1,3,3]);
else
    Coded_bits=Bits;
    return
end
Coded_bits=zeros(1,length(Bits)/Rate);
for a=1:State:length(Bits)
    Coded_bits((2*a-1):(2*a+State/Rate-2))=convenc(Bits(a:a+State-1),Trellis);
end
end