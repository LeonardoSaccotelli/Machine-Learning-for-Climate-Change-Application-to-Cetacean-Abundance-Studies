%% Lo script permette di calcolare il coefficiente di correlazione tra
%  pacchetti di feature uguali o differenti tra due classi diverse. 
%  Ad esempio, date le classi G e T, posso calcolare il coefficiente di
%  correlazione tra i rispettivi pacchetti (es nitrati) oppure tra
%  pacchetti diversi (es, per G nitrati, per T fosfati). Questo script
%  serve per effettuare un test preliminare, tenendo conto del fatto che i
%  dataset non hanno lo stesso numero di esempi. Per questo motivo
%  l'esperimento è ripetuto un certo numero di volte; ad ogni iterazione
%  viene campionato casualmente un numero di esempi pari al numero di
%  esempi presenti nel dataset meno numeroso.

% Seleziono i dataset
% NOTA: dataset1 è il dataset meno numeroso, dataset2 è quello più numeroso
dataset1 = G;
dataset2 = S;
dataset1.species = [];
dataset2.species = [];

% Scelgo le feature da correlare per ogni dataset
featureName = ["temperature","density","salinity","chl_a",...
    "primary_production","nitrate","phosphate"];

prefixFeature1 = ["temp" "dens" "sal" "chl" "prim" "nitr" "phosp"];
prefixFeature2 = ["temp" "dens" "sal" "chl" "prim" "nitr" "phosp"];

% Creo la tabella che conterrà i risultati
results = table('Size', [width(featureName) 6], 'VariableTypes',...
    {'string','string','double','double','double','double'}, 'VariableNames', ...
    {'abs(corr) > 0.7','pvalue < 0.01','median corr','mean corr',...
    'min corr','max corr'},'RowNames', featureName);


% Fisso il numero di volte che l'esperimento verrà condotto
n_iterations = 100000;

% Da ogni dataset rimuovo tutte le feature ad eccezione delle due da
% correlare
for i = 1:width(prefixFeature1)

    data1 = dataset1;
    data2 = dataset2;

    data1(:,not(strncmp(data1.Properties.VariableNames, prefixFeature1(i),...
        strlength(prefixFeature1(i))))) = [];
    data2(:,not(strncmp(data2.Properties.VariableNames, prefixFeature2(i), ...
        strlength(prefixFeature2(i))))) = [];
    
    % Determino il numero di feature e il numero di esempi dei due dataset
    numberOfFeature = width(data1);
    numberOfRowDataset1 = height(data1);
    numberOfRowDataset2 = height(data2);

    % Creo il pacchetto di feature per il dataset meno numeroso
    feature1 = createFeatureAllDepth(data1);

    % Inizializzo i vettori che conterranno i risultati
    corrcoeff = zeros(n_iterations,1);
    pvalue = zeros(n_iterations,1);

    % Inizializziamo le variabili che conteranno i risultati significativi
    countValidPvalue = 0;
    countValidCorrCoeff = 0;

    for j = 1:n_iterations
        % Seleziono casualmente gli esempi dal dataset più numeroso
        indexForDataReduction = randperm(numberOfRowDataset2,numberOfRowDataset1);

        % Costruisco il pacchetto di feature per il dataset ridotto 
        reduceFeature2 = data2(indexForDataReduction,:);
        reduceFeature2 = createFeatureAllDepth(reduceFeature2);

        % Calcolo il coefficiente di correlazione
        [R,P] = corrcoef(feature1,reduceFeature2);
        corrcoeff(j) = R(1,2);
        pvalue(j) = P(1,2);

        if pvalue(j) < 0.01
            countValidPvalue = countValidPvalue+1;
            if abs(corrcoeff(j)) > 0.7
                countValidCorrCoeff = countValidCorrCoeff+1;
            end
        end
    end

    % numero di iterazioni sulle ascisse
    x = linspace(1,n_iterations,n_iterations);
    
    % Plotto i risultati
    figure;
    bar(x,abs(corrcoeff));
    hold on
    plot(x, 0.7*ones(n_iterations,1));
    ylim([0 1]);
    xlabel('n iterations');
    ylabel('correlation coeff');
    title(strcat(prefixFeature1(i)," vs ", prefixFeature2(i)));
    
    disp('--------------------------------------------------------');
    disp(strcat(" ",prefixFeature1(i)," vs ", prefixFeature2(i)));
    disp(strcat('- Valid corr coeff: ', string(countValidCorrCoeff),...
        '/',string(n_iterations)));
    disp(strcat('- Valid pvalue: ', string(countValidPvalue),...
         '/  ',string(n_iterations)));
    disp('--------------------------------------------------------');
    
    results(i,1) = {strcat(string(countValidCorrCoeff),...
        '/',string(n_iterations))};
    results(i,2) = {strcat(string(countValidPvalue),...
        '/',string(n_iterations))};
    results(i,3) = {median(corrcoeff)};
    results(i,4) = {mean(corrcoeff)};
    results(i,5) = {min(corrcoeff)};
    results(i,6) = {max(corrcoeff)};
end

%writetable(results,"InterSpeciesCorrelation_TestIterations_TS.xls",'WriteRowNames',true);


% Funzione per creare il vettore ottenuto unendo un insieme di feature
% semanticamente legate ma rilevate a profondità diverse
function featureAllDepth = createFeatureAllDepth(dataset)
    subFeature = dataset;
    subFeature = table2array(subFeature);
	featureAllDepth = transpose(reshape(subFeature,1,[]));
end