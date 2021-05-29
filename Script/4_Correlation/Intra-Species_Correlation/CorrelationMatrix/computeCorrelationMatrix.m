%% Script per calcolare la matrice di correlazione
%  Lo script contiene:
%  computeMatrixCorrelation(), che calcola la matrice di correlazione sul
%  dataset passato in input. Con lo scopo di mantenere solo dati rilevanti,
%  la matrice di correlazione manterrà solo valori di coefficienti che in
%  modulo risultato maggiori di 0.7 e per i quali il p-value è inferiore a
%  0.01 (se serve possiamo portarlo a 0.05). Restituisce
%  - la matrice di correlazione 
%  - la matrice dei pvalue
function [correlationMatrix,pValueMatrix] = computeCorrelationMatrix(dataset,correlationMatrix,pValueMatrix)
    % Determino il numero di feature presenti nel dataset
    numberOfFeature = width(dataset);

    % Calcolo il coefficiente di correlazione di Pearson, memorizzando valore
    % del coefficiente e p-value associato
    for i = 1:numberOfFeature
        for j =1:numberOfFeature
            [R,P]= corrcoef(table2array(dataset(:,i)),table2array(dataset(:,j)));
            if (abs(R(1,2))> 0.7 && (P(1,2) <0.01))
                correlationMatrix(i,j) ={R(1,2)};
                pValueMatrix(i,j) ={P(1,2)};
            end
            %{
            Per creare la matrice di correlazione e la matrice di p-value,
            senza nessun tipo di filtro sul valore del coefficiente e sul
            valore del p-value, sostituire tutto il blocco if - end con le due
            istruzioni riportate di seguito.
            correlationMatrix(i,j) ={R(1,2)};
            pValueMatrix(i,j) ={P(1,2)};
            %}
        end
    end
end