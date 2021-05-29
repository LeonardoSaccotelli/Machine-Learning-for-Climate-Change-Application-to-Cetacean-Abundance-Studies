%% Lo script permette di creare un grafico che rapporta
%  il numero di individui con il numero di osservazioni.
%  Dato un dataset contenente osservazioni e predizioni,
%  le osservazioni vengono divise in range nella forma [x-10, x],
%  riportate sull'asse delle ascisse; sull'asse delle ordinate sono
%  riportate le osservazioni. Per ogni intervallo vengono plottate
%  le osservazioni, le predizioni minori, corrette e maggiori.

dataset = STG;
model = Three_Layer_50_sigmoid_STG;
datasetName = "STG";
regressionModelName = '3 Layers Neural Network';

compare = table(dataset.n_individuals, model.predictions,...
    'VariableNames',{'observations','predictions'});

% Selezioni il dataset
dataset = compare;
numberOfRows = height(dataset);

% Inizializzo i vettori delle osservazioni e delle predizioni
observations = zeros(10,1);
correctPredictions = zeros(10,1);
infPredictions = zeros(10,1);
supPredictions = zeros(10,1);
maxNumberOfIndividuals = max(dataset.observations);

for i = 10:10:maxNumberOfIndividuals
    j = 1;
    index = i/10;
    while(dataset.observations(j) <= i)
	
		% Determino il range per le predizioni corrette
        minRangeCorrectPredictions = dataset.observations(j)-5;
        maxRangeCorrectPredictions = dataset.observations(j)+5;
        observations(index) = observations(index) + 1;
        
		% Predizione < (Osservazioni - 5) --> Predizione minore
        if (dataset.predictions(j) < minRangeCorrectPredictions)
            infPredictions(index) = infPredictions(index) +1;
            fprintf(strcat("min_range: ",string(minRangeCorrectPredictions),...
                " predictions: ",string(dataset.predictions(j)),"\n"));
         
		% Predizione >= Osservazioni - 5) 
		%	&& Predizione <= Osservazioni + 5) --> Predizione corretta
			
        elseif((dataset.predictions(j) >= minRangeCorrectPredictions) &&...
               (dataset.predictions(j)<= maxRangeCorrectPredictions))
            correctPredictions(index) = correctPredictions(index)+1;
            fprintf(strcat("min_range: ",string(minRangeCorrectPredictions),...
                " predictions: ",string(dataset.predictions(j)),...
                " max_range: ", string(maxRangeCorrectPredictions),"\n"));
        
		% Predizione > (Osservazioni + 5) --> Predizione maggiore
        elseif(dataset.predictions(j)> maxRangeCorrectPredictions)
            supPredictions(index) = supPredictions(index)+1;  
            fprintf(strcat("max_range: ",string(maxRangeCorrectPredictions),...
                " predictions: ",string(dataset.predictions(j)),"\n"));
        end
        
        j = j+1;
        
        if(j > height(dataset))
            break;
        end
        
    end
     
    dataset(dataset.observations<=i ,:) = [];
end

totalObservationForBins = infPredictions + correctPredictions + supPredictions;

% Converto in percentuale
infPredictions = (infPredictions .* 100)./ totalObservationForBins;
correctPredictions = (correctPredictions .* 100)./ totalObservationForBins;
supPredictions = (supPredictions .* 100)./ totalObservationForBins;

% Azzero i valori NAN
infPredictions(isnan(infPredictions))=0;
correctPredictions(isnan(correctPredictions))=0;
supPredictions(isnan(supPredictions))=0;

% Raggruppo i risultati in una tabella
bins = categorical([10 20 30 40 50 60 70 80 90 100]);
tableResult = [infPredictions correctPredictions supPredictions];

% Creo il grafico con i risultati
plotBar = bar(bins, tableResult,'stacked','FaceColor','flat','BarWidth', 0.4);
xlabel( "n individui");
ylabel( "n osservazioni (%)");
title(strcat(regressionModelName," - ",datasetName));

for k = 1:size(tableResult,2)
  plotBar(k).CData = k;
end

ylim([0 105]);
legend("Predizioni minori","Predizioni corrette","Predizioni maggiori", 'Location', 'Best');