clear all;
close all;
N=64;                       % 系统子载波数
cfo1 = 0.01;                 %归一化频偏
cfo2 = 0.05;                 %归一化频偏
cfo3 = 0.5;                 %归一化频偏
x=randi([0 15],N,3);        %2个符号周期的数据
x1=qammod(x,16);            %16-QAM调制
scatterplot(reshape(x1,[],1));
x2 = reshape(x1,[],1);
x3=ifft(x2,64);                % IFFT
%x4 = awgn(x3,60);
x4 =x3;
n = 0:length(x4) - 1;
n=n.';
y_cfo1 = x4.*exp(1j*2*pi*cfo1*n/N);
y_cfo2 = x4.*exp(1j*2*pi*cfo2*n/N);
y_cfo3 = x4.*exp(1j*2*pi*cfo3*n/N);
y1 = fft(y_cfo1,64);
y2 = fft(y_cfo2,64);
y3 = fft(y_cfo3,64);
scatterplot(y1);
title('解调星座图(ε = 0.01)')
scatterplot(y2);
title('解调星座图(ε = 0.05)')
scatterplot(y3);
title('解调星座图(ε = 0.5)')
