clc
clear all
close all

%% parameter setting
fs = 16000;
sampling = 16;
chennel = 1;
recorder = audiorecorder(fs,sampling,chennel);

recordblocking(recorder,5);

signal = getaudiodata(recorder);

denoiseSignal = WienerScalart96m(signal,fs);

figure
hold on
plot(signal)
plot(denoiseSignal)
hold off

%% write

audiowrite('signal20191031.wav',signal,fs);
audiowrite('denoiseSignal20191031.wav',denoiseSignal,fs);