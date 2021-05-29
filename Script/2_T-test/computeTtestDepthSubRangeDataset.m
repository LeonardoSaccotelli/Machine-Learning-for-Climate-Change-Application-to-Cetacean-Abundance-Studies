%% Script per l'esecuzione del t-test per confrontare la media della 
% distribuzione di pacchetti di feature per ogni coppia di specie a disposizione


% Ttest su 2 subrange di feature
% Eseguo il ttest sul dataset G e S
ttest_G_S_2 = computeLeftRightTtestTwoSubrange(G_Sup_50,G_100_1000,S_Sup_50,S_100_1000);

% Eseguo il ttest sul dataset G e T
ttest_G_T_2 = computeLeftRightTtestTwoSubrange(G_Sup_50,G_100_1000,T_Sup_50,T_100_1000);

% Eseguo il ttest sul dataset T e S
ttest_T_S_2 = computeLeftRightTtestTwoSubrange(T_Sup_50,S_100_1000,S_Sup_50,S_100_1000);
% Salvo i risultati
writetable(ttest_G_S_2,"ttestGS_2subrange.xlsx",'WriteRowNames',true);
writetable(ttest_G_T_2,"ttestGT_2subrange.xlsx",'WriteRowNames',true);
writetable(ttest_T_S_2,"ttestTS_2subrange.xlsx",'WriteRowNames',true);

% Ttest su 3 subrange di feature
ttest_G_S_3 = computeLeftRightTtestThreeSubrange(G_Sup_50,G_100_500,G_600_1000,...
    S_Sup_50,S_100_500,S_600_1000);

% Eseguo il ttest sul dataset G e T
ttest_G_T_3 = computeLeftRightTtestThreeSubrange(G_Sup_50,G_100_500,G_600_1000,...
    T_Sup_50,T_100_500,T_600_1000);

% Eseguo il ttest sul dataset T e S
ttest_T_S_3 = computeLeftRightTtestThreeSubrange(T_Sup_50,T_100_500,T_600_1000,...
    S_Sup_50,S_100_500,S_600_1000);

% Salvo i risultati
writetable(ttest_G_S_3,"ttestGS_3subrange.xlsx",'WriteRowNames',true);
writetable(ttest_G_T_3,"ttestGT_3subrange.xlsx",'WriteRowNames',true);
writetable(ttest_T_S_3,"ttestTS_3subrange.xlsx",'WriteRowNames',true);




% La funzione esegue il ttest sinistro e destro per ogni feature
% presente nel dataset. Si suppone che i due dataset abbiamo le stesse
% feature.
function ttestResults = computeLeftRightTtestTwoSubrange(dataset1_Sup,dataset1_Depth, dataset2_Sup,dataset2_Depth)   
    numberOfFeature = 2*width(dataset1_Sup);
    rownames = ["temp_sup_50","temp_100_1000","density_sup_50","density_100_1000",...
        "salinity_sup_50","salinity_100_1000","prim_prod_sup_50",...
    "prim_prod_100_1000","nitrate_sup_50","nitrate_100_1000", "phosphate_sup_50" ,"phosphate_100_1000"];
    
    % Creo la tabella che conterrà i risultati
    ttestResults = table('Size', [numberOfFeature 5], ...
        'VariableTypes', {'double','double','double','double','string'},...
        'VariableNames', ...
        {'result left t-test','p_value left t-test',...
        'result right t-test','p_value right t-test','result_test'},...
        'RowNames', rownames);
    
    j = 1;
    for i = 1:2:numberOfFeature
        
        % Eseguo il ttest sui dati sup_50
        x = table2array(dataset1_Sup(:,j));
        y = table2array(dataset2_Sup(:,j));
        [left_Ttest_Result,left_Ttest_pvalue,right_Ttest_Result,...
            right_Ttest_pvalue,stringResultLR] = computeTtest(x,y);

        ttestResults(i,1) = {left_Ttest_Result};
        ttestResults(i,2) = {left_Ttest_pvalue};
        ttestResults(i,3) = {right_Ttest_Result};
        ttestResults(i,4) = {right_Ttest_pvalue};
        ttestResults(i,5) = {stringResultLR};
        
        % Eseguo il ttest sui dati 100_1000
        x = table2array(dataset1_Depth(:,j));
        y = table2array(dataset2_Depth(:,j));
        [left_Ttest_Result,left_Ttest_pvalue,right_Ttest_Result,...
            right_Ttest_pvalue,stringResultLR] = computeTtest(x,y);
        
        ttestResults(i+1,1) = {left_Ttest_Result};
        ttestResults(i+1,2) = {left_Ttest_pvalue};
        ttestResults(i+1,3) = {right_Ttest_Result};
        ttestResults(i+1,4) = {right_Ttest_pvalue};
        ttestResults(i+1,5) = {stringResultLR};
        j = j+1;
    end
