%% Script per calcolare la regressione su singoli pacchetti di feature.
%  Ogni pacchetto è costruito usando solo le stesse feature misurate a 
%  tutte le profondità, es: nitrate --> pacchetto contenente tutte le feature
%  relative ai nitrati misurate a varie profondità.
%  Il dataset è composto dal numero di individui e un singolo pacchetto. Di 
%  volta in volta il modello viene riaddestrato su un nuovo pacchetto e i risultati
%  vengono memorizzati.
%  COME USARLO:
%  1) Sostituire il dataset nella variabile 'dataset'
%  2) Sostituire il nome del dataset nella variabile 'datasetName'

% Seleziono il dataset 
dataset = G;
datasetName = "G";

% Definisco i nomi dei pacchetti
packageFeature = ["gps" "temp" "dens" "sal" "chl_a" "prim" "nitr" "phosp"];

% Creo la tabella che conterrà i risultati
result = table('Size', [8 2], 'VariableTypes',...
        {'double','double'}, 'VariableNames', {'2NN','3NN'},...
        'RowNames',packageFeature);
    
for i = 1:8
    	
	% Per ogni nuovo pacchetto, rimuovo dal dataset le feature che non appartengono
	% all'i-esimo pacchetto
    oldDataset = dataset;
    reduceDataset = reduceDatasetByPackageFeature(oldDataset,packageFeature(i));
    
    fprintf("-----------------------------------------------------\n");
    fprintf(strcat(" Package ... ",packageFeature(i)));
    
	% Applico la rete neurale a due layers e memorizzo l'RMSE
    [~,validationRMSE,validationPredictions] = TwoLayerNeuralNetwork(dataset);
    result(i,1) = {validationRMSE};
    fprintf(strcat("\nNegative pred ", string(sum(validationPredictions<0)),"\n"));

	% Applico la rete neurale a tre layers e memorizzo l'RMSE
    [~,validationRMSE,validationPredictions] = TwoLayerNeuralNetwork(dataset);
    result(i,2) = {validationRMSE};

    fprintf(strcat("\nNegative pred ", string(sum(validationPredictions<0)),"\n"));
    fprintf ("\n-----------------------------------------------------\n");

end
% Salvo i risultati
writetable(result,strcat(datasetName,"_neural_network_package_feature",".xlsx"),'WriteRowNames',true);



% Funzione per mantenere solo le feature appartenenti ad un certo pacchetto
function reducedDataset = reduceDatasetByPackageFeature(oldDataset,prefixFeature)
       
    featureToPackage = oldDataset;
    
	% Se il pacchetto è 'gps' mantengo latitudine e longitudine
    if(strncmp("gps",prefixFeature,strlength(prefixFeature)))
        featureToPackage(:,not(strncmp(featureToPackage.Properties.VariableNames, "lat",...
            strlength("lat"))) & not(strncmp(featureToPackage.Properties.VariableNames, "lon",...
            strlength("lon")))) = [];
    else 
	% altrimenti mantengo tutte le feature che contengono 'prefixFeature' nel nome 
        featureToPackage =  oldDataset(:,strncmp(oldDataset.Properties.VariableNames, prefixFeature,...
            strlength(prefixFeature)));
    end
	
    oldDataset(:,not(strncmp(oldDataset.Properties.VariableNames, "n_individuals",...
        strlength("n_individuals")))) = [];
    
	% combino la feature 'n_individuals' con il pacchetto creato
    reducedDataset = [oldDataset featureToPackage];
end
