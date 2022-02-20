N=4;             %Block Size
Rate=1/2;        %Code Rate
Block_Num=500;   %Block Number
M=4;             %M-QAM Modulation
L=2;             %Channel Order
State=4;         %Trellis State
C_r=100;          %Channel Realization
Error_Num=zeros(1,6);
Error_rate=zeros(1,6);
Error_Num_2=zeros(1,6);
Error_rate_2=zeros(1,6);
for SNRdb=0:2:10
    disp(SNRdb)
    SNR=10^(SNRdb/10);
    for loop=1:C_r
        Error=BICM_OFDM(N,Block_Num,M,Rate,L,1,State,SNR,P);
        Error2=BICM_OFDM(N,Block_Num,M,Rate,L,2,State,SNR,P);
        Error_Num(SNRdb/2+1)=Error_Num(SNRdb/2+1)+Error;
        Error_Num_2(SNRdb/2+1)=Error_Num_2(SNRdb/2+1)+Error2;
    end
    Error_rate(SNRdb/2+1)=Error_Num(SNRdb/2+1)/(C_r*N*Block_Num);
    Error_rate_2(SNRdb/2+1)=Error_Num_2(SNRdb/2+1)/(C_r*N*Block_Num);
end
figure()
semilogy(0:2:10,Error_rate);
hold on
semilogy(0:2:10,Error_rate_2);
xlabel('SNR(dB)');
ylabel('Ber');

legend('COFDM-ZF','COFDM-MMSE')