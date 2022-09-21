%%% frenqucy_drift
% date :2022.8.29
% decription : sim msk modulation fren_drift 
% code by zhangxu
%40hz/us,20khz/50eus
%%%
clear all
close all
fs = 4e6 ;
fc = 0 ;
flag = 0;
step_size = 100 ; %Ƶ�ʱ仯�Ĳ�����
source = randi([0,1],255,1);
msk_sig  = mskmod(source,16,'diff',-pi/2);
for i = 0 : length(msk_sig) -1
    if ( fc > 15e3) %��������
        fc = fc - step_size ;
        flag = 1;
    elseif (fc < -15e3)%��������
          fc = fc + step_size ;
           flag = 0;
    elseif (flag == 1)
        fc = fc - step_size ;
    elseif (flag == 0)
        fc = fc + step_size ;
    end
    temp(i+1) = fc;
    sig_off(i+1) = exp(1j*2*pi*fc*i/fs);
end
%plot(angle(chan_freq_out))
figure
plot(temp)
title('Ƶ��')
figure
phs = cumsum(pi*2*temp/fs);
plot(phs)
title('��λ')




