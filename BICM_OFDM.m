function Error=BICM_OFDM(N,Block_Num,M,Rate,L,Est,State,SNR,P)
[Trellis,Coded_bits,Bits]=COFDM_Code(N,Rate,Block_Num,State);
[Symbols,NN,PSF]=COFDM_Mod(N,Block_Num,M,Coded_bits,Rate);
[Symbols2,F_inv]=COFDM_IFFTCP(NN,L,Symbols,Block_Num);
[Symbols3,H0]=COFDM_Channel(Symbols2,SNR,NN,Block_Num,L);
[Symbols4]=COFDM_FFTRE(Symbols3,NN,Block_Num,P,F_inv);
[Symbols5]=COFDM_Equal(Est,Block_Num,H0,Symbols4,P,NN,F_inv,SNR);
[Bits_decoded]=COFDM_Demod(Block_Num,Symbols5,M,PSF,N,Trellis,Rate);
Error=sum(sum(Bits_decoded~=Bits));
end