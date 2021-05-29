function [trainedClassifier, validationAccuracy,validationSensitivity,validationSpecificity,validationF_measure, confusion_matrix] = BaggedTree_TG(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% Returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: A table containing the same predictor and response
%       columns as those imported into the app.
%
%  Output:
%      trainedClassifier: A struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: A function to make predictions on new
%       data.
%
%      validationAccuracy: A double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 09-May-2021 12:03:10


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'n_individuals', 'lat', 'lon', 'temp_sup', 'temp_10m', 'temp_20m', 'temp_30m', 'temp_40m', 'temp_50m', 'temp_100m', 'temp_200m', 'temp_300m', 'temp_400m', 'temp_500m', 'temp_600m', 'temp_700m', 'temp_800m', 'temp_900m', 'temp_1000m', 'salinity_sup', 'salinity_10m', 'salinity_20m', 'salinity_30m', 'salinity_40m', 'salinity_50m', 'salinity100m', 'salinity_200m', 'salinity_300m', 'salinity_400m', 'salinity_500m', 'salinity_600m', 'salinity_700m', 'salinity_800m', 'salinity_900m', 'salinity_100m', 'density_sup', 'density_10m', 'density_20m', 'density_30m', 'density_40m', 'density_50m', 'density_100m', 'density_200m', 'density_300m', 'density_400m', 'density_500m', 'density_600m', 'density_700m', 'density_800m', 'density_900m', 'density_1000m', 'chl_a', 'prim_prod_sup', 'prim_prod_10m', 'prim_prod_20m', 'prim_prod_30m', 'prim_prod_40m', 'prim_prod_50m', 'prim_prod_100m', 'prim_prod_200m', 'prim_prod_300m', 'prim_prod_400m', 'prim_prod_500m', 'prim_prod_600m', 'prim_prod_700m', 'prim_prod_800m', 'prim_prod_900m', 'prim_prod_1000m', 'nitrate_sup', 'nitrate_10m', 'nitrate_20m', 'nitrate_30m', 'nitrate_40m', 'nitrate_50m', 'nitrate_100m', 'nitrate_200m', 'nitrate_300m', 'nitrate_400m', 'nitrate_500m', 'nitrate_600m', 'nitrate_700m', 'nitrate_800m', 'nitrate_900m', 'nitrate_1000m', 'phosphate_sup', 'phosphate_10m', 'phosphate_20m', 'phosphate_30m', 'phosphate_40m', 'phosphate_50m', 'phosphate_100m', 'phosphate_200m', 'phosphate_300m', 'phosphate_400m', 'phosphate_500m', 'phosphate_600m', 'phosphate_700m', 'phosphate_800m', 'phosphate_900m', 'phosphate_1000m'};
predictors = inputTable(:, predictorNames);
response = inputTable.species;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateTree(...
    'MaxNumSplits', 274);
