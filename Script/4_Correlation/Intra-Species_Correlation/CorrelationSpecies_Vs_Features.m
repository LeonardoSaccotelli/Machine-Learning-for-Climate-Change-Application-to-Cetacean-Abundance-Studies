%% Script per calcolare i coefficienti di correlazione tra la feature 
%  'species' e tutte le altre feature presenti nel dataset
%  Lo script crea una tabella contenente i coefficienti di correlazione e i
%  p-value ottenuti calcolando la correlazione tra 'species' e le
%  altre feature.
%
%  COME USARLO:
%  1) Sostituire 'STG' con il nome del dataset
%  2) Assicurati che il dataset di partenza abbia le feature corrette
%  3) Cambiare il nome del file excel che verrà generato con il nome
%  più opportuno

dataset = STG;

% Creo una tabella contenente due colonne, 'corr_coef' e 'p_value'
correlation = table('Size', [size(dataset,2) 2], 'VariableTypes', {'double','double'},...
    'VariableNames', {'corr_coef','p_value'}, 'RowNames', dataset.Properties.VariableNames);

% Per poter calcolare i coefficienti di correlazione il campo species è
% stato convertito in un campo numerico assegnando ad ogni specie un valore
% numerico (S=0,T=1,G=2).
species = double(categorical(dataset.species));

% Calcolo i coefficienti di correlazione
correlation(1,1) = {1};
for i = 2 : size(dataset,2)
    [R,P] = corrcoef(species,table2array(dataset(:,i)));
    correlation(i,1) = {R(1,2)};
    correlation(i,2) = {P(1,2)};    
end

%writetable(correlation,"correlationSpeciesVsFeatures.xls",'WriteRowNames',true);