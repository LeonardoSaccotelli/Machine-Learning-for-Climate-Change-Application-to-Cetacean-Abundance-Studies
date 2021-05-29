% Recupero i dataset
dataset1 = S;
dataset2 = T;
dataset3 = G;

%[S_Sup_50,T_Sup_50,G_Sup_50,S_100_1000,T_100_1000,G_100_1000] = createTwoSubrange(S,G,T);

[S_Sup_50,T_Sup_50,G_Sup_50,S_100_500,T_100_500,G_100_500,...
    S_600_1000,T_600_1000,G_600_1000] = createThreeSubrange (S,G,T);

function [S_Sup_50,T_Sup_50,G_Sup_50,S_100_1000,T_100_1000,G_100_1000] = createTwoSubrange (S,G,T)
    % Definisco il prefisso delle feature da recuperare
    prefixFeature = 'prim';
    [Primary_Production_Sup_50_S,Primary_Production_100_1000_S] = createFeature2DifferentDepth(S,prefixFeature);
    [Primary_Production_Sup_50_G,Primary_Production_100_1000_G] = createFeature2DifferentDepth(G,prefixFeature);
    [Primary_Production_Sup_50_T,Primary_Production_100_1000_T] = createFeature2DifferentDepth(T,prefixFeature);

    prefixFeature = 'temp';
    [Temperature_Sup_50_S,Temperature_100_1000_S] = createFeature2DifferentDepth(S,prefixFeature);
    [Temperature_Sup_50_G,Temperature_100_1000_G] = createFeature2DifferentDepth(G,prefixFeature);
    [Temperature_Sup_50_T,Temperature_100_1000_T] = createFeature2DifferentDepth(T,prefixFeature);

    prefixFeature = 'dens';
    [Density_Sup_50_S,Density_100_1000_S] = createFeature2DifferentDepth(S,prefixFeature);
    [Density_Sup_50_G,Density_100_1000_G] = createFeature2DifferentDepth(G,prefixFeature);
    [Density_Sup_50_T,Density_100_1000_T] = createFeature2DifferentDepth(T,prefixFeature);

    prefixFeature = 'sal';
    [Salinity_Sup_50_S,Salinity_100_1000_S] = createFeature2DifferentDepth(S,prefixFeature);
    [Salinity_Sup_50_G,Salinity_100_1000_G] = createFeature2DifferentDepth(G,prefixFeature);
    [Salinity_Sup_50_T,Salinity_100_1000_T] = createFeature2DifferentDepth(T,prefixFeature);

    prefixFeature = 'nitr';
    [Nitrate_Sup_50_S,Nitrate_100_1000_S] = createFeature2DifferentDepth(S,prefixFeature);
    [Nitrate_Sup_50_G,Nitrate_100_1000_G] = createFeature2DifferentDepth(G,prefixFeature);
    [Nitrate_Sup_50_T,Nitrate_100_1000_T] = createFeature2DifferentDepth(T,prefixFeature);

    prefixFeature = 'phosp';
    [Phosphate_Sup_50_S,Phosphate_100_1000_S] = createFeature2DifferentDepth(S,prefixFeature);
    [Phosphate_Sup_50_G,Phosphate_100_1000_G] = createFeature2DifferentDepth(G,prefixFeature);
    [Phosphate_Sup_50_T,Phosphate_100_1000_T] = createFeature2DifferentDepth(T,prefixFeature);

    columnName = ["temp_sup_50","density_sup_50","salinity_sup_50","prim_prod_sup_50",...
        "nitrate_sup_50", "phosphate_sup_50"];

    S_Sup_50 = array2table([Temperature_Sup_50_S Density_Sup_50_S Salinity_Sup_50_S ...
                        Primary_Production_Sup_50_S Nitrate_Sup_50_S Phosphate_Sup_50_S]);
    S_Sup_50.Properties.VariableNames(1:6) = columnName;

    T_Sup_50 = array2table([Temperature_Sup_50_T Density_Sup_50_T Salinity_Sup_50_T ...
                        Primary_Production_Sup_50_T Nitrate_Sup_50_T Phosphate_Sup_50_T]);
    T_Sup_50.Properties.VariableNames(1:6) = columnName;

    G_Sup_50 = array2table([Temperature_Sup_50_G Density_Sup_50_G Salinity_Sup_50_G ...
                        Primary_Production_Sup_50_G Nitrate_Sup_50_G Phosphate_Sup_50_G]);
    G_Sup_50.Properties.VariableNames(1:6) = columnName;

    columnName = ["temp_100_1000","density_100_1000","salinity_100_1000","prim_prod_100_1000",...
        "nitrate_100_1000", "phosphate_100_1000"];

    S_100_1000 = array2table([Temperature_100_1000_S Density_100_1000_S Salinity_100_1000_S ...
                        Primary_Production_100_1000_S Nitrate_100_1000_S Phosphate_100_1000_S]);
    S_100_1000.Properties.VariableNames(1:6) = columnName;

    T_100_1000 = array2table([Temperature_100_1000_T Density_100_1000_T Salinity_100_1000_T ...
                        Primary_Production_100_1000_T Nitrate_100_1000_T Phosphate_100_1000_T]);
    T_100_1000.Properties.VariableNames(1:6) = columnName;

    G_100_1000 = array2table([Temperature_100_1000_G Density_100_1000_G Salinity_100_1000_G ...
                        Primary_Production_100_1000_G Nitrate_100_1000_G Phosphate_100_1000_G]);
    G_100_1000.Properties.VariableNames(1:6) = columnName;
