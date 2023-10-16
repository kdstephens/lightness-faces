function [summary1, summary2, desirableFaces] = ExtractFaceMorphData

% [summary1, summary2, desirableFaces] = ExtractFaceMorphData
% 
% Function for finding the morphed faces that get categorized as White when
% wearing White hair (i.e., categorized as White on both viewings the 
% majority of the time), but Black when wearing Black hair (i.e., 
% categorized as Black on both viewings the majority of the time).

%MAKE SURE CURRENT DIRECTORY IS 'PostExperiment' folder
% Other functions 
[subDataMat_t1, subDataMat_t2, nGroup1Subs, nGroup2Subs] = GetData; 
[faceNames, nWhite, nAmbig, nBlack] = AnalyzeData(subDataMat_t1, subDataMat_t2);

for i = 1:length(faceNames)
    if i < 36 %Since faces are organized such that first 36 are Group1 and second 36 are Group2
        nSubs = nGroup1Subs; 
    else
        nSubs = nGroup2Subs;
    end
    nWhite(i) = nWhite(i)/nSubs; 
    nAmbig(i) = nAmbig(i)/nSubs; 
    nBlack(i) = nBlack(i)/nSubs; 
end

%Output
summary1 = cell(length(faceNames)+1, 4); 
summary1{1,1} = 'Face Name';      summary1(2:end,1) = num2cell(faceNames);
summary1{1,2} = 'Frac Cat White'; summary1(2:end,2) = num2cell(nWhite); 
summary1{1,3} = 'Frac Cat Ambig'; summary1(2:end,3) = num2cell(nAmbig); 
summary1{1,4} = 'Frac Cat Black'; summary1(2:end,4) = num2cell(nBlack);

%Arrange in a more useful fashion %NOT QUITE RIGHT -- FIX (actually, don't
%really use this, so don't worry about it. Mostly just use the last output)
summary2{1,1} = 'White Hair Version'; 
summary2{1,2} = 'Frac Cat White'; 
summary2(2:19,1:2) = summary1(2:19,1:2); 
summary2(20:37,1:2) = summary1(56:end,1:2);

summary2{1,3} = 'Black Hair Version'; 
summary2{1,4} = 'Frac Cat Black';
summary2(2:19,3) = summary1(38:55,1); 
summary2(2:19,4) = summary1(38:55,4); 
summary2(20:37,3) = summary1(20:37,1); 
summary2(20:37,4) = summary1(20:37,4);


% Extract those faces that have a WhiteCat > 0.7 and BlackCat > 0.7
desirableFaceNum = 1; 
for faceNum = 2:length(summary2); 
    if summary2{faceNum,2} > 0.7 && summary2{faceNum,4} > 0.7
        desirableFaces(desirableFaceNum,:) = summary2(faceNum,:); 
        desirableFaceNum = desirableFaceNum + 1; 
    end
end
        

