%% Script per il calcolo della PCA
%  Lo script permette di calcolare la PCA su dataset diversi, mettendo a
%  confronto i risultati per coppie di specie di delfini. In particolare,
%  dopo aver calcolato la PCA, stampiamo uno scatter plot 3D, confrontando
%  le 3 componenti principali di due dataset diversi. Rispettivamente
%  confrontiamo:
%  - G vs T
%  - T vs S
%  - G vs S
%  Inoltre, calcoliamo la PCA anche sul dataset STG.
%  Successivamente realizziamo un pareto chart per ogni dataset, mostrando
%  la varianza (in percentuale) di ogni componente principale.

% Preparazione dei dataset per
% il calcolo della PCA
G_PCA = prepareDatasetForPCA(G);
S_PCA = prepareDatasetForPCA(S);
T_PCA = prepareDatasetForPCA(T);
STG_PCA = prepareDatasetForPCA(STG);

% Calcolo della PCA
[scoreG,explainedG,~] = computePCAonDataset(G_PCA,10);
[scoreS,explainedS,~ ] = computePCAonDataset(S_PCA,10);
[scoreT,explainedT,~ ] = computePCAonDataset(T_PCA,10);
[scoreSTG,explainedSTG,~] = computePCAonDataset(STG_PCA,10);

% Stampiamo in uno scatter plot 3D le 3 componenti principali di ogni
% coppia di specie, così da poterle confrontate

plot3PrincipalComponent(scoreG,scoreT,'Grampus','Tursiope');
figure;
plot3PrincipalComponent(scoreT,scoreS,'Tursiope','Stenella');
figure;
plot3PrincipalComponent(scoreG,scoreS,'Grampus','Stenella');

% Stampiamo in uno scatter plot le 2 componenti principali di ogni
% coppia di specie, così da poterle confrontate
figure;
plot2PrincipalComponent(scoreG,scoreT,'Grampus','Tursiope');
figure;
plot2PrincipalComponent(scoreT,scoreS,'Tursiope','Stenella');
figure;
plot2PrincipalComponent(scoreG,scoreS,'Grampus','Stenella');

% Stampiamo un pareto chart per ogni dataset, mostrando
% la varianza (in percentuale) di ogni componente principale.

plotVariancePercentage(explainedG,'Grampus');
plotVariancePercentage(explainedS,'Tursiope');
plotVariancePercentage(explainedT,'Stenella');
plotVariancePercentage(explainedSTG,'STG');


% Funzione per preparare il dataset per poter calcolare la PCA; in
% particolare andiamo a rimuovere il campo 'species' (la PCA lavoro su
% feature numeriche) e a normalizzare il dataset.
function newDataset = prepareDatasetForPCA (dataset)
    newDataset = dataset;
    % Rimuovo dal dataset la feature categorical 'species' per i soli
    % dataset S, T, G. Per il dataset STG commentare questa istruzione.
    % newDataset.species = [];
    
    % Converto la feature 'species' in un campo numerico discreto,
    % assegnando un numero intero ad ogni specie diversa. Per i dataset
    % S,T,G, commentare la seguente istruzione.
    newDataset.species = double(categorical(newDataset.species));
    
    % Rimuovo dal dataset la feature 'n_individuals', essendo la variabile
    % target
    newDataset.n_individuals = [];    
    newDataset = table2array(newDataset);
end

% Funzione per il calcolo della PCA
function [score,explained, reducedFeatureMatrix] = computePCAonDataset(dataset, numDimension)   
    % Calcolo le componenti principali
    [coeff, score, ~, ~, explained, ~] = pca(dataset);
    reducedDimension = coeff(:,1:numDimension);
    
    % Aggiorno il dataset mantenendo la nuova struttura ridotta
    reducedFeatureMatrix = dataset * reducedDimension;
end


% Funzione per plottare un 3D-scatter plot che permette di confrontare le 3
% compomenti principali di due dataset diversi.
function plot3PrincipalComponent (scoreA, scoreB, labelA, labelB)
    scatter3(scoreA(:,1),scoreA(:,2),scoreA(:,3));
    hold on
    scatter3(scoreB(:,1),scoreB(:,2),scoreB(:,3));
    legend(labelA,labelB);
    
    xlabel('PC1');
    ylabel('PC2');
    zlabel('PC3');
    title(strcat(labelA," vs ",labelB));
end

% Funzione per plottare uno scatter plot che permette di confrontare le 2
% compomenti principali di due dataset diversi.
function plot2PrincipalComponent (scoreA, scoreB, labelA, labelB)
    scatter(scoreA(:,1),scoreA(:,2));
    hold on
    scatter(scoreB(:,1),scoreB(:,2));
    legend(labelA,labelB);
    
    xlabel('PC1');
    ylabel('PC2');
    title(strcat(labelA," vs ",labelB));
end


% Funzione per plottare un pareto chart che permtte di mostrare
% la varianza (in percentuale) di ogni componente principale.
function plotVariancePercentage (explainedX, nameDataset)
    figure;
    pareto(explainedX);
    xlabel('Componenti principali');
    ylabel('Varianza (%)');
    title(strcat('Varianza delle PC per'," ", nameDataset ));
end