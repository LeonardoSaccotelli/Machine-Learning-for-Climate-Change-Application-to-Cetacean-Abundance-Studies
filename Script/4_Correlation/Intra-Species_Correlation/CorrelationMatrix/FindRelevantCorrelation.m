%% Script per calcolare la matrice di correlazione su un sottoinsieme di features
%  Lo script crea una matrice di correlazione di dimensione tra coppie subset di
%  feature semanticamente uniformi.
%  Il dataset contiene ad esempio la feature 'temperature' rilevata a varie
%  profondità. Così come temperature, molte altre feature sono rilevate a
%  varie profondità. Pertanto, creiamo subset nella forma 
%   temp = [ temp_sup, temp_10m, ..., temp_1000m ]
%   nitrate = [ nitrate_sup, nitrate_10m, ..., nitrate_1000m ]
%  calcolando quindi la matrice di correlazione tra 'temp' e 'nitrate'
%  Con l'obiettivo di individuare informazioni rilevanti, imponiamo che la
%  soglia per il coefficiente di correlazione sia in modulo > 0.7 e per il
%  quale il p-value < 0.01.
%  I risultati per i quali la condizione non è soddisfatta, verranno
%  impostati a NaN.
%  Nello script computiamo varie coppie di subset di feature, plottando per
%  ognuna una heatmap. Per maggiore leggibilità, i valori NaN vengono
%  anneriti. 
%  L'esperimento è condotto su tutti e quattro i dataset G,S,T,STG.
%
%  COME USARLO:
%  1) In 'computeRelevantCorrelation' sostituire il nome del dataset e il
%  nome della specie che si sta analizzando
%  Non è richiesta nessun'altra modifica, salvo modifiche nelle funzioni
%  sviluppate.


%computeRelevantCorrelation(G,'Grampus');
%computeRelevantCorrelation(S,'Stenella');
%computeRelevantCorrelation(T,'Tursiope');
computeRelevantCorrelation(STG,'Grampus,Stenella,Tursiope');

%% La funzione estrae due subset di feature; ogni subset ha feature semanticamente 
%  legate tra di loro. 
function [featureSet_1,featureSet_2] = extractFeatureSet (dataset, featureSet_1_Name, featureSet_2_Name)
    featureSet_1 = dataset;
    featureSet_1(:,not(strncmp(featureSet_1.Properties.VariableNames, featureSet_1_Name, strlength(featureSet_1_Name)))) = [];

    featureSet_2 = dataset;
    featureSet_2(:,not(strncmp(featureSet_2.Properties.VariableNames, featureSet_2_Name, strlength(featureSet_2_Name)))) = [];
end

%% Funzione per calcolare la matrice di correlazione su una tabella contenenente feature diverse
function [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(dataset)
    % Determino il numero di feature presenti nel dataset
    numberOfFeature = width(dataset);
    
    listOfFeature = strrep(dataset.Properties.VariableNames,'_',' ');
    
    % Creo la matrice di correlazione vuota
    correlationMatrix = dataset;
    correlationMatrix(:,:) = [];

    % Calcolo il coefficiente di correlazione di Pearson, memorizzando valore
    % del coefficiente
    for i = 1:numberOfFeature
        for j =1:numberOfFeature
            [R,P]= corrcoef(table2array(dataset(:,i)),table2array(dataset(:,j)));
            if (abs(R(1,2))> 0.7 && (P(1,2) <0.01))
                correlationMatrix(i,j) ={R(1,2)};
            end
        end
    end
    correlationMatrix = table2array(correlationMatrix);
    correlationMatrix(correlationMatrix == 0) = NaN;
end

%% La funzione si occupa di estrapolare coppie di feature rilevanti,
%  ne calcola la matrice di correlazione e mostra i risultati in una
%  heatmap.
function computeRelevantCorrelation (dataset, species)
    [nitrate,phosphate] = extractFeatureSet(dataset,'nitrate','phosphate');
    subsetOfFeature = [nitrate phosphate];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Nitrate-Phosphate'));
    figure;
    

    [nitrate,prim_prod] = extractFeatureSet(dataset,'nitrate','prim_prod');
    subsetOfFeature = [nitrate prim_prod];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Nitrate-Prim Prod'));
    figure;

    [nitrate,density] = extractFeatureSet(dataset,'nitrate','density');
    subsetOfFeature = [nitrate density];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Nitrate-Density'));
    figure;

    [phosphate,prim_prod] = extractFeatureSet(dataset,'phosphate','prim_prod');
    subsetOfFeature = [phosphate prim_prod];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Phosphate-Prim Prod'));
    figure;

    [phosphate,density] = extractFeatureSet(dataset,'phosphate','density');
    subsetOfFeature = [phosphate density];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Phosphate-Density'));
    figure;

    [nitrate,salinity] = extractFeatureSet(dataset,'nitrate','salinity');
    subsetOfFeature = [nitrate salinity];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Nitrate-Salinity'));
    figure;

    [phosphate,salinity] = extractFeatureSet(dataset,'phosphate','salinity');
    subsetOfFeature = [phosphate salinity];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Phosphate-Salinity'));
    figure;

    [nitrate,temperature] = extractFeatureSet(dataset,'nitrate','temp');
    subsetOfFeature = [nitrate temperature];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Nitrate-Temperature'));
    figure;

    [phosphate,temperature] = extractFeatureSet(dataset,'phosphate','temp');
    subsetOfFeature = [phosphate temperature];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Phosphate-Temperature'));
    figure;

    [density,temperature] = extractFeatureSet(dataset,'density','temp');
    subsetOfFeature = [density temperature];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Density-Temperature'));
    figure;

    [salinity,temperature] = extractFeatureSet(dataset,'salinity','temp');
    subsetOfFeature = [salinity temperature];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Salinity-Temperature'));
    figure;

    [salinity,density] = extractFeatureSet(dataset,'salinity','density');
    subsetOfFeature = [salinity density];
    [correlationMatrix,listOfFeature] = computeCorrelationMatrixOnSubsetFeature(subsetOfFeature);
    h = heatmap(listOfFeature,listOfFeature,correlationMatrix);
    h.title(strcat(species,': Salinity-Density'));
end