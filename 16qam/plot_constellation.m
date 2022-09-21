clear all
close all

M = 16;                         % Modulation order
x = (0:15);                    % Integer input
y1 = qammod(x,16,'bin');        % 16-QAM output
scatterplot(y1)
text(real(y1)+0.1, imag(y1), dec2bin(x))
title('16-QAM, Binary Symbol Mapping')
axis([-4 4 -4 4])
y2 = qammod(x,16,'gray');        % 16-QAM output
scatterplot(y2)
text(real(y2)+0.1, imag(y2), dec2bin(x))
title('16-QAM, Gray-coded Symbol Mapping')
axis([-4 4 -4 4])