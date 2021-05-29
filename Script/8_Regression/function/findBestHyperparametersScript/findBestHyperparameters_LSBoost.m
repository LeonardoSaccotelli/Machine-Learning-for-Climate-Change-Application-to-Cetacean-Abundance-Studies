%% Script per individuare gli iperparametri migliori 
% per il  modello di regressione LSBoost

% Seleziono il dataset
dataset = ST;

% Seleziono feature e variabile target
predictors = dataset;
predictors.n_individuals = [];
response = dataset.n_individuals;

% Ottimizzo il modello
optimizeLSBoost = fitrensemble(...
    predictors, ...
    response, ...
    'Method', 'LSBoost', ...
    'OptimizeHyperParameters',{'NumLearningCycles','LearnRate','MinLeafSize'});