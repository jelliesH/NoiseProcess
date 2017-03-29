% === 对幅度谱进行三角滤波过程

function tbfCoef = triBandFilter(fs,fftMag, P,n)

maxMelFreq = frq2mel(fs/2); %将线性频率转化为mel频率，得到最大的Mel频率

sideWidth=maxMelFreq/(P+1);%求频带宽带，即Mel滤波器宽度

index=0:P-1;%滤波器的中心

filterBankParam=floor(mel2frq([index;index+1;index+2]*sideWidth)/fs*n)+1;

filterBankParam(end, end)= n/2;
fstart=filterBankParam(1,:);                %fftMag一帧数据的幅度谱

fcenter=filterBankParam(2,:);%滤波器的中心点，每列代表一个滤波器的中心频率

fstop=filterBankParam(3,:);

% Triangular bandpass filter.

for i=1:P %滤波器个数

   for j = fstart(i):fcenter(i), %第i个滤波器起始频谱点和中心频谱点的输出

      filtmag(j) = (j-fstart(i))/(fcenter(i)-fstart(i));

   end

   for j = fcenter(i)+1:fstop(i),

      filtmag(j) = 1-(j-fcenter(i))/(fstop(i)-fcenter(i));

   end

   tbfCoef(i) = sum(fftMag(fstart(i):fstop(i)).*filtmag(fstart(i):fstop(i))'); %第i个滤波器的输出

end

tbfCoef=log(eps+tbfCoef.^2); %求得每个滤波器的对数输出，有多少个滤波器就有多少个输出，对应为每一帧

 