end

function [S_Sup_50,T_Sup_50,G_Sup_50,S_100_500,T_100_500,G_100_500,...
    S_600_1000,T_600_1000,G_600_1000] = createThreeSubrange (S,G,T)
   
    % Definisco il prefisso delle feature da recuperare
    prefixFeature = 'prim';
    [Primary_Production_Sup_50_S,Primary_Production_100_500_S,Primary_Production_600_1000_S] = createFeature3DifferentDepth(S,prefixFeature);
    [Primary_Production_Sup_50_G,Primary_Production_100_500_G,Primary_Production_600_1000_G] = createFeature3DifferentDepth(G,prefixFeature);
    [Primary_Production_Sup_50_T,Primary_Production_100_500_T,Primary_Production_600_1000_T] = createFeature3DifferentDepth(T,prefixFeature);

    prefixFeature = 'temp';
    [Temperature_Sup_50_S,Temperature_100_500_S,Temperature_600_1000_S] = createFeature3DifferentDepth(S,prefixFeature);
    [Temperature_Sup_50_G,Temperature_100_500_G,Temperature_600_1000_G] = createFeature3DifferentDepth(G,prefixFeature);
    [Temperature_Sup_50_T,Temperature_100_500_T,Temperature_600_1000_T] = createFeature3DifferentDepth(T,prefixFeature);

    prefixFeature = 'dens';
    [Density_Sup_50_S,Density_100_500_S,Density_600_1000_S] = createFeature3DifferentDepth(S,prefixFeature);
    [Density_Sup_50_G,Density_100_500_G,Density_600_1000_G] = createFeature3DifferentDepth(G,prefixFeature);
    [Density_Sup_50_T,Density_100_500_T,Density_600_1000_T] = createFeature3DifferentDepth(T,prefixFeature);

    prefixFeature = 'sal';
    [Salinity_Sup_50_S,Salinity_100_500_S,Salinity_600_1000_S] = createFeature3DifferentDepth(S,prefixFeature);
    [Salinity_Sup_50_G,Salinity_100_500_G,Salinity_600_1000_G] = createFeature3DifferentDepth(G,prefixFeature);
    [Salinity_Sup_50_T,Salinity_100_500_T,Salinity_600_1000_T] = createFeature3DifferentDepth(T,prefixFeature);

    prefixFeature = 'nitr';
    [Nitrate_Sup_50_S,Nitrate_100_500_S,Nitrate_600_1000_S] = createFeature3DifferentDepth(S,prefixFeature);
    [Nitrate_Sup_50_G,Nitrate_100_500_G,Nitrate_600_1000_G] = createFeature3DifferentDepth(G,prefixFeature);
    [Nitrate_Sup_50_T,Nitrate_100_500_T,Nitrate_600_1000_T] = createFeature3DifferentDepth(T,prefixFeature);

    prefixFeature = 'phosp';
    [Phosphate_Sup_50_S,Phosphate_100_500_S,Phosphate_600_1000_S] = createFeature3DifferentDepth(S,prefixFeature);
    [Phosphate_Sup_50_G,Phosphate_100_500_G,Phosphate_600_1000_G] = createFeature3DifferentDepth(G,prefixFeature);
    [Phosphate_Sup_50_T,Phosphate_100_500_T,Phosphate_600_1000_T] = createFeature3DifferentDepth(T,prefixFeature);

    columnName = ["temp_sup_50","density_sup_50","salinity_sup_50","prim_prod_sup_50",...
        "nitrate_sup_50", "phosphate_sup_50"];

    S_Sup_50 = array2table([Temperature_Sup_50_S Density_Sup_50_S Salinity_Sup_50_S ...
                        Primary_Production_Sup_50_S Nitrate_Sup_50_S Phosphate_Sup_50_S]);
    S_Sup_50.Properties.VariableNames(1:6) = columnName;

    T_Sup_50 = array2table([Temperature_Sup_50_T Density_Sup_50_T Salinity_Sup_50_T ...
                        Primary_Production_Sup_50_T Nitrate_Sup_50_T Phosphate_Sup_50_T]);
    T_Sup_50.Properties.VariableNames(1:6) = columnName;

    G_Sup_50 = array2table([Temperature_Sup_50_G Density_Sup_50_G Salinity_Sup_50_G ...
                        Primary_Production_Sup_50_G Nitrate_Sup_50_G Phosphate_Sup_50_G]);
    G_Sup_50.Properties.VariableNames(1:6) = columnName;

    columnName = ["temp_100_500","density_100_500","salinity_100_500","prim_prod_100_500",...
        "nitrate_100_500", "phosphate_100_500"];

    S_100_500 = array2table([Temperature_100_500_S Density_100_500_S Salinity_100_500_S ...
                        Primary_Production_100_500_S Nitrate_100_500_S Phosphate_100_500_S]);
    S_100_500.Properties.VariableNames(1:6) = columnName;

    T_100_500 = array2table([Temperature_100_500_T Density_100_500_T Salinity_100_500_T ...
                        Primary_Production_100_500_T Nitrate_100_500_T Phosphate_100_500_T]);
    T_100_500.Properties.VariableNames(1:6) = columnName;

    G_100_500 = array2table([Temperature_100_500_G Density_100_500_G Salinity_100_500_G ...
                        Primary_Production_100_500_G Nitrate_100_500_G Phosphate_100_500_G]);
    G_100_500.Properties.VariableNames(1:6) = columnName;
    
    
   columnName = ["temp_600_1000","density_600_1000","salinity_600_1000","prim_prod_600_1000",...
        "nitrate_600_1000", "phosphate_600_1000"];

    S_600_1000 = array2table([Temperature_600_1000_S Density_600_1000_S Salinity_600_1000_S ...
                        Primary_Production_600_1000_S Nitrate_600_1000_S Phosphate_600_1000_S]);
    S_600_1000.Properties.VariableNames(1:6) = columnName;

    T_600_1000 = array2table([Temperature_600_1000_T Density_600_1000_T Salinity_600_1000_T ...
                        Primary_Production_600_1000_T Nitrate_600_1000_T Phosphate_600_1000_T]);
    T_600_1000.Properties.VariableNames(1:6) = columnName;

    G_600_1000 = array2table([Temperature_600_1000_G Density_600_1000_G Salinity_600_1000_G ...
                        Primary_Production_600_1000_G Nitrate_600_1000_G Phosphate_600_1000_G]);
    G_600_1000.Properties.VariableNames(1:6) = columnName;
   
end