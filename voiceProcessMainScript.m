clc
clear all
close all

%% parameters setting
soundCardBufferDataFramesLen = 480;

%% row audio data read
[rowData,fs] = audioread('rowRecorderData.wav');

% stereo to mono
if(size(rowData,2) >= 2)
    rowData = sum(rowData,2)/size(rowData,2);
end

% frame
soundCardBufferData = buffer(rowData,soundCardBufferDataFramesLen,0,'nodelay');
soundCardBufferDataFramesNum = size(soundCardBufferData,2);


rateOfProcess = 1;
rebufferData = zeros(320,1);
showWaitBar = waitbar(rateOfProcess,'rate of process');
while(rateOfProcess <= soundCardBufferDataFramesNum)
    
    %% preprocess
    % resample
    % D:\matlab2017a\work\Examples\forSomeTest
    if(16000 ~= fs)
        curTrunkResampleData = ...
            resample(soundCardBufferData(:,rateOfProcess),1,3);
    end
    % overlap reBuffer
    rebufferData(1:end/2) = rebufferData(end/2 + 1:end);
    rebufferData(end/2 + 1:end) = curTrunkResampleData;
    % De-direct current
    % filter
    
    
    
    %% process
    % noise cancellation
    % acoustic echo cancellation
    % agc
    
    waitbar(rateOfProcess/soundCardBufferDataFramesNum);
    rateOfProcess = rateOfProcess + 1;
end
close(showWaitBar);

%% output data post processing

