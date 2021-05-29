%% Script per stampare le mappe di distribuzione dei cetacei
%  COME USARLO:
%  1) Caricare uno o più dataset, in base alle esigenze
%  2) Passare alla funzione retriveGPSCoord() il nome del 
%     dataset da cui si vuole estrapolare le coordinate GPS
%  3) Assicursi che il dataset contenga i campi 'lat' e 'lon'

% Recupero la latidutide e la longitudine
% di ogni specie oggetta di analisi
[Glat,Glon] = retriveGPSCoord(G);
[Slat,Slon] = retriveGPSCoord(S);
[Tlat,Tlon] = retriveGPSCoord(T);

% Stampo la mappa che mostra la distribuzione di diverse
% specie di cetacei nel Golfo di Taranto
geoscatter(Glat,Glon,'b');
hold on
geoscatter(Slat,Slon,'+');
geoscatter(Tlat,Tlon,'^');
title('Distribuzione cetacei nel Golfo di Taranto');
legend('Grampus','Stenella','Tursiope');
geobasemap topographic


function [lat,lon] = retriveGPSCoord (dataset)
    lat = dataset.lat;
    lon = dataset.lon;
end
