% Exemple de script permettant d'importer les donn�es d'un fichier .glm et
% de plotter quelques signaux.
% Le script importe les donn�es du fichier dans une table de donn�es (T).
% Pour plus d'info sur l'utilisation des tables en Matlab:
%   "https://nl.mathworks.com/help/matlab/ref/table.html"
%
%
% ++ LO 2019 ++

% Chemin d'acc�s au fichier (A MODIFIER):
filepath = '.\test.glm';

% Importer les donn�es et les stocker dans une table de donn�es:
T = importGLMdata(filepath);

% Afficher le nom des diff�rentes variables dans la Command Window:
for i = 1:length(T.Properties.VariableNames)
    disp(T.Properties.VariableNames{i});
end

% Mise � z�ro des forces en soustrayant la valeur moyenne des signaux des
% 500 prem�res ms. 
baseline = 1:400; 
GF  = T.GF - nanmean(T.GF(baseline),1);
LFt = T.LFt - nanmean(T.LFt(baseline),1);
LFv = -(T.LFv - nanmean(T.LFv(baseline,:),1));

% Conversion de l'acc�l�ration de 'g' � m/s^2
% Note: l'acc�l�rom�tre mesure aussi l'acc�l�ration gravitationnelle ! D'o�
% l'offset d'environ 1g (= 9.81 m/s^2) 
acc = -9.81*T.LowAcc_X;  


% Plot de l'acc�l�ration verticale, LF verticale, LF totale et GF
F = figure;

subplot(311); hold on; grid on; box on;
plot(T.time,acc,'k');
ylabel('Acc�l�ration [m/s^2]');
title('Exemple de trac�s d''acc�l�ration et de forces');

subplot(312); hold on; grid on; box on;
plot(T.time,LFv,'k');
ylabel('LF_v [N]');

subplot(313); hold on; grid on; box on;
plot(T.time,LFt,'k');
plot(T.time,GF,'r');
ylabel('Forces [N]');
L = legend('LF_t','GF');
set(L,'location','best');


