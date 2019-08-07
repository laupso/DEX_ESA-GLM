function GLM = importGLMdata(file_path)
%IMPORTGLMDATA imports data from a GLM file, and stores it in a 
%data table
%
%   GLM = importGLMdata()
%   GLM = importGLMdata(file_path)
%
% INPUT (facultative): 
%   -file_path: path of the file to be imported (*.glm extension)
%
% OUTPUT:
%   - GLM: data table with all variables of the GLM file, except: NA,
%   <reserved>. Variable names are modified to make them valid variable
%   names: units and interspaces are removed, '/' and '-' are replaced by
%   '_'.
%
% ++ LO 2018 ++

if nargin == 0
    [file_name,path_name] = uigetfile({'*.glm;*.txt'},'Select file');
    if file_name==0
        return;
    end
    file_path = fullfile(path_name,file_name);
end

% Load data
datac = importdata(file_path);
data = datac.data;

% Get all variable names from textdata
varNames = datac.textdata{1};
iVarNames = regexp(varNames,'\t');
varNamesSep = cell(1,length(iVarNames));
u = 1;

for i = 1:length(iVarNames)
    var = varNames(u:iVarNames(i)-1);
    
    % Get rid of the units
    i_unit = regexp(var,'\s');    
    if ~isempty(i_unit)
        var = var(1:i_unit(1)-1);
    end    
    
    % Replace '/' and '-' characters by underscores
    var = regexprep(var,'/','_');
    var = regexprep(var,'-','_');  
    
    varNamesSep{i} = var;
    u = iVarNames(i)+1;
end


% Store all variables in a data structure (except NA)
DS = struct;

for i = 1:length(varNamesSep)
    
    if ~strcmpi(varNamesSep{i},'NA') && ~strcmpi(varNamesSep{i},'file') && ...
            ~contains(varNamesSep{i},'DO:') && ~isempty(varNamesSep{i}) &&...
            ~strcmpi(varNamesSep{i},'<reserved>')
        
        DS.(varNamesSep{i}) = data(:,i);
    end
end
        
        
% Convert to table
GLM = struct2table(DS);

end

