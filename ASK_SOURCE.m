%%%%%%%%%%%              2ASK仿真数据源                    %%%%%%%%%%%
%%%%%%%%                 File: ASK_SOURCE.m                      %%%%%%%
%%%%%%           date: 2021-1-1          author: zhangxu            %%%%%

%%                         程序说明
% 产生五个码元周期的2ask信号，并写入txt文件和coe文件


%% 系统参数设定 %%
clear all;
close all;
bit_rate = 1.25e6 ;
symbol_rate = 1.25e6;
fs = 250e6  ;
per_symbol_number = 200 ;
fc = 10e6 ;

%% 信号源生成 %%
msg_source = [1,0,1,0,1];
%对信号源进行采样
sample_msg_source = rectpulse(msg_source,per_symbol_number);
%采样点数
n = 0:length(sample_msg_source) - 1;
%载波产生
carrier = sin(2*pi*fc.*n/fs);
figure(1)
plot(carrier)
title('载波信号')
%ASK信号产生
ask = sample_msg_source.*carrier ;
figure(2)
plot(ask)
title('ask信号')

figure(3)
plot(abs(fft(ask,4096)))
title('ask的频谱')

%% ask信号写入txt文件 %%
q = quantizer('fixed','round','saturate',[16,15]);
fix16_15 = num2bin(q,ask);
fid1 = fopen('D:\MATLAB\test_txt\ask.txt','wt');
for i = 1:1000
    fwrite(fid1,fix16_15(i,:));
    fprintf(fid1,'\n');
end

fclose(fid1);

%% ask信号写入coe文件 %%
fid = fopen('D:\MATLAB\test_txt\ask.coe','w');%文件存放路径
fprintf(fid,'MEMORY_INITIALIZATION_RADIX=%d; \n',2);
fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=  \n');
for i = 1:1000 - 1  
    fwrite(fid,fix16_15(i,:));
    fprintf(fid,',');
    fprintf(fid,'\n'); 
end
fwrite(fid,fix16_15(1000,:));
fprintf(fid,';'); 
fclose(fid);