end

function [left_Ttest_Result,left_Ttest_pvalue,right_Ttest_Result,right_Ttest_pvalue,stringResultLR]...
    = computeTtest(x,y)

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
end
          

% La funzione esegue il ttest sinistro e destro per ogni feature
% presente nel dataset. Si suppone che i due dataset abbiamo le stesse
% feature.
function ttestResults = computeLeftRightTtestThreeSubrange(...
    dataset1_Sup,dataset1_Med,dataset1_depth,...
    dataset2_Sup,dataset2_Med,dataset2_depth)   

    numberOfFeature = 3*width(dataset1_Sup);
    
    rownames = ["temp_sup_50","temp_100_500","temp_600_1000",...
        "density_sup_50","density_100_500","density_600_1000"...
        "salinity_sup_50","salinity_100_500","salinity_600_1000",...
        "prim_prod_sup_50","prim_prod_100_500","prim_prod_600_1000",...
        "nitrate_sup_50","nitrate_100_500","nitrate_600_1000",...
        "phosphate_sup_50" ,"phosphate_100_500","phosphate_600_1000"];
    
    % Creo la tabella che conterrà i risultati
    ttestResults = table('Size', [numberOfFeature 5], ...
        'VariableTypes', {'double','double','double','double','string'},...
        'VariableNames', ...
        {'result left t-test','p_value left t-test',...
        'result right t-test','p_value right t-test','result_test'},...
        'RowNames', rownames);
    
    j = 1;
    for i = 1:3:numberOfFeature
        
        % Eseguo il ttest sui dati sup_50
        x = table2array(dataset1_Sup(:,j));
        y = table2array(dataset2_Sup(:,j));
        [left_Ttest_Result,left_Ttest_pvalue,right_Ttest_Result,...
            right_Ttest_pvalue,stringResultLR] = computeTtest(x,y);

        ttestResults(i,1) = {left_Ttest_Result};
        ttestResults(i,2) = {left_Ttest_pvalue};
        ttestResults(i,3) = {right_Ttest_Result};
        ttestResults(i,4) = {right_Ttest_pvalue};
        ttestResults(i,5) = {stringResultLR};
        
        % Eseguo il ttest sui dati 100_500
        x = table2array(dataset1_Med(:,j));
        y = table2array(dataset2_Med(:,j));
        [left_Ttest_Result,left_Ttest_pvalue,right_Ttest_Result,...
            right_Ttest_pvalue,stringResultLR] = computeTtest(x,y);
        
        ttestResults(i+1,1) = {left_Ttest_Result};
        ttestResults(i+1,2) = {left_Ttest_pvalue};
        ttestResults(i+1,3) = {right_Ttest_Result};
        ttestResults(i+1,4) = {right_Ttest_pvalue};
        ttestResults(i+1,5) = {stringResultLR};
        
        % Eseguo il ttest sui dati 600_1000
        x = table2array(dataset1_depth(:,j));
        y = table2array(dataset2_depth(:,j));
        [left_Ttest_Result,left_Ttest_pvalue,right_Ttest_Result,...
            right_Ttest_pvalue,stringResultLR] = computeTtest(x,y);
        
        ttestResults(i+2,1) = {left_Ttest_Result};
        ttestResults(i+2,2) = {left_Ttest_pvalue};
        ttestResults(i+2,3) = {right_Ttest_Result};
        ttestResults(i+2,4) = {right_Ttest_pvalue};
        ttestResults(i+2,5) = {stringResultLR};
        j = j+1;
    end
end