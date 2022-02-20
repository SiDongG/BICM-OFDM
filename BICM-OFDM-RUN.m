N=4;             %Block Size
Rate=1/2;        %Code Rate
Block_Num=500;   %Block Number
M=4;             %M-QAM Modulation
Est=1;           %Estimator Type
L=2;             %Channel Order
State=4;         %Trellis State
C_r=10;          %Channel Realization
Error_Num=zeros(1,6);
Error_rate=zeros(1,6);
for SNRdb=0:2:10
    disp(SNRdb)
    for loop=1:C_r
        Error=BICM_OFDM(N,Block_Num,M,Rate,L,Est,State,SNR,P);
        Error_Num(SNRdb/2+1)=Error_Num(SNRdb/2+1)+Error;
    end
    Error_rate(SNRdb/2+1)=Error_Num(SNRdb/2+1)/(C_r*N*Block_Num);
end
