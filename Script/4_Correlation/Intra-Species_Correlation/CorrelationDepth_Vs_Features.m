%% Script per calcolare il coefficiente di correlazione tra Profondità e
%  Feature rilevata a varie profondità. Per fare questo è stato ricavato un
%  vettore di profondità strutturato come segue:
%  - 0 * n volte rappresenta tutti i rilevamenti avvenuti in superficie
%  - 10 * n volte rappresenta tutti i rilevamenti avvenuti a 10m di
%    profondità
%  - Si prosegue fino a 1000m, con n = numero di righe nel dataset 
%  Viene costruito un vettore contenente tutte le profondità per una
%  determinata feature dalla superficie fino a 1000m di profondità. Viene
%  quindi calcolato il coefficiente di correlazione tra la profondità e la
%  feature, mantenendo solo coefficienti in modulo > 0.7 e con p-value <
%  0.05.
%
%  COME USARLO
%  1) In dataset sostituire 'T' con il nome del dataset
%  2) In prefixFeature sostituire il nome inserito con il prefisso della
%  feature che si vuole considerare.

% Seleziono il dataset da usare
dataset = STG;

% Creo il vettore profondità
depth = createDepth(height(dataset));

% Seleziono il nome della feature che voglio correlare
prefixFeature = 'prim';

% Seleziono l'insieme di feature da correlare con la profondità
feature = createFeatureAllDepth(dataset,prefixFeature);

%Creo la tabella con le feature da correlare
correlationFeature = [depth feature];
correlationFeature = array2table(correlationFeature,'VariableNames',{'depth',prefixFeature});

% Calcolo il coeffieciente di correlazione e il p-value
[R,P]= corrcoef(table2array(correlationFeature));

% Stampo i risultati se i coefficienti sono significativi
if((abs(R(1,2))>0.7) && (P(1,2)<0.01))
    corrplot(correlationFeature);
    figure;
    heatmap(R);
else
   disp('Correlation coefficient < 0.7 or p-value > 0.01');
end

%{
plot(feature);
hold on
plot(8136*ones(30,1),linspace(12,30,30)); %50m
plot(13562*ones(30,1),linspace(12,30,30)); %500m
%}


% Funzione per creare il vettore delle profondità
function depth = createDepth(numberOfRows)
    depth = [zeros(numberOfRows,1); ones(numberOfRows,1)*10; ones(numberOfRows,1)*20;
        ones(numberOfRows,1)*30; ones(numberOfRows,1)*40; ones(numberOfRows,1)*50;
        ones(numberOfRows,1)*100; ones(numberOfRows,1)*200; ones(numberOfRows,1)*300;
        ones(numberOfRows,1)*400; ones(numberOfRows,1)*500; ones(numberOfRows,1)*600;
        ones(numberOfRows,1)*700; ones(numberOfRows,1)*800; ones(numberOfRows,1)*900;
        ones(numberOfRows,1)*1000;];
end

% Funzione per creare il vettore ottenuto unendo un insieme di feature
% semanticamente legate ma rilevate a profondità diverse
function featureAllDepth = createFeatureAllDepth(dataset, prefixFeature)
    subFeature = dataset;
    subFeature(:,not(strncmp(subFeature.Properties.VariableNames, prefixFeature, strlength(prefixFeature)))) = [];
    subFeature = table2array(subFeature);
	featureAllDepth = transpose(reshape(subFeature,1,[]));
end