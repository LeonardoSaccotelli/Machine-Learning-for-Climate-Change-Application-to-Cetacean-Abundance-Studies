%% Lo script permette di creare un modello di regressione
%  a partire da una funzione in cui è definito il modello.
%  La funzione restituisce:
%  - il modello addestrato
%  - rmse misurato
%  - le predizioni ottenuti
%  - uno score che indica l'importanza data 
%	 alle singole feature dal modello
%  Successivamente vengono creati due grafici, uno che mostra
%  le 10 feature più importanti, ordinate dalla più importante 
%  alla meno importante; uno che confronta per ogni osservazione
%  il numero di individui effettivo e quelli predetti.

% Seleziono il dataset
dataset = S;
datasetName = "S";

% Addestro il modello 
[LSBoostTrainedModel,validationRMSE, validationPredictions, featureImportance] = LSBoostRegressionModel(dataset);

% Plotto i risultati
plotPredictions(dataset.n_individuals,validationPredictions,datasetName,validationRMSE);
figure;
plotImportance(featureImportance,datasetName);

