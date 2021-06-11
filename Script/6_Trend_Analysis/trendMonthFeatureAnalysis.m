%% Script per confronto la variazione nel tempo delle feature di interesse
%  L'analisi è condotta nel seguente modo:
%  - Analisi della variazione della stessa feature rilevata a profondità
%    diverse nel corso dei mesi
%  - Analisi della variazione della media della feature rilevata 
%    per ogni mese, riportando anche la deviazione standard
%
%  COME USARLO
%  1) In dataset sostituire con il nome del dataset da usare
%  2) In prefixFeature sostituire il nome inserito con il prefisso della
%  feature che si vuole analizzare.

% Seleziono il dataset da utilizzare
dataset = temporalSTG;

% Seleziono il prefisso della feature di cui voglio 
% analizzare l'evoluzione nel tempo
prefixFeature = 'temp'; 

% Rimuovo tutte le feature diverse da quelle da analizzare, ad eccezione
% della data di avvistamento
dataset(:,not(strncmp(dataset.Properties.VariableNames, prefixFeature, strlength(prefixFeature)))...
    & not(strncmp(dataset.Properties.VariableNames, 'date', strlength('date')))) = [];

% Stampo l'andamento negli anni della media 
% delle feature con deviazione standard
plotMeanFeatureTrendSTDev(dataset);

% Funzione per stampare il grafico che mostra l'andamento nel tempo
% della media delle singole feature, e per ogni media calcolata 
% la deviazione standard
function plotMeanFeatureTrendSTDev(dataset)
    tempDataset = dataset;
    tempDataset.date = month(tempDataset.date);
    meanTable = grpstats(tempDataset,'date',{'mean','std'});
    meanTable.GroupCount = [];
    
    numberOfFeature = 2*width(dataset)-1;
    for i = 2:2:numberOfFeature    
        numberOfMonth = linspace(1,height(meanTable),height(meanTable));
        subplot(4,4,i/2);
        errorbar(numberOfMonth,table2array(meanTable(:,i)),table2array(meanTable(:,i+1)));
        xticks(numberOfMonth)
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
        xlim([0.5 height(meanTable)+0.5])
        [minYLim,maxYLim] = findBestMinMaxYRange(table2array(meanTable(:,i)),table2array(meanTable(:,i+1)));
        ylim([minYLim maxYLim]);
        xlabel('month');
        ylabel(strrep(meanTable(:,i).Properties.VariableNames, '_',' '));
    end
   sgtitle('temperature');
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
    minYLim = min(minYStd)-1;
    maxYLim = max(maxYStd)+1;
end