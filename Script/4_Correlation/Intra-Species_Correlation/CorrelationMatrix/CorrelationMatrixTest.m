%% Script per calcolare la matrice di correlazione su un insieme di features
%  Lo script crea una matrice di correlazione di dimensione NxN, con N =
%  numero di feature, calcolando la correlazione tra una feature e tutte le
%  altre presenti nel dataset.
%
%  COME USARLO:
%  1) In 'speciesName' sostituire 'T' con il nome del dataset
%  2) In 'prepareDataset()' sostituire 'T' con il nome del dataset
%  3) In 'writematrix' sostituire il nome del file
%  4) In 'writetable()' sostituire il nome del file

% Recupero il nome della speicie oggetto di analisi
%speciesName = table2array(G(1,1));
speciesName = 'Tursiope';

% Preparo il dataset su cui calcolare il coefficiente di correlazione e le
% matrici che conterrano i risultati della correlazione calcolata
[data,correlationMatrix,pValueMatrix] = prepareDatasetForCorrelationMatrix(T);

% Calcolo il coefficiente di correlazione di Pearson, memorizzando valore
% del coefficiente e p-value associato
[correlationMatrix,pValueMatrix] = computeCorrelationMatrix(data,correlationMatrix,pValueMatrix);

% Recupero i nomi delle feature presenti nel dataset
featuresList = strrep(correlationMatrix.Properties.VariableNames,'_',' ');

correlationMatrix = table2array(correlationMatrix);

% Calcolo il valore assoluto dei coefficienti di correlazione calcolati
absCorrelationMatrix = abs(correlationMatrix);

% Stampo la matrice di correlazione utilizzando una heatmap
h = heatmap(absCorrelationMatrix);
h.title(speciesName);

% Salvo i risultati su due file excel
%writetable(array2table(absCorrelationMatrix, 'VariableNames',featuresList ),"correlation_Matrix_STG.xls")
%writetable(pValueMatrix,"pvalue_Matrix_STG.xls")
