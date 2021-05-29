% Restituisce un modello di regressione addestrato e il relativo RMSE. 
% Questo codice ricrea il modello addestrato. 
% Usa il codice generato per automatizzare l'addestramento dello stesso modello 
% con nuovi dati.
% Input:
% trainingData: una tabella contenente le stesse colonne di predittore e risposta di quelle
% 				usate per addestrare il modello.
%
% Output:
% - LSBoostRegressionModel: una struttura contenente il modello di regressione addestrato. 
% 	La struttura contiene vari campi con informazioni sul modello.
%	LSBoostRegressionModel.predictFcn: una funzione per fare previsioni su nuovi dati.
%
% - validationRMSE: un double contenente l'RMSE.
%
% - validationPredictions: un array contenente le previsioni eseguite.
% - featureImportanceTable: una tabella che indica l'importanza data dal modello ad ogni feature
% Utilizzare il codice per addestrare il modello con nuovi dati. Per riaddestrare il tuo modello,
% chiama la funzione dalla riga di comando con i tuoi dati originali o nuovi
% di dati come argomento di input della funzione trainingData.
%
% Ad esempio, per riaddestrare un modello di regressione addestrato con i dati originali
% sia T il dataset da utilizzare, inserisci:
% [LSBoostRegressionModel, validationRMSE,validationPredictions, featureImportanceTable] = LSBoostRegressionModel(T)] = LSBoostRegressionModel (T) 
%
% Per fare previsioni con il "modello addestrato" restituito su nuovi dati T2, utilizzare
% yfit = LSBoostRegressionModel.predictFcn (T2)
%
% T2 deve essere una tabella contenente almeno le stesse colonne predittive utilizzate
% durante l'addestramento. Per i dettagli, inserisci:
% LSBoostRegressionModel.HowToPredict

function [trainedModel, validationRMSE, validationPredictions, featureImportanceTable] = LSBoostRegressionModel(trainingData)

% Estrai predittori e feature da stimare
% Questo codice elabora i dati nella forma corretta per l'addestramento del
% modello.
inputDataset = trainingData;

% Selezione le feature da usare per l'addestramento
predictorNames = trainingData.Properties.VariableNames;
predictorNames(:,(strncmp(predictorNames, "n_individuals",...
        strlength("n_individuals")))) = [];
		
featureForTraining = inputDataset(:, predictorNames);
targetFeature = inputDataset.n_individuals;

% Addestra il modello di regressione
% Specifichiamo i parametri e addestriamo il modello.
template = templateTree(...
    'MinLeafSize', 19);
regressionEnsemble = fitrensemble(...
    featureForTraining, ...
    targetFeature, ...
    'Method', 'LSBoost', ...
    'NumLearningCycles', 11, ...
    'Learners', template, ...
    'LearnRate', 0.24493);

% Salviamo i risultati in una struttura con la funzione per effettuare una previsione
predictorExtractionFcn = @(t) t(:, predictorNames);
ensemblePredictFcn = @(x) predict(regressionEnsemble, x);
trainedModel.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

% Aggiungiamo campi informativi alla nostra struttura
trainedModel.RequiredVariables = trainingData.Properties.VariableNames;
trainedModel.RegressionEnsemble = regressionEnsemble;
trainedModel.About = 'This struct is a trained model exported from Regression Learner R2021a.';
trainedModel.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Estrai predittori e feature da stimare
% Questo codice elabora i dati nella forma corretta per l'addestramento del
% modello.
inputDataset = trainingData;

% Selezione le feature da usare per l'addestramento
predictorNames = trainingData.Properties.VariableNames;
predictorNames(:,(strncmp(predictorNames, "n_individuals",...
        strlength("n_individuals")))) = [];

% Estrapolo la tabella con le feature da usare per l'addestramento
featureForTraining = inputDataset(:, predictorNames);

% Estrapolo la feature da stimare, la variabile target
targetFeature = inputDataset.n_individuals;

% Eseguiamo la cross-validation con k = 5
partitionedModel = crossval(trainedModel.RegressionEnsemble, 'KFold', 5);

% Computiamo le predizioni effettuate
validationPredictions = kfoldPredict(partitionedModel);

% Computiamo l'RMSE
validationRMSE = sqrt(kfoldLoss(partitionedModel, 'LossFun', 'mse'));

% Calcolo la rilevanza di ogni feature
featureImportance = predictorImportance(regressionEnsemble);
featureImportanceTable = table('Size', [width(predictorNames) 1], 'VariableTypes',...
    {'double'}, 'VariableNames', {'score'},'RowNames', string(predictorNames'));
featureImportanceTable.score = featureImportance';
