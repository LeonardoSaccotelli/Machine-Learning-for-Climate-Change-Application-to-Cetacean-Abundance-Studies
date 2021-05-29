dataset = STG;
functionActName = 'tanh';
maxRMSE = 100;

fprintf("\n-------------------------------------------------------");
fprintf("\nRunning STG with sigmoid\n");
[model, rmse, predictions, bestFirstLayer,bestSecondLayer, bestThirdLayer,lambda] = ...
    findBestNeuralNetworkConfig(dataset,functionActName,maxRMSE);  
   
fprintf(strcat("\n Best_FL: ",string(bestFirstLayer)," Best_SL: ", string(bestSecondLayer),...
    " Best_TL: ", string(bestThirdLayer)," Best_RMSE: ", string(rmse),"\n"));
Three_Layer_100_sigmoid_STG = struct('model',model,'rmse',rmse,'predictions',predictions,'bestFirstLayer',...
    bestFirstLayer,'bestSecondLayer',bestSecondLayer,'bestThirdLayer',bestThirdLayer,'lambda',lambda);
save('TreLayer_G_Sigmoid','Three_Layer_100_sigmoid_STG');


function [minModel, minRmse, minPredictions,bestFirstLayer,bestSecondLayer,bestThirdLayer,bestLambda] = ...
        findBestNeuralNetworkConfig (dataset, activationFunctionName, startedRMSE)
    minRmse = startedRMSE;
    minModel = 0;
    minPredictions = 0;
    bestFirstLayer = 0;
    bestSecondLayer = 0;
    bestThirdLayer = 0;
    bestLambda = 0;
    
    firstLayersSize = 100;
    secondLayersSize = 100;
    thirdLayersSize= 100;
    
    h = animatedline('Marker','o');
    lambda = linspace(0,3,100);
    
    for i = 1:width(lambda)
        
        [trainedModel, validationRMSE,validationPredictions] = ...
            ThreeLayerNeuralNetwork(dataset,firstLayersSize,secondLayersSize,...
            thirdLayersSize,activationFunctionName,lambda(i));
        
        if validationRMSE < minRmse
            minRmse = validationRMSE;
            minModel = trainedModel;
            minPredictions = validationPredictions;
            bestFirstLayer = firstLayersSize;
            bestSecondLayer = secondLayersSize;
            bestThirdLayer = thirdLayersSize;
            bestLambda = lambda(i);
        end
        fprintf(strcat("FL: ",string(firstLayersSize)," SL: ", string(secondLayersSize),...
            " TL: ", string(thirdLayersSize)," RMSE: ", string(validationRMSE),"\n"));
        
        addpoints(h,lambda(i),validationRMSE);
        xlabel('lambda');
        ylabel('RMSE');
        drawnow limitrate;
    end
end
