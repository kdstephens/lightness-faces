function [subDataMat_t1, subDataMat_t2, nGroup1Subs, nGroup2Subs, RTs] = GetData

% [subDataMat_t1, subDataMat_t2, nGroup1Subs, nGroup2Subs, RTs] = GetData_MLF0
%
% Returns a matrix where the rows are subjects and the columns are each of
% the faces that subject saw. Each entry in the matrix has either
% a 1 or a 0 (1 = Caucasian; 0 = African-American).
% 
% There are two matrices because each subject ran through the experiment
% twice, i.e., they saw the same faces in the same order twice through).
% Thus, the first matrix gives their responses the first time through and
% the second matrix gives the responses the second time through. 
% 
% RTs gives the average (col 1), SD (col 2), and avg/SD (col 3) of reaction
% times for each subject. Doesn't include first 3 RTs of each time they ran 
% through the experiment 
% 
% Note, not all subjects saw all faces (half the subjects saw the faces
% with one hair-type and the other half saw the same faces but with a
% different hair type). Odd subjects saw the faces corresponding to the
% first half of the columns in both subDataMats. Even subjects saw the
% faces corresponding to the second half of the columnd in both
% subDataMats. 


%% Set-up directories
%MAKE SURE CURRENT DIRECTORY IS 'PostExperiment' folder
addpath(cd); %add the 'PostExperimet' to the top of matlabs search path (i.e., for m-files)
cd .. %I have to up one folder to get to the main directory.
%Working Directory
wd = cd; 
%Data Directory
dataDir = strcat(wd,'/','SubData'); 
%Folders for individual computers
compFolders = {'Comp01'; 'Comp02'; 'Comp03'; 'Comp05'; 'Comp06'; 'comp10'};
%Stimuli Directory
imDir = strcat(wd,'/','stimuli'); 

%% Initialize output
nSubsTot = 42;
[~, imNames_group1] = GetImgs(strcat(imDir,'/','group1'), wd, [], 1, '*.jpg');
[~, imNames_group2] = GetImgs(strcat(imDir,'/','group2'), wd, [], 1, '*.jpg'); 
imNames = [sort(imNames_group1)', sort(imNames_group2)']; %Arrange images by group.
nIms= numel(imNames);
subDataMat_t1 = cell(nSubsTot+1, nIms);
subDataMat_t1(1,:) = imNames;
subDataMat_t2 = subDataMat_t1; 
RTs = zeros(nSubsTot,3); 


%% Get Data from the folders and do work on it
subCnt = 1; %this will keep track of the total number of subjects across all comps
nGroup1Subs = 0; 
nGroup2Subs = 0; %also keep track of the number of subjects in each group

for compNum = 1:length(compFolders)
    %Get into a particular computer's folder
    dataSubDir = strcat(dataDir,'/',compFolders{compNum});
    cd(dataSubDir);
    subDataStruct = dir('*.mat');
    
    %Cycle through all subjects in the current folder
    for subNum = 1:size(subDataStruct,1)
        subDataStr =strvcat(subDataStruct(subNum).name); 
        load(subDataStr);
        
%         %For debugging
%         disp(strcat('compNum: ', num2str(compNum))); 
%         disp(strcat('subNum: ', num2str(subNum))); 
        
        %Now I have a single subject's data -- do work on it.
        [sortedImNames, ind] = sort(subData(:,1)); 
        sortedSubData_t1 = subData(ind,2); 
        sortedSubData_t2 = subData(ind,4);
        RTs(subCnt,1) = mean(cell2mat([subData(4:end,3);subData(4:end,5)])); %mean RT
        RTs(subCnt,2) = std(cell2mat([subData(4:end,3);subData(4:end,5)])); %SD RT
        RTs(subCnt,3) = RTs(subCnt,1)/RTs(subCnt,2); %mean RT normalized by SD
        
        if strcmp(sortedImNames{1}, 'W01B01_22_WH_+25.jpg')
            %then group 1 subject
            start = 1;
            fin = 36;
            nGroup1Subs = nGroup1Subs + 1; 
        else %group 2 subject
            start = 37;
            fin = 72;
            nGroup2Subs = nGroup2Subs+1; 
        end
        
        subDataMat_t1(subCnt+1,start:fin) = sortedSubData_t1;
        subDataMat_t2(subCnt+1,start:fin) = sortedSubData_t2;
        subCnt = subCnt + 1;
    end
  
    cd .. %back to subData Directory
    
end



cd(wd); cd('PostExperiment');
    

