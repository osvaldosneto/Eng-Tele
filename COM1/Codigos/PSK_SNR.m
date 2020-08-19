clear allclose allclcM = 4;SNR = 0;info = randint(1,1000000,M);info_mod = pskmod(info, M);for SNR = 0:10  info_rec = awgn(info_mod, SNR);  info_det = pskdemod(info_rec, M);  [num_err(SNR +1), SER(SNR +1)] = symerr(info, info_det);endsemilogy([0:10], SER)xlabel('SNR')ylabel('Taxa de erro de simbolo - SER')title('Desempenho de erro de símbolo para o MPSK')