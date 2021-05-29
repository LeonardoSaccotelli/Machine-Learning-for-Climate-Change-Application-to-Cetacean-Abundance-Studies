%% Script per confronto la variazione nel tempo delle feature di interesse
%  L'analisi è condotta nel seguente modo:
%  - Analisi della variazione della stessa feature rilevata a profondità
%    diverse nel corso degli autumnSeason
%  - Analisi della variazione della media della feature rilevata 
%    per ogni anno, riportando anche la deviazione standard
%
%  COME USARLO
%  1) In dataset sostituire con il nome del dataset da usare
%  2) In prefixFeature sostituire il nome inserito con il prefisso della
%  feature che si vuole analizzare.

% Seleziono il dataset da utilizzare
dataset = temporalSTG;

% Seleziono il prefisso della feature di cui voglio 
% analizzare l'evoluzione nel tempo
prefixFeature = 'phosp'; 

% Rimuovo tutte le feature diverse da quelle da analizzare, ad eccezione
% della data di avvistamento
dataset(:,not(strncmp(dataset.Properties.VariableNames, prefixFeature, strlength(prefixFeature)))...
    & not(strncmp(dataset.Properties.VariableNames, 'date', strlength('date')))) = [];

% Stampo l'andamento negli anni delle feature
plotFeatureTemporalChanges(dataset);
figure
% Stampo l'andamento negli anni della media 
% delle feature con deviazione standard
plotMeanFeatureTrendSTDev(dataset);

% Funzione per estrapolare l'anno di avvistamento di cetacei
function [indexObservation,uniqueObservation] = findYearObservation (dataset)
    yearObservation = year(dataset.date);
    uniqueObservation = unique(yearObservation);
    indexObservation = zeros(height(uniqueObservation),1);

    for i = (1:height(uniqueObservation))
        index = find(year(dataset.date)==uniqueObservation(i,1));
        indexObservation(i) = index(1);
    end
    
    uniqueObservation = string(uniqueObservation);
end

% Funzione per stampare il plot dell'andamento nel tempo 
% delle singole feature.
function plotFeatureTemporalChanges(dataset)
    % Salvo il nome delle feature
    legends = strrep(dataset.Properties.VariableNames,'_',' ');
    
    numberOfRowsDataset = height(dataset);
    observationPoint = linspace(1,numberOfRowsDataset,numberOfRowsDataset);
    
    [indexYearObservation,yearObservation] = findYearObservation(dataset);
    
    for j = 2:width(dataset)
        % Stampiamo il grafico il grafico
        subplot(4,4,j-1);
        bar(observationPoint,table2array(dataset(:,j)));
        hold on
        plot(observationPoint,median(table2array(dataset(:,j)))*ones(numberOfRowsDataset,1),'k');
        plot(observationPoint,mean(table2array(dataset(:,j)))*ones(numberOfRowsDataset,1),'r');

        xticks(indexYearObservation)
        xticklabels(yearObservation);
        xlim([0 (numberOfRowsDataset+5)])
        xtickangle(90);

        title(legends(j));
    end
    figure;
    
    timeDataset = table2timetable(dataset);
    stackedplot(timeDataset);   
end

% Funzione per stampare il grafico che mostra l'andamento nel tempo
% della media delle singole feature, e per ogni media calcolata 
% la deviazione standard
function plotMeanFeatureTrendSTDev(dataset)
    tempDataset = dataset;
    tempDataset.date = year(tempDataset.date);
    meanTable = grpstats(tempDataset,'date',{'mean','std'});
    meanTable.GroupCount = [];
    
    numberOfFeature = 2*width(dataset)-1;
        
    for i = 2:2:numberOfFeature    
        numberOfYear = linspace(1,height(meanTable),height(meanTable));
        subplot(4,4,i/2);
        errorbar(numberOfYear,table2array(meanTable(:,i)),table2array(meanTable(:,i+1)));
        xticks(numberOfYear)
        xticklabels(table2array(meanTable(:,1)));
        xlim([0.5 height(meanTable)+0.5])
        [minYLim,maxYLim] = findBestMinMaxYRange(table2array(meanTable(:,i)),table2array(meanTable(:,i+1)));
        ylim([minYLim maxYLim]);
        xlabel('Year');
        ylabel(strrep(meanTable(:,i).Properties.VariableNames, '_',' '));
    end
   sgtitle('phosphate');
end

% La funzione permette di individuare il miglior range di valori per l'asse
% delle ordinate valutando le variazioni subite dai dati da parte della
% deviazione standard. Per ogni punto si somma e sottra la relativa
% deviazione standard; si individua il più piccolo valore y dopo aver
% sottratto la deviazione standard e il più grande valore y dopo aver
% aggiunto la deviazione standard. La miglior scelta viene decrementata e
% incrementata di 0.1 rispettivamente. 
function [minYLim, maxYLim] = findBestMinMaxYRange (y, std)
    minYStd = y - std;
    maxYStd = y + std;
    minYLim = min(minYStd)-0.1;
    maxYLim = max(maxYStd)+0.1;
end