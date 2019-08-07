% Exemple de script permettant d'importer les données d'un fichier .glm et
% de plotter quelques signaux.
% Le script importe les données du fichier dans une table de données (T).
% Pour plus d'info sur l'utilisation des tables en Matlab:
%   "https://nl.mathworks.com/help/matlab/ref/table.html"
%
%
% ++ LO 2019 ++

% Chemin d'accès au fichier (A MODIFIER):
filepath = '.\test.glm';

% Importer les données et les stocker dans une table de données:
T = importGLMdata(filepath);

% Afficher le nom des différentes variables dans la Command Window:
for i = 1:length(T.Properties.VariableNames)
    disp(T.Properties.VariableNames{i});
end

% Mise à zéro des forces en soustrayant la valeur moyenne des signaux des
% 500 premères ms. 
baseline = 1:400; 
GF  = T.GF - nanmean(T.GF(baseline),1);
LFt = T.LFt - nanmean(T.LFt(baseline),1);
LFv = -(T.LFv - nanmean(T.LFv(baseline,:),1));

% Conversion de l'accélération de 'g' à m/s^2
% Note: l'accéléromètre mesure aussi l'accélération gravitationnelle ! D'où
% l'offset d'environ 1g (= 9.81 m/s^2) 
acc = -9.81*T.LowAcc_X;  


% Plot de l'accélération verticale, LF verticale, LF totale et GF
F = figure;

subplot(311); hold on; grid on; box on;
plot(T.time,acc,'k');
ylabel('Accélération [m/s^2]');
title('Exemple de tracés d''accélération et de forces');

subplot(312); hold on; grid on; box on;
plot(T.time,LFv,'k');
ylabel('LF_v [N]');

subplot(313); hold on; grid on; box on;
plot(T.time,LFt,'k');
plot(T.time,GF,'r');
ylabel('Forces [N]');
L = legend('LF_t','GF');
set(L,'location','best');


