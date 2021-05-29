% Funzione per realizzare un grafico che permette di
% confrontare i risultati di un generico modello di 
% regressione. Per poterlo utilizzare è sufficiente
% passare come parametri un vettore contenente i 
% valori osservati (vo) e un vettore contenente idx
% valori predetti (vp) dal modello di regressione.
% il nome del dataset usato per la previsione (datasetName)
% l'RMSE per il modello realizzato

function [] = plotPredictions(vo,vp,datasetName,rmse)
% vo: values observed
% vp: values predicted

idx = 1 : size(vo,1);
idx_correct = idx(vp==vo);
idx_higher = idx(vp>vo);
idx_lower = idx(vp<vo);

hold on
plot(idx_correct,vp(idx_correct),'+','Color',[0.5 0.7 0.2])
plot(idx_higher,vp(idx_higher),'+','Color',[0.9 0.5 0.5])
plot(idx_lower,vp(idx_lower),'+','Color',[0.9 0.9 0.6])

for i = 1 : size(idx_higher,2)
    line([idx_higher(i), idx_higher(i)], [vp(idx_higher(i)), vo(idx_higher(i))], 'Color', [0.9 0.5 0.5]);
end
for i = 1 : size(idx_lower,2)
    line([idx_lower(i), idx_lower(i)], [vp(idx_lower(i)), vo(idx_lower(i))], 'Color', [0.9 0.9 0.6]);
end

plot(vo,'bo','Color',[0 0.5 0.7])

h = zeros(4, 1);
h(1) = plot(NaN,NaN,'+','Color',[0.5 0.7 0.2]);
h(2) = plot(NaN,NaN,'+','Color',[0.9 0.5 0.5]);
h(3) = plot(NaN,NaN,'+','Color',[0.9 0.9 0.6]);
h(4) = plot(NaN,NaN,'bo','Color',[0 0.5 0.7]);
%lgd = legend(h,'Correct predictions','Higher predictions','Lower predictions','Observations');
lgd = legend(h,'Predizioni corrette','Predizioni maggiori','Predizioni minori','Osservazioni');
lgd.Location = 'northwest';
%xlabel('Observations');
xlabel('Osservazioni');
%ylabel('n individuals');
ylabel('n individui');
title(strcat(datasetName," - RMSE ", string(rmse)));
hold off
end

