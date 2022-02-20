function [Bits_r]=COFDM_Demod(Block_Num,Symbols5,M,PSF,N)
Decoded_Symbol=qamdemod(Symbols5/sqrt(1/PSF),M);
Bits_r=zeros(1,Block_Num*N);
for i=1:Block_Num
   for b=1:length(Decoded_Symbol(:,:,i))
       Bits_r(=str2double(dec2bin(Decoded_Symbol(b,:,i),log2(M)));
   end
end

end