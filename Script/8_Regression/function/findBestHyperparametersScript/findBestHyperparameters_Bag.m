%% Script per individuare gli iperparametri 
% migliori per il  modello di regressione Random Forest

% Seleziono il dataset
dataset = ST;

% Seleziono feature e variabile target
predictors = dataset;
predictors.n_individuals = [];
response = dataset.n_individuals;

% Ottimizzo il modello
optimizeRandomForest = fitrensemble(...
    predictors, ...
    response, ...
    'Method', 'Bag', ...
    'OptimizeHyperParameters',{'NumLearningCycles','MinLeafSize'});