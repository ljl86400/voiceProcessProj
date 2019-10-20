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
soundCardBufferData = buffer(rowData,soundCardBufferDataFramesLen,0);
soundCardBufferDataFramesNum = size(soundCardBufferData,2);

rateOfProcess = 0;
showWaitBar = waitbar(rateOfProcess,'rate of process');
while(rateOfProcess <= soundCardBufferDataFramesNum)
%% preprocess
% De-direct current
% filter
% resample


%% process
% noise cancellation
% acoustic echo cancellation
% agc

waitbar(rateOfProcess/soundCardBufferDataFramesNum);
rateOfProcess = rateOfProcess + 1;
end
close(showWaitBar);

%% output data post processing

