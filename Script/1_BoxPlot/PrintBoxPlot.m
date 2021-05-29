%% Script per plottare i boxplot
%  Lo script permette di creare più boxplot nella stessa figura.
%  Possiamo utilizzare per confrontare i valori relativi ad una
%  stessa feature presente in classi diversi (classi di una 
%  variabile target). 
%  Ad esempio, possiamo confrontare il boxplot della feature
%  'n_individuals' in tre dataset diversi rappresentati ognuno le tre 
%  specie di delfini (G, S, T).
%
%  COME USARLO: 
%  1) Sostituire in featureOf<X> il nome del dataset che vogliamo
%  utilizzare. Nel nostro caso usiamo 3 dataset diversi che condividono lo
%  stesso schema.
%  1) In 'groupingFeaturesFromClass' aggiungere o togliere 'featureOf<X> a
%  seconda di quanti dataset diversi stiamo usando
%  3) In 'numRowForClass' è importante aggiungere
%  k*ones(1,numel(featureOf<X>)) per k = 2,3,4,... a seconda del numero dei
%  dataset diversi che stiamo usando. Infatti, al punto 4 abbiamo unito le
%  righe proveniente da dataset diversi in un'unica riga. La variabile 
%  'numRowForClass serve come contatore del numero di righe appartenenti ad
%  ogni dataset.
%  4) In subplot aggiornare i primi due parametri in base a quanti subplot
%  vogliamo inserire in una singola figura.
%  5) Infine, in boxplot() cambiare le labels assegnate alle singole
%  classi.

% A partire da una tabella, estraggo una colonna e ne eseguo la 
% trasposta, così da avere un vettore riga
featureOfG = (G.n_individuals)';
featureOfS = (S.n_individuals)';
featureOfT = (T.n_individuals)';

% Raggruppiamo le feature in un unico vettore
groupingFeaturesFromClass = [featureOfG featureOfS featureOfT ];

% Settiamo il numero di righe appartententi ad ogni classe
numRowForClass = [zeros(1,numel(featureOfG)),ones(1,numel(featureOfS)), 2*ones(1,numel(featureOfT))];

% Stampiamo il grafico
boxplot(groupingFeaturesFromClass, numRowForClass,'Labels',{'Grampus','Stenella','Tursiope'});
title('n individuals');
%savefig('Numero_individui');
