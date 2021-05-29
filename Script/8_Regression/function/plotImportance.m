% Script usato per realizzare un grafico a barre
% che permette di confrontare l'importanza data 
% ad ogni feature da parte del modello di regressione.

function plotImportance (feature_importance,nameDataset)
	sortedFeatureImportance = sortrows(feature_importance,'score','descend');
	sortedFeatureImportance = sortedFeatureImportance(1:10,:);
	
    titles = categorical(sortedFeatureImportance.Properties.RowNames);
    titles = reordercats(titles,sortedFeatureImportance.Properties.RowNames);

	bar(titles,sortedFeatureImportance.score);

	title(nameDataset);
	set(gca,'TickLabelInterpreter','none');
end

	