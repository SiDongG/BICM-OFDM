function [Bits_decoded]=COFDM_Demod(Block_Num,Symbols5,M,PSF,N,Trellis,Rate)
tb=2;
Decoded_Symbol=qamdemod(Symbols5/sqrt(1/PSF),M);
Bits_r=zeros(1,(Block_Num*N)/Rate);
start=1;
for i=1:Block_Num
   for b=1:length(Decoded_Symbol(:,:,i))
       str=dec2bin(Decoded_Symbol(b,:,i),log2(M));
       for j=1:log2(M)
           Bits_r(start)=str2double(str(j));
           start=start+1;
       end
   end
end
Bits_decoded=zeros(1,Block_Num*N);
for a=1:Block_Num
    Bits_decoded((1+(a-1)*N):a*N)=vitdec(Bits_r(1+(a-1)*N/Rate:a*N/Rate),Trellis,tb,'trunc','hard');
end
end
