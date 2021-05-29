% Funzione per dividere un insieme di feature semanticamente correlate in 2
% variabili, ognuna per un diverso range di profondità
function [featureSup,featureDepth] = createFeature2DifferentDepth(dataset, prefixFeature)
    subFeature = dataset;
    subFeature(:,not(strncmp(subFeature.Properties.VariableNames, prefixFeature, length(prefixFeature)))) = [];
    subFeature = table2array(subFeature);
    featureSup = [subFeature(:,1); subFeature(:,2); subFeature(:,3); 
        subFeature(:,4); subFeature(:,5); subFeature(:,6) ];
    
    featureDepth = [subFeature(:,7); subFeature(:,8); subFeature(:,9); 
        subFeature(:,10); subFeature(:,11); subFeature(:,12);
        subFeature(:,13); subFeature(:,14); subFeature(:,15);
        subFeature(:,16)];
        
	featureSup = transpose(reshape(featureSup,1,[]));
   	featureDepth = transpose(reshape(featureDepth,1,[]));
end