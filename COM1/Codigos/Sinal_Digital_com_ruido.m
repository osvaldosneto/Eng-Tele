clear all
close all
clc
M = 2; %número de níveis de transmissão
N = 40;
A = 5; % Amplitude do sinal
limiar = A/2;
Rb = 1e3;
Fs = N*Rb;
Tb = 1/Rb;
BW = Rb;
t_final = 1;
passo_t = 1/(Rb*N);
t = [0:passo_t:t_final-passo_t];
passo_f = 1/t_final;
f = [-Fs/2:passo_f:Fs/2-passo_f];
var_ruido = 1;
filtro_NRZ = ones(1,N);
ordem_filtro = 20; % Neste programa, não colocar a ordem maior do que N! 
f_cut = 3*Rb;
filtro_Rx = fir1(ordem_filtro, (2*f_cut)/Fs); % filtro que formator do sinal
info = randint(1,Rb*t_final,M); %gerando a informação
info_up = upsample(info,N); %super-amostragem
sinal_tx_aux = conv(info_up,filtro_NRZ)*A; % processo de filtragem para formatar o sinal
sinal_tx = sinal_tx_aux(1:end-(N-1)); % truncando o sinal devido ao processo de convolução
ruido = sqrt(var_ruido)*randn(1,length(sinal_tx)); %vari?vel gaussiana
sinal_rx = sinal_tx + ruido; %Received waveform
sinal_rx_filter = filter(filtro_Rx, 1, sinal_rx); %receiving filter
sinal_det = sinal_rx_filter(ordem_filtro:N:end); %chave capturando amostras
info_rec = sinal_det > limiar; %informa??o recebida pega a amplitude e analisa qual categoria se encaixa
n_erro = sum(xor(info, info_rec)) %numero de erros
taxa_erro = n_erro/(Rb*t_final)
figure(1)
plot(t,sinal_tx)
xlim([0 10*Tb])
hold on
plot(t,sinal_rx)
xlim([0 10*Tb])
hold on
plot(t(1:end-(ordem_filtro/2)+1),sinal_rx_filter(ordem_filtro/2:end))