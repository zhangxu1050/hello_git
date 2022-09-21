%%%%%%%%%%%              2ASK��������Դ                    %%%%%%%%%%%
%%%%%%%%                 File: ASK_SOURCE.m                      %%%%%%%
%%%%%%           date: 2021-1-1          author: zhangxu            %%%%%

%%                         ����˵��
% ���������Ԫ���ڵ�2ask�źţ���д��txt�ļ���coe�ļ�


%% ϵͳ�����趨 %%
clear all;
close all;
bit_rate = 1.25e6 ;
symbol_rate = 1.25e6;
fs = 250e6  ;
per_symbol_number = 200 ;
fc = 10e6 ;

%% �ź�Դ���� %%
msg_source = [1,0,1,0,1];
%���ź�Դ���в���
sample_msg_source = rectpulse(msg_source,per_symbol_number);
%��������
n = 0:length(sample_msg_source) - 1;
%�ز�����
carrier = sin(2*pi*fc.*n/fs);
figure(1)
plot(carrier)
title('�ز��ź�')
%ASK�źŲ���
ask = sample_msg_source.*carrier ;
figure(2)
plot(ask)
title('ask�ź�')

figure(3)
plot(abs(fft(ask,4096)))
title('ask��Ƶ��')

%% ask�ź�д��txt�ļ� %%
q = quantizer('fixed','round','saturate',[16,15]);
fix16_15 = num2bin(q,ask);
fid1 = fopen('D:\MATLAB\test_txt\ask.txt','wt');
for i = 1:1000
    fwrite(fid1,fix16_15(i,:));
    fprintf(fid1,'\n');
end

fclose(fid1);

%% ask�ź�д��coe�ļ� %%
fid = fopen('D:\MATLAB\test_txt\ask.coe','w');%�ļ����·��
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









