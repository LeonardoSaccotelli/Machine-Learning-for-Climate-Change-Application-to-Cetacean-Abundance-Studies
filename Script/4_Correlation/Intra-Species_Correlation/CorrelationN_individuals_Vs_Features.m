%% Script per calcolare i coefficienti di correlazione tra la feature 
%  'n_individuals' e tutte le altre feature presenti nel dataset
%  Lo script crea una tabella contenente i coefficienti di correlazione e i
%  p-value ottenuti calcolando la correlazione tra 'n_individuals' e le
%  altre feature.
%
%  COME USARLO:
%  1) Sostituire 'STG' con il nome del dataset
%  2) Assicurati che il dataset di partenza abbia le feature corrette
%  3) Cambiare il nome del file excel che verrà generato con il nome
%  più opportuno

X = S;

% Rimuovo la feature specie, non rilevante in questo caso
X.species = [];

% Creo una tabella contenente due colonne, 'corr_coef' e 'p_value'
correlation = table('Size', [size(X,2) 2], 'VariableTypes', {'double','double'},...
    'VariableNames', {'corr_coef','p_value'}, 'RowNames', X.Properties.VariableNames);

% Per poter calcolare i coefficienti di correlazione il campo species è
% stato convertito in un campo numerico assegnando ad ogni specie un valore
% numerico (S=0,T=1,G=2).
%X.species = double(categorical(X.species));

% Calcolo i coefficienti di correlazione
correlation(1,1) = {1};
for i = 1 : size(X,2)
    [R,P] = corrcoef(X.n_individuals,table2array(X(:,i)));
    correlation(i,1) = {R(1,2)};
    correlation(i,2) = {P(1,2)};    
end

% Calcolo il valore assoluto dei coefficienti di correlazione e ordino in
% ordine discendete.
[~,idx] = sort(abs(correlation.corr_coef),'descend');
correlation=correlation(idx,:);

%writetable(correlation,"correlationN_individuals_Vs_Feature_S.xls",'WriteRowNames',true);