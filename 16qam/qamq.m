%%%16qam sim
% date :2022.8.26
% decription : study communication toolbox sim 16QAM
% code by zhangxu
%%%

%% Define parameters.
M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
n = 30000;                  % Number of bits to process
numSamplesPerSymbol = 1;    % Oversampling factor
%% Create a binary data stream as a column vector.
rng default                 % Use default random number generator
dataIn = randi([0 1],n,1);  % Generate vector of binary data
%% Plot the first 40 bits in a stem plot.
stem(dataIn(1:40),'filled');
title('Random Bits');
xlabel('Bit Index');
ylabel('Binary Value');
%% Perform a bit-to-symbol mapping.
dataInMatrix = reshape(dataIn,length(dataIn)/k,k);   % Reshape data into binary k-tuples, k = log2(M)
dataSymbolsIn = bi2de(dataInMatrix);                 % Convert to integers
%% Plot the first 10 symbols in a stem plot.
figure; % Create new figure window.
stem(dataSymbolsIn(1:10));
title('Random Symbols');
xlabel('Symbol Index');
ylabel('Integer Value');
%% Apply modulation.
dataMod = qammod(dataSymbolsIn,M,'bin');         % Binary coding, phase offset = 0
dataModG = qammod(dataSymbolsIn,M); % Gray coding, phase offset = 0
%% Calculate the SNR when the channel has an Eb/N0 = 10 dB.
EbNo = 10;
snr = EbNo + 10*log10(k) - 10*log10(numSamplesPerSymbol);
%% Pass the signal through the AWGN channel for both the binary and Gray coded symbol mappings.
receivedSignal = awgn(dataMod,snr,'measured');
receivedSignalG = awgn(dataModG,snr,'measured');
%% Use the scatterplot function to show the constellation diagram.
sPlotFig = scatterplot(receivedSignal,1,0,'g.'); %plot every point
hold on
scatterplot(dataMod,1,0,'k*',sPlotFig)
%% Demodulate the received signals using the qamdemod function.
dataSymbolsOut = qamdemod(receivedSignal,M,'bin');
dataSymbolsOutG = qamdemod(receivedSignalG,M);
%% Reverse the bit-to-symbol mapping performed earlier.
dataOutMatrix = de2bi(dataSymbolsOut,k);
dataOut = dataOutMatrix(:);                   % Return data in column vector
dataOutMatrixG = de2bi(dataSymbolsOutG,k);
dataOutG = dataOutMatrixG(:);                 % Return data in column vector
%% Compute the System BER
[numErrors,ber] = biterr(dataIn,dataOut);
fprintf('\nThe binary coding bit error rate = %5.2e, based on %d errors\n', ...
    ber,numErrors)
[numErrorsG,berG] = biterr(dataIn,dataOutG);
fprintf('\nThe Gray coding bit error rate = %5.2e, based on %d errors\n', ...
    berG,numErrorsG)
