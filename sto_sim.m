clear all;
close all;
N=64;                     %系统子载波数
sto1 = 0;                 %归一化定时偏差
sto2 = -3;                 %归一化定时偏差
sto3 = -20;                 %归一化定时偏差
sto4 = 20;                 %归一化定时偏差
x=randi([0 15],N,10);      %10个符号周期的数据
x1=qammod(x,16);          %16-QAM调制
scatterplot(reshape(x1,[]16e,1));
x3=ifft(x1,64);                % IFFT
x3_add_cp = [x3(49:64,:);x3];
%x4 = awgn(x3,60);
x4 =reshape(x3_add_cp,[],1);
n = 0:length(x4) - 1;
if (sto1 >= 0 )
    y_sto1=[x4(sto1+1:end);zeros(1,sto1).'];
else
    y_sto1=[zeros(1,-sto1).';x4(1:end+sto1)];
end
if (sto2 >= 0 )
    y_sto2=[x4(sto2+1:end);zeros(1,sto2).'];
else
    y_sto2=[zeros(1,-sto2).';x4(1:end+sto2)];
end
if (sto3 >= 0 )
    y_sto3=[x4(sto3+1:end);zeros(1,sto3).'];
else
    y_sto3=[zeros(1,-sto3).';x4(1:end+sto3)];
end
if (sto4 >= 0 )
    y_sto4=[x4(sto4+1:end);zeros(1,sto4).'];
else
    y_sto4=[zeros(1,-sto4).';x4(1:end+sto4)];
end
for i = 1 : 10
    y1_remove_cp(1 + (i-1)*64 : 64*i) = y_sto1((17 + (i-1)*80 : 80*i),:);
end
y1_remove_cp = reshape(y1_remove_cp,64,10);
for i = 1 : 10
    y2_remove_cp(1 + (i-1)*64 : 64*i) = y_sto2((17 + (i-1)*80 : 80*i),:);
end
y2_remove_cp = reshape(y2_remove_cp,64,10);
for i = 1 : 10
    y3_remove_cp(1 + (i-1)*64 : 64*i) = y_sto3((17 + (i-1)*80 : 80*i),:);
end
y3_remove_cp = reshape(y3_remove_cp,64,10);
for i = 1 : 10
    y4_remove_cp(1 + (i-1)*64 : 64*i) = y_sto4((17 + (i-1)*80 : 80*i),:);
end
y4_remove_cp = reshape(y4_remove_cp,64,10);
y1 = fft(y1_remove_cp,64);
y2 = fft(y2_remove_cp,64);
y3 = fft(y3_remove_cp,64);
y4 = fft(y4_remove_cp,64);
scatterplot(reshape(y1,[],1));
title('解调星座图(δ = 0)')
scatterplot(reshape(y2,[],1));
title('解调星座图(δ = -3)')
scatterplot(reshape(y3,[],1));
title('解调星座图(δ = -11)')
scatterplot(reshape(y4,[],1));
title('解调星座图(δ = -20)')
