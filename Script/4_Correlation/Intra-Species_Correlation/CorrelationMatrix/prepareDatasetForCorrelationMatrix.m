%% Script per preparare il dataset per la creazione della matrice di correlazione
%  Lo script contiene:
%  prepareDataset(), che permette di preparare il dataset in modo tale da
%  poter calcolare la matrice di correlazione. Restituisce:
%  - il dataset preparato
%  - la matrice di correlazione vuota
%  - la matrice dei pvalue vuota
function [datasetPreparedForCorrelation, correlationMatrix, pValueMatrix] = prepareDatasetForCorrelationMatrix(dataset)
       % Rimuoviamo la feature 'species' essendo categorica e dovendo
       % calcolare la correlazione tra feature intra-specie
       datasetPreparedForCorrelation = dataset;
       % Rimuoviamo la feature 'species' quando usiamo i dataset S,T,G
       datasetPreparedForCorrelation.species = [];
       
       % Convertiamo la feature 'species' in un campo numerico quando
       % usiamo il dataset STG
       %datasetPreparedForCorrelation.species = double(categorical(datasetPreparedForCorrelation.species));
       
       % Creo la matrice di correlazione contenente tutte le feature del
       % dataset
       correlationMatrix = datasetPreparedForCorrelation;
       correlationMatrix(:,:) = [];
       
       % Creo la matrice contenente i p-value associati ad ogni
       % coefficiente di correlazione calcolato
       pValueMatrix = correlationMatrix;       
end

