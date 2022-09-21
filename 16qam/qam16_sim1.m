%%%16qam sim
% date :2022.8.30
% decription : study communication toolbox sim 16QAM
% code by zhangxu
%%%
clear all
close all
M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
numBits = 3e5;              % Number of bits to process
numSamplesPerSymbol = 16;    % Oversampling factor
span = 10;        % Filter span in symbols
rolloff = 0.2;   % Roloff factor of filter
rrcFilter = rcosdesign(rolloff, span, numSamplesPerSymbol);
fvtool(rrcFilter,'Analysis','Impulse')
rng default                         % Use default random number generator
dataIn = randi([0 1], numBits, 1);  % Generate vector of binary data
dataInMatrix = reshape(dataIn, length(dataIn)/k, k); % Reshape data into binary 4-tuples
dataSymbolsIn = bi2de(dataInMatrix); 
dataMod = qammod(dataSymbolsIn, M);
txSignal = upfirdn(dataMod, rrcFilter, numSamplesPerSymbol, 1); %upsample and filter
subplot(2,1,1)
plot(real(txSignal))
subplot(2,1,2)
plot(imag(txSignal))
EbNo = 10;
snr = EbNo + 10*log10(k)-10*log10(numSamplesPerSymbol);
rxSignal = awgn(txSignal, snr, 'measured');
rxFiltSignal = upfirdn(rxSignal,rrcFilter,1,numSamplesPerSymbol);   % Downsample and filter
rxFiltSignal = rxFiltSignal(span+1:end-span);                       % Account for delay
%rxFiltSignal = rxFiltSignal(1:end-2*span);
dataSymbolsOut = qamdemod(rxFiltSignal, M);
dataOutMatrix = de2bi(dataSymbolsOut,k);
dataOut = dataOutMatrix(:);                 % Return data in column vector
[numErrors, ber] = biterr(dataIn, dataOut);
fprintf('\nThe bit error rate = %5.2e, based on %d errors\n', ...
    ber, numErrors)
eyediagram(txSignal(1:2000),numSamplesPerSymbol*2);
h = scatterplot(sqrt(numSamplesPerSymbol)*...
    rxSignal(1:numSamplesPerSymbol*5e3),...
    numSamplesPerSymbol,0,'g.');
hold on;
scatterplot(rxFiltSignal(1:5e3),1,0,'kx',h);
title('Received Signal, Before and After Filtering');
legend('Before Filtering','After Filtering');
axis([-5 5 -5 5]); % Set axis ranges
hold off;





