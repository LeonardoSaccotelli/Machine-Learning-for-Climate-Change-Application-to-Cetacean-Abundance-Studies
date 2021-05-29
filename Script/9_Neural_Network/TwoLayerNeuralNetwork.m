% Restituisce una rete neurale a 2 layers di regressione addestrato e il relativo RMSE. 
% Questo codice ricrea il modello addestrato. 
% Usa il codice generato per automatizzare l'addestramento dello stesso modello 
% con nuovi dati.
% Input:
% trainingData: una tabella contenente le stesse colonne di predittore e risposta di quelle
% 				usate per addestrare il modello.
%
% Output:
% - twoLayerNeuralNetwork_Trained_Model: una struttura contenente la rete neurale di regressione addestrata. 
% 	La struttura contiene vari campi con informazioni sul modello.
%	twoLayerNeuralNetwork_Trained_Model.predictFcn: una funzione per fare previsioni su nuovi dati.
%
% - validationRMSE: un double contenente l'RMSE.
%
% - validationPredictions: un array contenente le previsioni eseguite.
% Utilizzare il codice per addestrare il modello con nuovi dati. Per riaddestrare il tuo modello,
% chiama la funzione dalla riga di comando con i tuoi dati originali o nuovi
% di dati come argomento di input della funzione trainingData.
%
% Ad esempio, per riaddestrare una rete neurale di regressione addestrata con i dati originali
% sia T il dataset da utilizzare, inserisci:
% [twoLayerNeuralNetwork_Trained_Model, validationRMSE,validationPredictions] =...
%														  = TwoLayerNeuralNetwork (T) 
%
% Per fare previsioni con il "modello addestrato" restituito su nuovi dati T2, utilizzare
% yfit = twoLayerNeuralNetwork_Trained_Model.predictFcn (T2)
%
% T2 deve essere una tabella contenente almeno le stesse colonne predittive utilizzate
% durante l'addestramento. Per i dettagli, inserisci:
% twoLayerNeuralNetwork_Trained_Model.HowToPredict

function [twoLayerNeuralNetwork_Trained_Model, validationRMSE,validationPredictions] = ...
    TwoLayerNeuralNetwork(trainingData)
	
% Estrai predittori e feature da stimare
% Questo codice elabora i dati nella forma corretta per l'addestramento del
% modello.
inputTable = trainingData;

% Selezione le feature da usare per l'addestramento
predictorNames = inputTable.Properties.VariableNames;
predictorNames(:,(strncmp(predictorNames, "n_individuals",...
        strlength("n_individuals")))) = [];

% Estrapolo la tabella con le feature da usare per l'addestramento
featureForTraining = inputTable(:, predictorNames);
% Estrapolo la feature da stimare, la variabile target
targetFeature = inputTable.n_individuals;

% Addestra la rete neurale di regressione
% Specifichiamo i parametri e addestriamo il modello.
regressionNeuralNetwork = fitrnet(...
    featureForTraining, ...
    targetFeature, ...
    'LayerSizes', [50 50], ...
    'Activations', 'sigmoid', ...
    'Lambda', 1.1212, ...
    'IterationLimit', 1000, ...
    'Standardize', true);

% Salviamo i risultati in una struttura con la funzione per effettuare una previsione
predictorExtractionFcn = @(t) t(:, predictorNames);
neuralNetworkPredictFcn = @(x) predict(regressionNeuralNetwork, x);
twoLayerNeuralNetwork_Trained_Model.predictFcn = @(x) neuralNetworkPredictFcn(predictorExtractionFcn(x));

% Aggiungiamo campi informativi alla nostra struttura
twoLayerNeuralNetwork_Trained_Model.RequiredVariables = inputTable.Properties.VariableNames;
twoLayerNeuralNetwork_Trained_Model.RegressionNeuralNetwork = regressionNeuralNetwork;
twoLayerNeuralNetwork_Trained_Model.About = 'This struct is a trained model exported from Regression Learner R2021a.';
twoLayerNeuralNetwork_Trained_Model.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''twoLayerNeuralNetwork_Trained_Model''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Estrai predittori e feature da stimare
% Questo codice elabora i dati nella forma corretta per l'addestramento del
% modello.
inputTable = trainingData;

% Selezione le feature da usare per l'addestramento
predictorNames = inputTable.Properties.VariableNames;
predictorNames(:,(strncmp(predictorNames, "n_individuals",...
        strlength("n_individuals")))) = [];

% Estrapolo la tabella con le feature da usare per l'addestramento
featureForTraining = inputTable(:, predictorNames);
% Estrapolo la feature da stimare, la variabile target
targetFeature = inputTable.n_individuals;

% Eseguiamo la cross-validation con k = 5
partitionedModel = crossval(twoLayerNeuralNetwork_Trained_Model.RegressionNeuralNetwork, 'KFold', 5);

% Computiamo le predizioni effettuate
validationPredictions = kfoldPredict(partitionedModel);

% Computiamo l'RMSE
validationRMSE = sqrt(kfoldLoss(partitionedModel, 'LossFun', 'mse'));
