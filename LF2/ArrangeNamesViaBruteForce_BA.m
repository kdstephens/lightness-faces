function stimNames = ArrangeNamesViaBruteForce_BA(stimNames)

% stimNames = ArrangeNamesViaBruteForce(stimNames)
%
% This is my brute force solution to arranging the stimulus names for
% experiment LF1. This function is meant specifically to be used with
% MAIN_LF1.m, so see that m-file for the logic behind this arrangement.

%Reference stimuli in first column
%-10
% stimNames(1:4) = repmat({'BW000 -10.png'},4,1);
stimNames(1:4) = repmat({'BW050 -10.png'},4,1);
stimNames(5:8) = repmat({'BW000 -10.png'},4,1);
%-05
% stimNames(13:16) = repmat({'BW000 -05.png'},4,1);
stimNames(9:12) = repmat({'BW050 -05.png'},4,1);
stimNames(13:16) = repmat({'BW000 -05.png'},4,1);
%+00
% stimNames(25:28) = repmat({'BW000 +00.png'},4,1);
stimNames(17:20) = repmat({'BW050 +00.png'},4,1);
stimNames(21:24) = repmat({'BW000 +00.png'},4,1);
%+05
% stimNames(37:40) = repmat({'BW000 +05.png'},4,1);
stimNames(25:28) = repmat({'BW050 +05.png'},4,1);
stimNames(29:32) = repmat({'BW000 +05.png'},4,1);
%+10
% stimNames(49:52) = repmat({'BW000 +10.png'},4,1);
stimNames(33:36) = repmat({'BW050 +10.png'},4,1);
stimNames(37:40) = repmat({'BW000 +10.png'},4,1);

%Adjustment stimuli in second column
stimNames(41:48) = ... %paired with -10
    repmat({'-30_111.jpg';'-20_121.jpg';'+00_141.jpg';'+10_151.jpg'},2,1);

stimNames(49:56) = ... %paired with -05
    repmat({'-25_116.jpg';'-15_126.jpg';'+05_146.jpg';'+15_156.jpg'},2,1);

stimNames(57:64) = ... %paired with +00
    repmat({'-20_121.jpg';'-10_131.jpg';'+10_151.jpg';'+20_161.jpg'},2,1);

stimNames(65:72) = ... %paired with +05
    repmat({'-15_126.jpg';'-05_136.jpg';'+15_156.jpg';'+25_166.jpg'},2,1);

stimNames(73:80) = ... %paired with +10
    repmat({'-10_131.jpg';'+00_141.jpg';'+20_161.jpg';'+30_171.jpg'},2,1);

% %Double checking I have all the names right (see also
% %ContainersMapsScript.m)
% check = zeros(180,1);
% faceNames = faceNames';
% for i = 1:size(sortedStimNames,1)
%     for k = 1:size(faceNames,1)
%         if strcmp(faceNames{k},sortedStimNames{i,2})
%             check(i) = check(i) + 1;
%         end
%     end
% end