%% Script per l'esecuzione del t-test per confrontare la media della 
% distribuzione di ogni feature per ogni coppia di specie a disposizione

% Rimuovo la feature species non utilizzata per il calcolo del
% t-test sinistro e destro.
G.species = [];
S.species = [];
T.species = [];

% Eseguo il ttest sul dataset G e S
ttest_G_S = computeLeftRightTtest(G,S);

% Eseguo il ttest sul dataset G e T
ttest_G_T = computeLeftRightTtest(G,T);

% Eseguo il ttest sul dataset T e S
ttest_T_S = computeLeftRightTtest(T,S);

% Salvo i risultati
writetable(ttest_G_S,"ttestGS.xls",'WriteRowNames',true);
writetable(ttest_G_T,"ttestGT.xls",'WriteRowNames',true);
writetable(ttest_T_S,"ttestTS.xls",'WriteRowNames',true);

% La funzione esegue il ttest sinistro e destro per ogni feature
% presente nel dataset. Si suppone che i due dataset abbiamo le stesse
% feature.
function ttestResults = computeLeftRightTtest(dataset1, dataset2)   
    numberOfFeature = width(dataset1);
    
    % Creo la tabella che conterrà i risultati
    ttestResults = table('Size', [numberOfFeature 5], 'VariableTypes', {'double','double','double','double','string'},...
        'VariableNames', {'result left t-test','p_value left t-test','result right t-test','p_value right t-test','result_test'},...
        'RowNames', dataset1.Properties.VariableNames);

    for i = 1:numberOfFeature
        x = table2array(dataset1(:,i));
        y = table2array(dataset2(:,i));
        
        [left_Ttest_Result,left_Ttest_pvalue] = ttest2(x, y, 'Tail','left','Alpha',0.05 );
        [right_Ttest_Result,right_Ttest_pvalue] = ttest2(x, y, 'Tail','right','Alpha',0.05 );
                        
        if left_Ttest_Result == 1 && right_Ttest_Result == 0
            stringResultLR = 'x < y';
            % x < y
        elseif left_Ttest_Result == 0 && right_Ttest_Result == 1
            % x > y
            stringResultLR = 'x > y';
        else
            % non disponibile
            stringResultLR = 'nd';
        end
        
        ttestResults(i,1) = {left_Ttest_Result};
        ttestResults(i,2) = {left_Ttest_pvalue};
        ttestResults(i,3) = {right_Ttest_Result};
        ttestResults(i,4) = {right_Ttest_pvalue};
        ttestResults(i,5) = {stringResultLR};

    end
end