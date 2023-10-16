function MAIN_MLF0
% MAIN_MLF0
%{

Shows participants several faces, one at a time. For each face participants 
are asked to categorize it as Caucasian (by pressing “c” on the keyboard) 
or as African-American (by pressing “a” on the keyboard). Participants are 
also informed that some of the faces might look ambiguous or multi-racial, but 
they should choose the race that the face looks most like. After choosing a 
racial category, participants press the return key to submit their response. 
Each submission is followed by a 500ms interstimulus interval containing a 
375 (vertical) by 300 (horizontal) pixel rectangle of Gaussian noise. 
All faces are shown against a white background at central fixation.

Takes the string of b's and w's and codes them as 0's and 1's respectively. 
Data is saved as a cell with the face names listed in the first column 
(in the order presented during the experiment), and the subjects' 
categorizations (1's and 0's) listed in the second column.
%}

%% Constants / Initialization
wd = cd; %sets experiment's working directory as the current directory
cd ..
addpath(strcat(cd, '/general-functions')); 
cd(wd)

%Display constants
screenNumber = max(Screen('Screens'));
backgroundColor = WhiteIndex(screenNumber); 
% resolution = Screen('Resolution', screenNumber);
% scrnRes(1) = resolution.width;
% scrnRes(2) = resolution.height;
% scrnWidth = 33.97; %cm (measured with measuring tape)

%For subject
subDataDir = strcat(wd,'/SubData');
subID = GetNextSubID(subDataDir, wd); 
subFilename = strcat(int2str(subID), '.mat');
%For experiment
stimDir = strcat(wd,'/stimuli');
imRescaleVal = 0.5; 


%% Seed random number generator
 s = RandStream.create('mt19937ar','seed',sum(100*clock));
 RandStream.setDefaultStream(s);
 
  
 %% Get faces and randomly permute
 % group1 faces for odd numbered subjects, group2 faces for even
 if mod(subID,2) %then odd numbered subject
     faceDir = strcat(stimDir,'/group1');
 else %even numbered subject
     faceDir = strcat(stimDir,'/group2');
 end
 
 %Initialization
 [facesRGB, faceNames]  = GetImgs(faceDir, wd, [], imRescaleVal, '*.jpg');
 nMorphs = 6;
 nFacesPerMorph = 12;
 nStim = nMorphs*nFacesPerMorph; 
 for i = 1:nMorphs
     locs(i,:) = i:6:nStim; 
 end

 morphOrder = randperm(nMorphs);
 stimRGB = cell(nMorphs*nFacesPerMorph,1); stimNames = stimRGB; 
 
 %Psuedo-random ordering: Want to show each kind of morph only once before 
 %showing another morph of that kind
 for i = 1:nMorphs
     loc = locs(morphOrder(i),:); 
     [stimRGB(loc), stimNames(loc)] = ...
         RepAndPermVects(1,1,facesRGB(nFacesPerMorph*i-(nFacesPerMorph-1):nFacesPerMorph*i),faceNames(nFacesPerMorph*i-(nFacesPerMorph-1):nFacesPerMorph*i));

%      num = morphOrder(i); 
%      
%      [stimRGB(nFacesPerMorph*num-(nFacesPerMorph-1):nFacesPerMorph*num), stimNames(nFacesPerMorph*num-(nFacesPerMorph-1):nFacesPerMorph*num)] = ...
%          RepAndPermVects(1,1,facesRGB(nFacesPerMorph*i-(nFacesPerMorph-1):nFacesPerMorph*i),faceNames(nFacesPerMorph*i-(nFacesPerMorph-1):nFacesPerMorph*i));
 end
%  nStim = length(stimRGB); 
 
 %Initialize subData
 subData = cell(length(stimNames), 3); %1st col stim, 2nd col responses, 3rd col reaction time.
 subData(:,1) = stimNames; %store data in same random order subjects are viewing it
 
 
%% Psychtoolbox set-up
psychtoolboxStuff = PsychtoolboxSetup(backgroundColor); 
win = psychtoolboxStuff.win; 
% mx = psychtoolboxStuff.mx; 
my = psychtoolboxStuff.my; 

%Show instructions
% ShowImgUntilKeyPressed(win, 'MLF0_Instructions.jpg'); 
%NEED TO MAKE
ShowImgUntilKeyPressed(win,'Instructions.jpg');

%% Getting racial categorizations
%Text constants
% subData.questionType = 'Caucasian (y/n)'; 
msg = 'Does this face look Caucasian or African-American?\n\nType ''c'' for Caucasian and ''a'' for African American\n\nHit return to input your response: ';
x = 'center'; 
y = my - 300; 

%ISI Noise
noise = MkWhiteNoise(size(stimRGB{1},1), size(stimRGB{1},2)); 

for i = 1:nStim
    %Draw ISI 
    screenNoise = Screen('MakeTexture', win, noise); 
    Screen('DrawTexture', win, screenNoise); 
    tNoise = Screen('Flip', win);
    
    %Draw face and text
    screenStim = Screen('MakeTexture', win, stimRGB{i}); 
    Screen('DrawTexture', win, screenStim); 
    DrawFormattedText(win, msg, x, y); 
    t0 = Screen('Flip', win, tNoise+0.5); %ISI noise for 500 ms.  
    
    %Get racial categorization and reaction time
    [input, t1] = GetEchoInput(win, stimRGB{i}, 'alpha', {'a','c'}, msg, x, y); 
    subData{i,3} = t1 - t0; %reaction time
    if strcmp(input,'a') || strcmp(input,'A')
        subData{i,2} = 0; %code black as 0
    elseif strcmp(input,'c') || strcmp(input,'C')
        subData{i,2} = 1; %code white as 1 
    else
        warning('an input value of %s got through', input); 
    end
end


%% Save subject data and end experiment
cd(subDataDir); save(subFilename, 'subData'); cd(wd)
ShowImgUntilKeyPressed(win, 'EndOfExpt.jpg'); 

ShowCursor; 
Screen('CloseAll'); clear all; clear mex



