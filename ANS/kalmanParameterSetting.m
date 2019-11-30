function kalmanFilter = kalmanParameterSetting()

kalmanFilter.ARModelOrder = 16;
kalmanFilter.lpcCofficient = zeros(1,kalmanFilter.ARModelOrder);
kalmanFilter.transferCofficient = diag(ones(kalmanFilter.ARModelOrder-1,1),1);      % 状态转移矩阵
kalmanFilter.mearsureCofficient = [zeros(1,kalmanFilter.ARModelOrder-1),1];         % 测量系数
% statePredictInit = zeros(ARModelOrder,1);
kalmanFilter.statePredict = zeros(kalmanFilter.ARModelOrder,1);
kalmanFilter.postEvlCov = zeros(kalmanFilter.ARModelOrder);
kalmanFilter.stateNoiseCovInit = 0.0007; 
kalmanFilter.curTrunkIndex = 1;
kalmanFilter.preAudioBuffer = zeros(320,1);

end