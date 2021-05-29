%% Lo script permette di confrontare l'RMSE
%  per ogni dataset e per ogni modello di regressione adottato.

% Recupero per ogni dataset e modello, il relativo RMSE
G_RMSE_LSB = G.rmse;
S_RMSE_LSB = S.rmse;
STG_RMSE_LSB = STG.rmse;
T_RMSE_LSB  = T.rmse;

G_RMSE_RF = G.rmse;
S_RMSE_RF = S.rmse;
STG_RMSE_RF = STG.rmse;
T_RMSE_RF  = T.rmse;

G_RMSE_NN_2 = Two_Layer_50_sigmoid_G.rmse;
S_RMSE_NN_2 = Two_Layer_50_sigmoid_S.rmse;
STG_RMSE_NN_2  = Two_Layer_50_sigmoid_STG.rmse;
T_RMSE_NN_2  = Two_Layer_50_sigmoid_T.rmse;

G_RMSE_NN_3 = Three_Layer_50_sigmoid_G.rmse;
S_RMSE_NN_3 = Three_Layer_50_sigmoid_S.rmse;
STG_RMSE_NN_3  = Three_Layer_50_sigmoid_STG.rmse;
T_RMSE_NN_3 = Three_Layer_50_sigmoid_T.rmse;

% Creo la tabella con i risultati
result = [  S_RMSE_LSB S_RMSE_RF S_RMSE_NN_2 S_RMSE_NN_3;...
            STG_RMSE_LSB STG_RMSE_RF STG_RMSE_NN_2 STG_RMSE_NN_3;...
            G_RMSE_LSB G_RMSE_RF G_RMSE_NN_2 G_RMSE_NN_3;...
            T_RMSE_LSB T_RMSE_RF T_RMSE_NN_2 T_RMSE_NN_3];

bins = categorical({'S','STG','G','T'});
bins = reordercats(bins,{'S','STG','G','T'});

plotBar = bar(bins, result,'BarWidth', 0.4);
xlabel( "dataset");
ylabel( "RMSE");
title("Confronto RMSE tra reti neurali e metodi ensemble");

legend("LSBoost","Random Forest","Rete neurale a 2 layers","Rete neurale a 3 layers");
