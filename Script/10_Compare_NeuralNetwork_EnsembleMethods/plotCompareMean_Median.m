G_ind = G.n_individuals;
S_ind = S.n_individuals;
STG_ind = STG.n_individuals;
T_ind = T.n_individuals;

G_PRED_LSB = G_LSB.predictions;
S_PRED_LSB = S_LSB.predictions;
STG_PRED_LSB = STG_LSB.predictions;
T_PRED_LSB  = T_LSB.predictions;

G_PRED_RF = G_RF.predictions;
S_PRED_RF = S_RF.predictions;
STG_PRED_RF = STG_RF.predictions;
T_PRED_RF  = T_RF.predictions;

G_PRED_NN_2 = Two_Layer_50_sigmoid_G.predictions;
S_PRED_NN_2 = Two_Layer_50_sigmoid_S.predictions;
STG_PRED_NN_2  = Two_Layer_50_sigmoid_STG.predictions;
T_PRED_NN_2  = Two_Layer_50_sigmoid_T.predictions;

G_PRED_NN_3 = Three_Layer_50_sigmoid_G.predictions;
S_PRED_NN_3 = Three_Layer_50_sigmoid_S.predictions;
STG_PRED_NN_3  = Three_Layer_50_sigmoid_STG.predictions;
T_PRED_NN_3 = Three_Layer_50_sigmoid_T.predictions;

[meanG_RF, medianG_RF] = findMeanMedianErrorPredictions(G_ind,G_PRED_RF);
[meanS_RF, medianS_RF] = findMeanMedianErrorPredictions(S_ind,S_PRED_RF);
[meanSTG_RF, medianSTG_RF] = findMeanMedianErrorPredictions(STG_ind,STG_PRED_RF);
[meanT_RF, medianT_RF] = findMeanMedianErrorPredictions(T_ind,T_PRED_RF);

[meanG_LSB, medianG_LSB] = findMeanMedianErrorPredictions(G_ind,G_PRED_LSB);
[meanS_LSB, medianS_LSB] = findMeanMedianErrorPredictions(S_ind,S_PRED_LSB);
[meanSTG_LSB, medianSTG_LSB] = findMeanMedianErrorPredictions(STG_ind,STG_PRED_LSB);
[meanT_LSB, medianT_LSB] = findMeanMedianErrorPredictions(T_ind,T_PRED_LSB);

[meanG_NN_2, medianG_NN_2] = findMeanMedianErrorPredictions(G_ind,G_PRED_NN_2);
[meanS_NN_2, medianS_NN_2] = findMeanMedianErrorPredictions(S_ind,S_PRED_NN_2);
[meanSTG_NN_2, medianSTG_NN_2] = findMeanMedianErrorPredictions(STG_ind,STG_PRED_NN_2);
[meanT_NN_2, medianT_NN_2] = findMeanMedianErrorPredictions(T_ind,T_PRED_NN_2);

[meanG_NN_3, medianG_NN_3] = findMeanMedianErrorPredictions(G_ind,G_PRED_NN_3);
[meanS_NN_3, medianS_NN_3] = findMeanMedianErrorPredictions(S_ind,S_PRED_NN_3);
[meanSTG_NN_3, medianSTG_NN_3] = findMeanMedianErrorPredictions(STG_ind,STG_PRED_NN_3);
[meanT_NN_3, medianT_NN_3] = findMeanMedianErrorPredictions(T_ind,T_PRED_NN_3);

meanTable = [ meanS_LSB meanS_RF meanS_NN_2 meanS_NN_3;
    meanSTG_LSB meanSTG_RF meanSTG_NN_2 meanSTG_NN_3;
    meanG_LSB meanG_RF meanG_NN_2 meanG_NN_3;
    meanT_LSB meanT_RF meanT_NN_2 meanT_NN_3;
];

medianTable = [ medianS_LSB medianS_RF medianS_NN_2 medianS_NN_3;
    medianSTG_LSB medianSTG_RF medianSTG_NN_2 medianSTG_NN_3;
    medianG_LSB medianG_RF medianG_NN_2 medianG_NN_3;
    medianT_LSB medianT_RF medianT_NN_2 medianT_NN_3;
];

plotBarResult(meanTable,"Confronto media predizioni errate tra i modelli di regressione adottati");
figure;
plotBarResult(medianTable,"Confronto mediana predizioni errate tra i modelli di regressione adottati");


function [meanR,medianR] = findMeanMedianErrorPredictions(obs, pred)
    meanR = mean (abs(obs-pred));
    medianR = median (abs(obs-pred));
end

function plotBarResult(table,titleBar)
    bins = categorical({'S','STG','G','T'});
    bins = reordercats(bins,{'S','STG','G','T'});

    bar(bins, table,'BarWidth', 0.4);
    xlabel( "dataset");
    ylabel( "n individui");
    title(titleBar);

    legend("LSBoost","Random Forest","Rete neurale a 2 layers","Rete neurale a 3 layers");
end