dataset = STG;
functionActName = 'tanh';
maxRMSE = 100;

% Addestro STG con sigmoid
fprintf("\n-------------------------------------------------------");
fprintf("\nRunning STG with sigmoid\n");
[model, rmse, predictions, bestFirstLayer,lambda] = ...
    findBestNeuralNetworkConfig(dataset,functionActName,maxRMSE);
fprintf(strcat("\n Best_FL: ",string(bestFirstLayer)," Best_RMSE: ", string(rmse),"\n"));
One_Layer_150_tanh_STG = struct('model',model,'rmse',rmse,'predictions',predictions,'bestFirstLayer',...
    bestFirstLayer,'lambda',lambda);
	
function [minModel, minRmse, minPredictions,bestFirstLayer, bestLambda] = ...
        findBestNeuralNetworkConfig (dataset, activationFunctionName, startedRMSE)
    minRmse = startedRMSE;
    minModel = 0;
    minPredictions = 0;
    bestFirstLayer = 0;
	bestLambda = 0;
    
    h = animatedline('Marker','o');
    lambda = linspace(0,3,100);
    layersSize = 150;
    
    for k = 1:width(lambda)
		[trainedModel, validationRMSE,validationPredictions] = ...
			OneLayerNeuralNetwork(dataset,layersSize,activationFunctionName,lambda(k));
			
        if validationRMSE < minRmse
            minRmse = validationRMSE;
            minModel = trainedModel;
            minPredictions = validationPredictions;
            bestFirstLayer = layersSize;
            bestLambda = lambda(k);
        end
        
		fprintf(strcat("FL: ",string(layersSize)," RMSE: ", string(validationRMSE),"\n")); 
        
        addpoints(h,lambda(k),validationRMSE);
        xlabel('lambda');
        ylabel('RMSE');
        drawnow limitrate;  
    end
    drawnow;
end