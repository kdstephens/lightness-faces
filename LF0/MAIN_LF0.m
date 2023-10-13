function MAIN_LF0
% MAIN_LF0
%{
Shows subjects several faces and asks them to judge whether they are
black or white ('b' for black, 'w' for white). Takes in a string of w's
and b's and codes them as 1's and 0's respectively. Saved data is a cell
with the face names listed in the first column (in the random order 
presented during the experiment), and the subject's categorizations (1's
and 0's) listed in the second column. 

Assumes several subdirectories: 
 1. Subdirectory for subject data that contains .mat files titled with the subject number
 (i.e., 1.mat, 2.mat,...)
 2. Subdirectory for the stimuli (face) to be shown during the experiment. This directory has 
 two further subdirectories: one in which the faces are upright and one in which they are 
 inverted. 
%}

Screen('CloseAll'); clear all; clear mex;

%% Constants / Initialization
wd = cd; %sets experiment's working directory as the current directory
cd ..; addpath(strcat(cd, '\general-functions')); cd(wd) %add necessary general functions
%For subject
subDataDir = strcat(wd,'\SubData'); 
subID = GetNextSubID(subDataDir, wd); 
subFilename = strcat(int2str(subID), '.mat');
%For experiment
faceDir = strcat(wd,'\stimuli');
numFaceRepeats = 2; 


%% Set Random Generate to Clock (otherwise will get same random numbers at the start of each Matlab session)
 s = RandStream.create('mt19937ar','seed',sum(100*clock));
 RandStream.setDefaultStream(s);
 
 
 %% Get faces, repeat numFaceRepeats number of times and randomly permute
 % upright faces for odd numbered subjects, inverted faces for even
 if mod(subID,2) %then odd numbered subject
     faceDir = strcat(faceDir,'\upright');
 else %even numbered subject
     faceDir = strcat(faceDir,'\inverted');
 end
 [facesRGB, faceNames]  = GetImgs(faceDir, wd, [], '*.png');
 [stimRGB, stimNames] = RepAndPermVects(numFaceRepeats, 1, facesRGB, faceNames); 
 numStim = length(stimRGB);
 
 %Initialize subData
 subData = cell(length(stimNames), 3); %1st col stim, 2nd col responses, 3rd col reaction time.
 subData(:,1) = stimNames; %store data in same random order subjects are viewing it
 
 
%% Psychtoolbox set-up
%Open onscreen win:
screenNumber = max(Screen('Screens'));
% backgroundColor = GrayIndex(screenNumber);
[win, screenRect] = Screen('OpenWindow', screenNumber, [],[],[],2);
% [win, screenRect] = Screen('OpenWindow', screenNumber, [],[0 0 1280 720],[],2); %top left quarter of mac in lab, for debugging
% [win, screenRect] = Screen('OpenWindow', screenNumber, backgroundColor,[0 0 1366/2 768/2],[],2); %top left quarter of laptop, for debugging 
%Get the midpoint (mx, my) of this window, x and y
[~, my] = RectCenter(screenRect);
% Screen('CloseAll'); For Debugging.

HideCursor;

%Show instructions
ShowImgUntilKeyPressed(win, 'Instructions.jpg');

%% Getting racial categorizations
%text constants. faces are assumed 80x100 pixels. 
msg = 'Type "w" for white and "b" for black\n\nHit return to input your selection:';
x =  'center'; %screenCenter(1) - 335 - 150; 
y = my - 300; 

for i = 1:numStim
    %Draw face and text
    screenStim = Screen('MakeTexture', win, stimRGB{i});
    Screen('DrawTexture', win, screenStim);
%     Screen('DrawText', win, msg, x, y);
    DrawFormattedText(win, msg, x, y); 
    t0 = Screen('Flip', win);
    
    %Getting racial categorization and reaction time
    [input t1] = GetEchoInput(win, stimRGB{i}, 'alpha', {'b' 'w'}, msg, x, y);
    subData{i,3} = t1 - t0; %reaction time
    if strcmp(input,'b') || strcmp(input,'B')
        subData{i,2} = 0; %code black as 0
    elseif strcmp(input,'w') || strcmp(input,'W')
        subData{i,2} = 1; %code white as 1
    else
        warning('An input value of %s got through', input);
    end
end


%% Saving subject data and ending experiment
cd(subDataDir); save(subFilename, 'subData'); cd(wd)
cd ..; ShowImgUntilKeyPressed(win, wd, 'EndOfExpt.jpg');

ShowCursor; 
Screen('CloseAll'); clear all; clear mex; 
    
    
    
 