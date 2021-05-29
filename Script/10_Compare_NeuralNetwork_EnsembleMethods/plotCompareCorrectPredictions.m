%% Lo script permette di confrontare il numero di predizioni corrette
%  per ogni dataset e per ogni modello di regressione adottato.

% Seleziono il numero di individui dai dataset
G_ind = G.n_individuals;
S_ind = S.n_individuals;
STG_ind = STG.n_individuals;
T_ind = T.n_individuals;

% Recupero le predizioni tramite LSBoost
G_PRED_LSB = G_LSB.predictions;
S_PRED_LSB = S_LSB.predictions;
STG_PRED_LSB = STG_LSB.predictions;
T_PRED_LSB  = T_LSB.predictions;

% Recupero le predizioni tramite Random Forest
G_PRED_RF = G_RF.predictions;
S_PRED_RF = S_RF.predictions;
STG_PRED_RF = STG_RF.predictions;
T_PRED_RF  = T_RF.predictions;

% Recupero le predizioni tramite Neural Network a 2 layers
G_PRED_NN_2 = Two_Layer_50_sigmoid_G.predictions;
S_PRED_NN_2 = Two_Layer_50_sigmoid_S.predictions;
STG_PRED_NN_2  = Two_Layer_50_sigmoid_STG.predictions;
T_PRED_NN_2  = Two_Layer_50_sigmoid_T.predictions;

% Recupero le predizioni tramite Neural Network a 3 layers
G_PRED_NN_3 = Three_Layer_50_sigmoid_G.predictions;
S_PRED_NN_3 = Three_Layer_50_sigmoid_S.predictions;
STG_PRED_NN_3  = Three_Layer_50_sigmoid_STG.predictions;
T_PRED_NN_3 = Three_Layer_50_sigmoid_T.predictions;

% calcolo le predizioni corrette
[correct_pred_G_RF] = findCorrectPredictions(G_ind,G_PRED_RF);
[correct_pred_S_RF] = findCorrectPredictions(S_ind,S_PRED_RF);
[correct_pred_STG_RF] = findCorrectPredictions(STG_ind,STG_PRED_RF);
[correct_pred_T_RF] = findCorrectPredictions(T_ind,T_PRED_RF);

[correct_pred_G_LSB] = findCorrectPredictions(G_ind,G_PRED_LSB);
[correct_pred_S_LSB] = findCorrectPredictions(S_ind,S_PRED_LSB);
[correct_pred_STG_LSB] = findCorrectPredictions(STG_ind,STG_PRED_LSB);
[correct_pred_T_LSB] = findCorrectPredictions(T_ind,T_PRED_LSB);

[correct_pred_G_NN_2] = findCorrectPredictions(G_ind,G_PRED_NN_2);
[correct_pred_S_NN_2] = findCorrectPredictions(S_ind,S_PRED_NN_2);
[correct_pred_STG_NN_2] = findCorrectPredictions(STG_ind,STG_PRED_NN_2);
[correct_pred_T_NN_2] = findCorrectPredictions(T_ind,T_PRED_NN_2);

[correct_pred_G_NN_3] = findCorrectPredictions(G_ind,G_PRED_NN_3);
[correct_pred_S_NN_3] = findCorrectPredictions(S_ind,S_PRED_NN_3);
[correct_pred_STG_NN_3] = findCorrectPredictions(STG_ind,STG_PRED_NN_3);
[correct_pred_T_NN_3] = findCorrectPredictions(T_ind,T_PRED_NN_3);

% creo la tabella con i risultati
correct_pred_Table = [ correct_pred_S_LSB correct_pred_S_RF correct_pred_S_NN_2 correct_pred_S_NN_3;
    correct_pred_STG_LSB correct_pred_STG_RF correct_pred_STG_NN_2 correct_pred_STG_NN_3;
    correct_pred_G_LSB correct_pred_G_RF correct_pred_G_NN_2 correct_pred_G_NN_3;
    correct_pred_T_LSB correct_pred_T_RF correct_pred_T_NN_2 correct_pred_T_NN_3;
];

% creo il grafico con i risultati
plotBarResult(correct_pred_Table);

function totalCorrectPredictions = findCorrectPredictions(obs, pred)
    minRangeObs = obs - 5;
    maxRangeObs = obs + 5;
    predictions = pred >= minRangeObs & pred <= maxRangeObs;
    totalCorrectPredictions = sum(predictions)*100/height(obs);
end

function plotBarResult(table)
    bins = categorical({'S','STG','G','T'});
    bins = reordercats(bins,{'S','STG','G','T'});

    b = bar(bins, table,'BarWidth', 0.5);
    xlabel( "dataset");
    ylabel( "% predizioni corrette");
    title("Confronto predizioni corrette tra i modelli adottati");
    ylim([1 100]);
    
    legend("LSBoost","Random Forest","Rete neurale a 2 layers","Rete neurale a 3 layers");
end


