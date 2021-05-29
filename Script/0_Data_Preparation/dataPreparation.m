% original: Dataset caricato da .csv
% STG: Dataset avvistamenti Stenelle, Tursiopi, Grampi
% S: Dataset avvistamenti Stenelle
% T: Dataset avvistamenti Tursiopi
% S: Dataset avvistamenti Grampi

original = readtable('Dataset_2009_2019_completo');
STG = original;

STG.species = lower(string(STG.species));

% elimino colonne non utili alla regressione: id e date
STG.id = [];
STG.date = [];

%h = histogram(categorical(STG.species))
%title("Avvistamenti")

% escludo specie poco presenti
STG = STG(ismember(STG.species,["grampus griseus","stenella coeruleoalba","tursiops truncatus"]),:);

% elimino mixed_layer_depth perchè contiene molti NaN (circa 800)
STG.mixed_layer_depth = [];

% elimino righe contenenti NaN
STG(any(ismissing(STG),2), :) = [];

% i valori di n_individuals > 100 (64 valori) sono considerati outlier,
% quindi vengono posti uguali a 100
STG.n_individuals((STG.n_individuals > 100)) = 100;

% creo dataset S,T,G
S = STG(ismember(STG.species,["stenella coeruleoalba"]),:);
T = STG(ismember(STG.species,["tursiops truncatus"]),:);
G = STG(ismember(STG.species,["grampus griseus"]),:);