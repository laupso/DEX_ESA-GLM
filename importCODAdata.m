function CODA = importCodaData(file_path)
% Imports data from CODA txt files, and stores it in a data table
%
% INPUT: file_path: path of the *.txt file to import

if nargin == 0
    [file_name,path_name] = uigetfile('*.txt','Select file');
    file_path = fullfile(path_name,file_name);
end
    
[Data,~,nhead] = importdata(file_path);

markerdata = Data.data(:,2:end);
nmarkers = length(markerdata(1,:))/4;
S.time = Data.data(:,1);

headchars = Data.textdata(nhead-1,1);
headchars = headchars{1};
delims1 = strfind(headchars,'.Z')+3;
delims2 = strfind(headchars,'.V')-1;

for i = 1:nmarkers
    ID = headchars(delims1(i):delims2(i));
    S.(strcat('pos_',ID)) = markerdata(:,((i-1)*4+1):(i*4-1));
    visib = markerdata(:,i*4);
    S.(strcat('visib_',ID)) = visib;
    S.(strcat('pos_',ID))(~visib,:) = NaN;
end

CODA = struct2table(S);

end

