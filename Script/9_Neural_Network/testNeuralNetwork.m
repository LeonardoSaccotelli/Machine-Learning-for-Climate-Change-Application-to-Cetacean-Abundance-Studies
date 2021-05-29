lambda = 1.8485;
bestFirstLayer = 100;
bestSecondLayer = 100;
bestThirdLayer = 100;
actF = 'sigmoid';

[trainedModelS, validationRMSES,validationPredictionsS] = ...
    ThreeLayerNeuralNetwork(S,bestFirstLayer,bestSecondLayer,bestThirdLayer, actF,lambda);
Three_Layer_100_sigmoid_S = struct('model',trainedModelS,'rmse',validationRMSES,...
    'predictions',validationPredictionsS,...
    'bestFirstLayer',bestFirstLayer,'bestSecondLayer',bestSecondLayer,'bestThirdLayer',bestThirdLayer,'lambda',lambda);

[trainedModelT, validationRMSET,validationPredictionsT] = ...
    ThreeLayerNeuralNetwork(T,bestFirstLayer,bestSecondLayer,bestThirdLayer,actF,lambda);
Three_Layer_100_sigmoid_T = struct('model',trainedModelT,'rmse',validationRMSET,...
    'predictions',validationPredictionsT,...
    'bestFirstLayer',bestFirstLayer,'bestSecondLayer',bestSecondLayer,'bestThirdLayer',bestThirdLayer,'lambda',lambda);

[trainedModelG, validationRMSEG,validationPredictionsG] = ...
    ThreeLayerNeuralNetwork(G,bestFirstLayer,bestSecondLayer,bestThirdLayer,actF,lambda);
Three_Layer_100_sigmoid_G = struct('model',trainedModelG,'rmse',validationRMSEG,...
    'predictions',validationPredictionsG,...
    'bestFirstLayer',bestFirstLayer,'bestSecondLayer',bestSecondLayer,'bestThirdLayer',bestThirdLayer,'lambda',lambda);

[trainedModelSTG, validationRMSESTG,validationPredictionsSTG] = ...
    ThreeLayerNeuralNetwork(STG,bestFirstLayer,bestSecondLayer,bestThirdLayer,actF,lambda);
Three_Layer_50_sigmoid_STG = struct('model',trainedModelSTG,'rmse',validationRMSESTG,...
    'predictions',validationPredictionsSTG,...
    'bestFirstLayer',bestFirstLayer,'bestSecondLayer',bestSecondLayer,'bestThirdLayer',bestThirdLayer,'lambda',lambda);