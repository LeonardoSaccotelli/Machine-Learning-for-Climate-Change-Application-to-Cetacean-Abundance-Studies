%% Script per plottare un gruppo di boxplot
%  Lo script permette di raggruppare 16 diverse figure (in una sola)
%  contenenti più boxplot in ognuna.
%  Il dataset contiene feature semanticamente uguali ma che differiscono in
%  relazione alla modalità di acquisizione.
%  Ad esempio, la feature 'temp' è rilevata sia in superficie, sia a
%  diverse profondità (da 10 fino a 1000 metri).
%  Possiamo quindi raggruppare i boxplot di più feature semanticamente
%  uguali e confrontarle rispetto alla specie di delfino (G, S, T).
%  Lo script funziona a condizione che le feature semanticamente uguali
%  siamo poste in modo consecutivo, quindi posso individuare una colonna
%  iniziale e una colonna finale.
%
%  COME USARLO: 
%  1) Aggiornare 'firstFeature' e 'lastFeature' con l'indice della nuova
%  colonna di inizio e di fine
%  2) In 'nameFeatures' sostituire 'T' con il nome del dataset che si vuole
%  usare
%  3) Sostituire in featureOf<X> il nome del dataset che vogliamo
%  utilizzare. Nel nostro caso usiamo 3 dataset diversi che condividono lo
%  stesso schema.
%  4) In 'groupingFeaturesFromClass' aggiungere o togliere 'featureOf<X> a
%  seconda di quanti dataset diversi stiamo usando
%  5) In 'numRowForClass' è importante aggiungere
%  k*ones(1,numel(featureOf<X>)) per k = 2,3,4,... a seconda del numero dei
%  dataset diversi che stiamo usando. Infatti, al punto 4 abbiamo unito le
%  righe proveniente da dataset diversi in un'unica riga. La variabile 
%  'numRowForClass serve come contatore del numero di righe appartenenti ad
%  ogni dataset.
%  6) In subplot aggiornare i primi due parametri in base a quanti subplot
%  vogliamo inserire in una singola figura.
%  7) Infine, in boxplot() cambiare le labels assegnate alle singole
%  classi.

% Setto l'indice della feature di partenza e della feature di arrivo che
% voglio raggruppare in una figura.
firstFeature = 70;
lastFeature = 84;

% Recupero il nome delle colonne dalla tabella del dataset, rimuovo il
% carattere '_' e lo sostituisco con un carattere vuoto. Il nome delle
% colonne ci servirà per il titolo dei singoli subplot relativi a ciascuna
% feature.
nameFeatures = strrep(T.Properties.VariableNames,'_',' ');

for j = firstFeature:lastFeature
    % A partire da una tabella, estraggo una colonna e ne eseguo la 
    % trasposta, così da avere un vettore riga
    featureOfG = (table2array(G(:,j)))';
    featureOfS = (table2array(S(:,j)))';
    featureOfT = (table2array(T(:,j)))';

    % Raggruppiamo le feature in un unico vettore
    groupingFeaturesFromClass = [featureOfG featureOfS featureOfT ];

    % Settiamo il numero di righe appartententi ad ogni classe
    numRowForClass = [zeros(1,numel(featureOfG)),ones(1,numel(featureOfS)), 2*ones(1,numel(featureOfT))];

    % Stampiamo il grafico il grafico
    subplot(5,3,j-(firstFeature-1))
    boxplot(groupingFeaturesFromClass, numRowForClass,'Labels',{'Grampus','Stenella','Tursiope'});
    title(nameFeatures(j));
end