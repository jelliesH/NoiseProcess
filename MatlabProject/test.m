clc;clear;
[filename,pathname,filterindex]= uigetfile({'*.wav';'*.mp3'},'Pick a file','File Select');
[data,fs] = audioread([pathname,'/',filename]);
sample = data(:,1);
N = length(sample);
total_time = N/fs;
time = linspace(0,total_time,N);
subplot(311);
plot(time,sample);
xlabel('时间 s');
ylabel('信号 sig');

nfft = 2^nextpow2(N);
Pxx_1 = abs(fft(sample,nfft))*2/nfft;
t = 0:round(nfft/2-1);
f = t*fs/nfft;
P_1=10*log10(Pxx_1(t+1));
P_1_1 = 10*log10(Pxx_1(t+1));
subplot(312);
plot(f,Pxx_1(t+1));
xlabel('频率');
ylabel('幅值pa');
subplot(313);
plot(f,P_1(t+1));
xlabel('频率');
ylabel('幅值db');



