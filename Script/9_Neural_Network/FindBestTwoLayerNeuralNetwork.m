dataset = STG;
functionActName = 'tanh';
maxRMSE = 100;

[model, rmse, predictions, bestFirstLayer,bestSecondLayer,lambda] = ...
    findBestNeuralNetworkConfig(dataset,functionActName,maxRMSE);
fprintf(strcat("\n Best_FL: ",string(bestFirstLayer)," Best_SL: ", string(bestSecondLayer),...
    " Best_RMSE: ", string(rmse),"\n"));
Two_Layer_50_tanh_STG = struct('model',model,'rmse',rmse,'predictions',predictions,'bestFirstLayer',...
    bestFirstLayer,'bestSecondLayer',bestSecondLayer,'lambda',lambda);

function [minModel, minRmse, minPredictions,bestFirstLayer,bestSecondLayer,bestLambda] = ...
        findBestNeuralNetworkConfig (dataset, activationFunctionName, startedRMSE)
    minRmse = startedRMSE;
    minModel = 0;
    minPredictions = 0;
    bestFirstLayer = 0;
    bestSecondLayer = 0;
   	bestLambda = 0;

    h = animatedline('Marker','o');
    lambda = linspace(0,3,100);
    
    firstLayersSize = 50;
    secondLayersSize = 50;
    
    for k = 1:width(lambda)
        
        [trainedModel, validationRMSE,validationPredictions] = ...
            TwoLayerNeuralNetwork(dataset,firstLayersSize,secondLayersSize,...
            activationFunctionName,lambda(k));
        
        if validationRMSE < minRmse
            minRmse = validationRMSE;
            minModel = trainedModel;
            minPredictions = validationPredictions;
            bestFirstLayer = firstLayersSize;
            bestSecondLayer = secondLayersSize;
            bestLambda = lambda(k);
        end
        
        fprintf(strcat("FL: ",string(firstLayersSize)," SL: ", ...
            string(secondLayersSize)," RMSE: ", string(validationRMSE),"\n"));
        
        addpoints(h,lambda(k),validationRMSE);
        xlabel('lambda');
        ylabel('RMSE');
        drawnow limitrate;
        
    end
    drawnow;
end

