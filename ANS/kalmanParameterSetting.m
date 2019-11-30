function kalmanFilter = kalmanParameterSetting()

kalmanFilter.ARModelOrder = 16;
kalmanFilter.lpcCofficient = zeros(1,kalmanFilter.ARModelOrder);
kalmanFilter.transferCofficient = diag(ones(kalmanFilter.ARModelOrder-1,1),1);      % ״̬ת�ƾ���
kalmanFilter.mearsureCofficient = [zeros(1,kalmanFilter.ARModelOrder-1),1];         % ����ϵ��
% statePredictInit = zeros(ARModelOrder,1);
kalmanFilter.statePredict = zeros(kalmanFilter.ARModelOrder,1);
kalmanFilter.postEvlCov = zeros(kalmanFilter.ARModelOrder);
kalmanFilter.stateNoiseCovInit = 0.0007; 
kalmanFilter.curTrunkIndex = 1;
kalmanFilter.preAudioBuffer = zeros(320,1);

end