function [faceNames, nWhite, nAmbig, nBlack, nSubs] = AnalyzeData(subDataMat_t1, subDataMat_t2)

% [faceNames, nWhite, nAmbig, nBlack, nSubs] = AnalyzeData_MLF0(subDataMat_t1, subDataMat_t2)
% 
% subDataMat_t1 gives how each subject categorized each face they saw the
% first time they ran through the experiment (0 = Black; 1 = White). 
% subDataMat_t2 gives how each subject categorized each face they saw the
% second time they ran through the experiment. 
% 
% Note: odd numbered subjects saw one set of faces, even set of subjects 
% saw the same faces, but with the hair switched (i.e., the White hair 
% faces got Black hair and vice-versa). 
% 
% The outputs give the number of a times each face was categorized as 
% White twice (nWhite), the number of times the face was categorized as 
% White exactly once (nAmbig), and the number of times the face was 
% categorized as Black twice (nBlack). 
% 
% NOTE: In all outputs, first 36 faces are Group1, second 36 are Group2.
% Also, they correspond. e.g., face1 is the White-hair version of W1B1_22,
% and face37 is the Black-hair version. 

%% Initialization
nSubs = size(subDataMat_t1,1)-1; 
nFaces = size(subDataMat_t1,2); 

nWhite = zeros(nFaces,1); nAmbig = nWhite; nBlack = nWhite; 

faceNames = subDataMat_t1(1,:)'; 

% faceCats = cell(nFaces, 4); %2nd col nWhite, 3rd col nAmbig, 4th col nBlack
% faceCats(:,1) = subDataMat_t1(1,:); %First col imNames

%% Loop
for faceNum = 1:nFaces
    for subNum = 1:nSubs
        if ~isempty(subDataMat_t1{subNum+1,faceNum}) && ~isempty(subDataMat_t2{subNum+1,faceNum})
            if subDataMat_t1{subNum+1,faceNum}==1 && subDataMat_t2{subNum+1,faceNum}==1
                %Then face rated as White twice
                nWhite(faceNum) = nWhite(faceNum) + 1;
            elseif subDataMat_t1{subNum+1,faceNum}==1 && subDataMat_t2{subNum+1,faceNum}==0
                %Then face rated as White, then Black
                nAmbig(faceNum) = nAmbig(faceNum) + 1;
            elseif subDataMat_t1{subNum+1,faceNum}==0 && subDataMat_t2{subNum+1,faceNum}==1
                %Then face rated as Black, then White
                nAmbig(faceNum) = nAmbig(faceNum) + 1;
            elseif subDataMat_t1{subNum+1,faceNum}==0 && subDataMat_t2{subNum+1,faceNum}==0
                %Then face rated as Black twice
                nBlack(faceNum) = nBlack(faceNum) + 1;
            end
        end
    end
end

% faceCats(:,2) = nWhite; 
% faceCats(:,3) = nAmbig; 
% faceCats(:,4) = nBlack; 
