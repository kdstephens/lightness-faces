function ancillarySubData = GetAncillarySubData(folder)

% ancillarySubData = GetAncillarySubData(folder) 
%
% Collects personal info (age, gender, ethnicity, handedness) for all 
% subjects in a given SubjectData folder. 
%
% Each row of ancillarySubData is a subject. The four columns give 
% age, gender, ethnicity, and handedness respectively

%% Set-up
if nargin < 1
    folder = 'SubData'; 

%MAKE SURE CURRENT DIRECTORY IS 'PostExperiment' folder
addpath(cd); %add the 'PostExperimet' to the top of matlabs search path (i.e., for m-files)
cd .. %I have to up one folder to get to the main directory.
%Working Directory
wd = cd; 
%Data Directory
dataDir = strcat(wd,'/',folder); 
%Folders for individual computers
compFolders = {'Comp01'; 'Comp02'; 'Comp03'; 'Comp05'; 'Comp06'; 'Comp10'};

           
%% Getting Data from the folders and doing work on it
subCnt = 1; %this will keep track of the total number of subjects across all comps for a particular experiment

for i = 1:length(compFolders)
    %Get into a particular computer's folder
    dataSubDir = strcat(dataDir,'/',compFolders{i});
    cd(dataSubDir);
    subDataStruct = dir('*.mat'); 
    
    %Cycle through all subjects in the current folder
    for k = 1:size(subDataStruct,1)
        subDataStr =strvcat(subDataStruct(k).name); 
        load(subDataStr);
        %Now I have a single subject's data -- do work on it.
        ancillarySubData(subCnt,1:4) = subData(1:4,6); % cell2mat(subData(1:4,6));
        
        subCnt = subCnt+1; 
    end
end

cd(strcat(wd,'/','PostExperiment'));
        
        
        
        
        
        
