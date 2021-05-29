%% Script per stamprare i boxplot su subrange di profondità 
%  La colonna d'acqua è stata divisa in 3 subrange 
%  1) Sup -> 50m
%  2) 100m --> 500m
%  3) 600m --> 1000m
%  Dopo aver selezionata la feature da analizzare, verranno prodotti 3
%  boxplot, uno per ogni range di profondità; all'interno di ognuno sono
%  confrontati i dati delle 3 specie prese in considerazione.
%
%  COME USARLO
%  1) In datasetX sostituire i nomi dei dataset con i nomi dei tuoi dataset
%  2) In prefixFeature sostituire il nome inserito con il prefisso della
%  feature che si vuole considerare.
%  3) In boxplot() e in title() rinominare eventualmente le labels 

% Recupero i dataset
dataset1 = S;
dataset2 = T;
dataset3 = G;

% Definisco il prefisso delle feature da recuperare
prefixFeature = 'nitrate';

printBoxplot2SubRangeDepth(dataset1,dataset2,dataset3,prefixFeature);
printBoxplot3SubRangeDepth(dataset1,dataset2,dataset3,prefixFeature);

function printBoxplot2SubRangeDepth (dataset1, dataset2,dataset3,prefixFeature)

    % Recupero i dati della feature selezionata divisi in 2 range di profondità
    [featureS_Sup,featureS_Depth] = createFeature2DifferentDepth(dataset1,prefixFeature);
    [featureT_Sup,featureT_Depth] = createFeature2DifferentDepth(dataset2,prefixFeature);
    [featureG_Sup,featureG_Depth] = createFeature2DifferentDepth(dataset3,prefixFeature);
    
    % Raggruppiamo le feature in un unico vettore per ogni range di profondità
    groupingFeaturesFromClass_Sup = [featureG_Sup; featureS_Sup; featureT_Sup ];
    groupingFeaturesFromClass_Depth = [featureG_Depth; featureS_Depth; featureT_Depth ];

    % Settiamo il numero di righe appartententi ad ogni classe
    numRowForClass_Sup = [zeros(1,numel(featureG_Sup)),ones(1,numel(featureS_Sup)), 2*ones(1,numel(featureT_Sup))];
    numRowForClass_Depth = [zeros(1,numel(featureG_Depth)),ones(1,numel(featureS_Depth)), 2*ones(1,numel(featureT_Depth))];

    set(gcf, 'Position',  [100, 100, 1400, 600]);
    % Stampiamo il grafico
    subplot(1,2,1);
    boxplot(groupingFeaturesFromClass_Sup, numRowForClass_Sup,'Labels',{'Grampus','Stenella','Tursiope'});
    title(strcat(prefixFeature," ","sup-50m"));

    subplot(1,2,2);
    boxplot(groupingFeaturesFromClass_Depth, numRowForClass_Depth,'Labels',{'Grampus','Stenella','Tursiope'});
    title(strcat(prefixFeature," ","100-1000m"));
    figure;
end

function printBoxplot3SubRangeDepth (dataset1, dataset2, dataset3, prefixFeature)
    
    % Recupero i dati della feature selezionata divisi in 3 range di profondità
    [featureS_Sup,featureS_Medium,featureS_Depth] = createFeature3DifferentDepth(dataset1,prefixFeature);
    [featureT_Sup,featureT_Medium,featureT_Depth] = createFeature3DifferentDepth(dataset2,prefixFeature);
    [featureG_Sup,featureG_Medium,featureG_Depth] = createFeature3DifferentDepth(dataset3,prefixFeature);

    % Raggruppiamo le feature in un unico vettore per ogni range di profondità
    groupingFeaturesFromClass_Sup = [featureG_Sup; featureS_Sup; featureT_Sup ];
    groupingFeaturesFromClass_Medium = [featureG_Medium; featureS_Medium; featureT_Medium ];
    groupingFeaturesFromClass_Depth = [featureG_Depth; featureS_Depth; featureT_Depth ];

    % Settiamo il numero di righe appartententi ad ogni classe
    numRowForClass_Sup = [zeros(1,numel(featureG_Sup)),ones(1,numel(featureS_Sup)), 2*ones(1,numel(featureT_Sup))];
    numRowForClass_Medium = [zeros(1,numel(featureG_Medium)),ones(1,numel(featureS_Medium)), 2*ones(1,numel(featureT_Medium))];
    numRowForClass_Depth = [zeros(1,numel(featureG_Depth)),ones(1,numel(featureS_Depth)), 2*ones(1,numel(featureT_Depth))];

    set(gcf, 'Position',  [100, 100, 1400, 400]);
    % Stampiamo il grafico
    subplot(1,3,1);
    boxplot(groupingFeaturesFromClass_Sup, numRowForClass_Sup,'Labels',{'Grampus','Stenella','Tursiope'});
    title(strcat(prefixFeature," ","sup-50m"));

    subplot(1,3,2);
    boxplot(groupingFeaturesFromClass_Medium, numRowForClass_Medium,'Labels',{'Grampus','Stenella','Tursiope'});
    title(strcat(prefixFeature," ","100-500m"));

    subplot(1,3,3);
    boxplot(groupingFeaturesFromClass_Depth, numRowForClass_Depth,'Labels',{'Grampus','Stenella','Tursiope'});
    title(strcat(prefixFeature," ","600-1000m"));
end


% Funzione per dividere un insieme di feature semanticamente correlate in 3
% variabili, ognuna per un diverso range di profondità
function [featureSup,featureMedium,featureDepth] = createFeature3DifferentDepth(dataset, prefixFeature)
    subFeature = dataset;
    subFeature(:,not(strncmp(subFeature.Properties.VariableNames, prefixFeature, length(prefixFeature)))) = [];
    subFeature = table2array(subFeature);
    featureSup = [subFeature(:,1); subFeature(:,2); subFeature(:,3); 
        subFeature(:,4); subFeature(:,5); subFeature(:,6) ];

    featureMedium = [subFeature(:,7); subFeature(:,8); subFeature(:,9); 
        subFeature(:,10); subFeature(:,11)];
    
    featureDepth = [subFeature(:,12);
        subFeature(:,13); subFeature(:,14); subFeature(:,15);
        subFeature(:,16)];
   
	featureSup = transpose(reshape(featureSup,1,[]));
   	featureMedium = transpose(reshape(featureMedium,1,[]));
   	featureDepth = transpose(reshape(featureDepth,1,[]));
end

% Funzione per dividere un insieme di feature semanticamente correlate in 2
% variabili, ognuna per un diverso range di profondità
function [featureSup,featureDepth] = createFeature2DifferentDepth(dataset, prefixFeature)
    subFeature = dataset;
    subFeature(:,not(strncmp(subFeature.Properties.VariableNames, prefixFeature, length(prefixFeature)))) = [];
    subFeature = table2array(subFeature);
    featureSup = [subFeature(:,1); subFeature(:,2); subFeature(:,3); 
        subFeature(:,4); subFeature(:,5); subFeature(:,6) ];
    
    featureDepth = [subFeature(:,7); subFeature(:,8); subFeature(:,9); 
        subFeature(:,10); subFeature(:,11); subFeature(:,12);
        subFeature(:,13); subFeature(:,14); subFeature(:,15);
        subFeature(:,16)];
        
	featureSup = transpose(reshape(featureSup,1,[]));
   	featureDepth = transpose(reshape(featureDepth,1,[]));
end