classificationEnsemble = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'Bag', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'ClassNames', {'grampus griseus'; 'tursiops truncatus'});

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
trainedClassifier.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'chl_a', 'density_1000m', 'density_100m', 'density_10m', 'density_200m', 'density_20m', 'density_300m', 'density_30m', 'density_400m', 'density_40m', 'density_500m', 'density_50m', 'density_600m', 'density_700m', 'density_800m', 'density_900m', 'density_sup', 'lat', 'lon', 'n_individuals', 'nitrate_1000m', 'nitrate_100m', 'nitrate_10m', 'nitrate_200m', 'nitrate_20m', 'nitrate_300m', 'nitrate_30m', 'nitrate_400m', 'nitrate_40m', 'nitrate_500m', 'nitrate_50m', 'nitrate_600m', 'nitrate_700m', 'nitrate_800m', 'nitrate_900m', 'nitrate_sup', 'phosphate_1000m', 'phosphate_100m', 'phosphate_10m', 'phosphate_200m', 'phosphate_20m', 'phosphate_300m', 'phosphate_30m', 'phosphate_400m', 'phosphate_40m', 'phosphate_500m', 'phosphate_50m', 'phosphate_600m', 'phosphate_700m', 'phosphate_800m', 'phosphate_900m', 'phosphate_sup', 'prim_prod_1000m', 'prim_prod_100m', 'prim_prod_10m', 'prim_prod_200m', 'prim_prod_20m', 'prim_prod_300m', 'prim_prod_30m', 'prim_prod_400m', 'prim_prod_40m', 'prim_prod_500m', 'prim_prod_50m', 'prim_prod_600m', 'prim_prod_700m', 'prim_prod_800m', 'prim_prod_900m', 'prim_prod_sup', 'salinity100m', 'salinity_100m', 'salinity_10m', 'salinity_200m', 'salinity_20m', 'salinity_300m', 'salinity_30m', 'salinity_400m', 'salinity_40m', 'salinity_500m', 'salinity_50m', 'salinity_600m', 'salinity_700m', 'salinity_800m', 'salinity_900m', 'salinity_sup', 'temp_1000m', 'temp_100m', 'temp_10m', 'temp_200m', 'temp_20m', 'temp_300m', 'temp_30m', 'temp_400m', 'temp_40m', 'temp_500m', 'temp_50m', 'temp_600m', 'temp_700m', 'temp_800m', 'temp_900m', 'temp_sup'};
trainedClassifier.ClassificationEnsemble = classificationEnsemble;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2021a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'n_individuals', 'lat', 'lon', 'temp_sup', 'temp_10m', 'temp_20m', 'temp_30m', 'temp_40m', 'temp_50m', 'temp_100m', 'temp_200m', 'temp_300m', 'temp_400m', 'temp_500m', 'temp_600m', 'temp_700m', 'temp_800m', 'temp_900m', 'temp_1000m', 'salinity_sup', 'salinity_10m', 'salinity_20m', 'salinity_30m', 'salinity_40m', 'salinity_50m', 'salinity100m', 'salinity_200m', 'salinity_300m', 'salinity_400m', 'salinity_500m', 'salinity_600m', 'salinity_700m', 'salinity_800m', 'salinity_900m', 'salinity_100m', 'density_sup', 'density_10m', 'density_20m', 'density_30m', 'density_40m', 'density_50m', 'density_100m', 'density_200m', 'density_300m', 'density_400m', 'density_500m', 'density_600m', 'density_700m', 'density_800m', 'density_900m', 'density_1000m', 'chl_a', 'prim_prod_sup', 'prim_prod_10m', 'prim_prod_20m', 'prim_prod_30m', 'prim_prod_40m', 'prim_prod_50m', 'prim_prod_100m', 'prim_prod_200m', 'prim_prod_300m', 'prim_prod_400m', 'prim_prod_500m', 'prim_prod_600m', 'prim_prod_700m', 'prim_prod_800m', 'prim_prod_900m', 'prim_prod_1000m', 'nitrate_sup', 'nitrate_10m', 'nitrate_20m', 'nitrate_30m', 'nitrate_40m', 'nitrate_50m', 'nitrate_100m', 'nitrate_200m', 'nitrate_300m', 'nitrate_400m', 'nitrate_500m', 'nitrate_600m', 'nitrate_700m', 'nitrate_800m', 'nitrate_900m', 'nitrate_1000m', 'phosphate_sup', 'phosphate_10m', 'phosphate_20m', 'phosphate_30m', 'phosphate_40m', 'phosphate_50m', 'phosphate_100m', 'phosphate_200m', 'phosphate_300m', 'phosphate_400m', 'phosphate_500m', 'phosphate_600m', 'phosphate_700m', 'phosphate_800m', 'phosphate_900m', 'phosphate_1000m'};
predictors = inputTable(:, predictorNames);
response = inputTable.species;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationEnsemble, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

confusion_matrix = confusionmat(inputTable.species,validationPredictions);

true_positive = confusion_matrix(1,1);
false_positive = confusion_matrix(1,2);
true_negative = confusion_matrix(2,2);
false_negative = confusion_matrix(2,1);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
validationSensitivity = true_positive / (true_positive+false_negative);
validationSpecificity = true_negative / (false_positive+true_negative);
validationF_measure = (2*true_positive)/(2*true_positive + false_negative + false_positive); 
