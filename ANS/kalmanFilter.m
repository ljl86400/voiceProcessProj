function [inputAudioData,kalmanParam] = kalmanFilter(inputAudioData,frameLen,kalmanParam)

%% kalman filter
if kalmanParam.curTrunkIndex == 1
    [kalmanParam.lpcCofficient, kalmanParam.stateNoiseCov] = ...
        lpc(inputAudioData,kalmanParam.ARModelOrder);
else
    [kalmanParam.lpcCofficient,kalmanParam.stateNoiseCov] = ...
        lpc( kalmanParam.preAudioBuffer,kalmanParam.ARModelOrder);
end

if kalmanParam.stateNoiseCov - kalmanParam.stateNoiseCovInit > 0
    kalmanParam.stateNoiseCov = kalmanParam.stateNoiseCov - ...
        kalmanParam.stateNoiseCovInit;
else
    kalmanParam.stateNoiseCov = 0.0001;
end

transferCofficient(kalmanParam.ARModelOrder,:) =...
    -1*kalmanParam.lpcCofficient(kalmanParam.ARModelOrder+1:-1:2);

for iloop2 = 1:frameLen
    kalmanParam.statePredict = kalmanParam.transferCofficient * ...
        kalmanParam.statePredict;
    kalmanParam.preEvlCov = kalmanParam.transferCofficient * kalmanParam.postEvlCov*transferCofficient' + ...
        kalmanParam.mearsureCofficient'*kalmanParam.stateNoiseCov * kalmanParam.mearsureCofficient;

    % 计算卡曼增益
    kalmanParam.kalmanGain = ...
        kalmanParam.preEvlCov*kalmanParam.mearsureCofficient'*...
        (kalmanParam.stateNoiseCovInit + kalmanParam.mearsureCofficient*kalmanParam.preEvlCov*kalmanParam.mearsureCofficient').^(-1);     % 求逆需要大量的计算
    % 更新测量方程
    kalmanParam.postEvlCov = (eye(kalmanParam.ARModelOrder) - ...
        kalmanParam.kalmanGain*kalmanParam.mearsureCofficient)*kalmanParam.preEvlCov;
    % 更新状态方程
    kalmanParam.statePredict = kalmanParam.statePredict + kalmanParam.kalmanGain*(inputAudioData(iloop2) - ...
    kalmanParam.mearsureCofficient*kalmanParam.statePredict);
    % 计算最优估计
    inputAudioData(iloop2) = kalmanParam.mearsureCofficient*kalmanParam.statePredict;
end

kalmanParam.preAudioBuffer = inputAudioData;
kalmanParam.curTrunkIndex = kalmanParam.curTrunkIndex + 1;
end