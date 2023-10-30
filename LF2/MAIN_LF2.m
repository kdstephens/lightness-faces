function MAIN_LF2
%{
This experiment is a replication/extension of Experiments 1/2 in
Levin&Banaji.JEPG.2006 (see p. 504 for their description of the
experimental procedure).

On each trial the experiment shows subjects a reference face, and an 
adjustable gray patch. The subjects' task is to manipulate the adjustable 
patch so that its "shading" matches that of the reference face as closely 
as possible. Adjustments are made using the up-arrow key and down-arrow key. 
Hitting either key once exchanges the current patch with a patch that is 
either 5 gray-levels lighter or 5 gray-levels darker.
 
The main between subjects factor is race of reference face with three 
levels (white, black, or ambiguous). One group gets only white and 
ambiguous faces; the other group gets only black and ambiguous faces. 
There is also a between-subjects factor: adjustment screen-side
right vs. left).

In each trial, the reference face is set at one of  five different
luminance levels (-10, -5, +5, 0, +10). The initial luminance of the
adjustable patch is offset from the reference face by +/-2 or +/-4 levels (in
increments of 5). Therefore, within each of the 2 face conditions (per subject), 
there were 20 trials for a total of 40 trials per subject. 
%}

Screen('CloseAll'); clear all; clear mex;

%% Constants / Initialization
wd = cd; %sets experiment's working directory as the current directory
cd ..
addpath(strcat(cd, '/general-functions')); %add general functions to working path
cd(wd)

%Display constants
screenNumber = max(Screen('Screens'));
scrnRes = Screen('Resolution',screenNumber);
scrnWidth = 33.97; %cm (measured with measuring tape)
pixelsPercm = scrnRes.width/scrnWidth;
stimDist = 10; %in cm; distance between the center point of the two faces
stimDist = stimDist*pixelsPercm; %in pixels

%For subject ***************************************************************
subDataDir = strcat(wd,'/SubjectData_Debug'); %Change to _BA or _WA when black/white faces used
%***************************************************************************
subID = GetNextSubID(subDataDir, wd);
subFilename = strcat(int2str(subID), '.mat');

%For experiment
%Note: the loaded container maps are essentially hash maps for indexing the
%stimuli .pngs by filename and associating those indexes with the RGB matrix 
%for each image.
load('faceNamesToIndsMap.mat'); load('faceNamesToLightValsMap.mat');
load('patchNamesToIndsMap.mat'); load('patchNamesToLightValsMap.mat');
load('faceIndsToRGBMap_upright.mat'); load('patchIndsToRGBMap.mat');
stimWidth = 80; %pixels
stimHeight = 100; %pixels
% rectWidth = 640; rectHeight = 480; %containing rectange in which faces will be drawn
numRaces = 2; 
numRepeats = 1; %In case where there's only one race (W or B), I want to repeat the stimuli twice to keep the experiment not too short. 
numTrials = 20*numRaces*numRepeats; %5 starting levels for each ref face (-10,-5,0,5,10) and 4 starting offsets for ref patch (+/-2, +/-4) gives the 20.


%For post-experiment survey
scaleText = {'strongly disagree', 'disagree', 'somewhat disagree',...
    'neither agree nor disagree', 'somewhat agree', 'agree', 'strongly agree'};
circleColors = [[255 100 50];[255 150 50];[245 165 79];[245 245 220];[150 150 255];[100 100 255];[50 50 255]]';
% colors = [[245 245 220];[245 245 220];[245 245 220];[245 245 220];[245 245 220];[245 245 220];[245 245 220]]';
slidePosInit = 4;
%surveyQuestions
freeQ = 'Question 1 (free response)\n\n What do you think this research was about?\n\n What do you think the researchers were trying to prove with this experiment?\n\n (hit enter to input your response):\n\n'; 
likertQs = {'Statement 1 \n\n I knew what the researchers were investigating in this research.';...
            'Statement 2\n\n I was not sure what the researchers were trying to demonstrate in this research.';...
            'Statement 3\n\n I had a good idea about what the hypotheses were in this research.';...
            'Statement 4\n\n I was unclear about exactly what the researchers were aiming to prove in this research.';...
            'Statement 5\n\n My knowledge of the research hypotheses affected my responses in the experiment.'};
        

%% Get stimuli and put in the order to be used in the experiment
%Set-up stimuli for whole experiment; REF STIM IN FIRST COLUMN, ADJ STIM
%IN SECOND COLUMN. I tried to get the image names elegently, but resorted
%to a brute-force approach. I'll have to change this if we make any changes
%to the experiment.

%Determines which group the subject is in on the between-subjects factor.
%They will either get the White face or the Black face.
stimNames = cell(numTrials/numRepeats,2); 
%***************************************************************************
stimNames = ArrangeNamesViaBruteForce_WA(stimNames); %_WA indicates White/Amb. Change to _BA for Black/Amb.
%***************************************************************************

%randomly permute the names
sortedStimNames = cell(numTrials/numRepeats,2);
[sortedStimNames(:,1),sortedStimNames(:,2)] = ...
    RepAndPermVects(1,1,stimNames(:,1),stimNames(:,2));
sortedStimNames = repmat(sortedStimNames, numRepeats, 1); %Run through all stimuli numRepeats number of times (in the same order each time)

%Initialize subData
subData = cell(numTrials,6); %3RD COLUMN FOR LIGHTNESS ADJ VAL; 4TH COLUMN FOR NUMBER OF ADJUSTMENTS; 5TH COLUMN FOR ANSWERS TO POST-EXPT SURVEY; 6TH COLUMN READS DOWN: AGE, GENDER, ETHNICITY & HANDEDNESS
subData(:,1) = sortedStimNames(:,1); %store data in same random order subjects are viewing it - ref stim in first column, adj stim in second.
subData(:,2) = sortedStimNames(:,2);
%GUI-based function that gets age, gender, ethnicity, and handedness.
[subData{1,6},subData{2,6},subData{3,6},subData{4,6}] = GetSubInfo();
                                                   


%% Psychtoolbox set-up
c = PsychtoolboxSetup; 
mx = c.mx; my = c.my; win = c.win;

%Show instructions
ShowImgUntilKeyPressed(win,'LF2_Instructions.jpg'); 

  
%% Running Experiment 
%Odd-numbered subjects have adjustment patch on left; even on right. 
if mod(subID,2) %odd-numered subject
    adjSide = 'L'; 
else %even-numbered subject
    adjSide = 'R'; 
end

%Coordinates for left-side stimuli
stimLx1 = mx - stimDist/2 - stimWidth/2; %desired top-left x-coordinate of left side stim
stimLy1 = my - stimHeight/2; %desired top-left y-coordinate of left side stim
stimLx2 = stimLx1 + stimWidth; %desired top-left y-coordinate of left side stim
stimLy2 = stimLy1 + stimHeight; %desired bottom-right y-coord of left side stim
%Coordinates for right-side stim
stimRx1 = mx + stimDist/2 - stimWidth/2; 
stimRy1 = my - stimHeight/2; 
stimRx2 = stimRx1 + stimWidth; 
stimRy2 = stimRy1 + stimHeight;

%matching L/R coordinates with adjustment/reference stim
switch (adjSide)
    case 'L'
        adjStimCoords = [stimLx1, stimLy1, stimLx2, stimLy2];
        refStimCoords = [stimRx1, stimRy1, stimRx2, stimRy2];
    case 'R'
        adjStimCoords = [stimRx1, stimRy1, stimRx2, stimRy2];
        refStimCoords = [stimLx1, stimLy1, stimLx2, stimLy2];
    otherwise
        warning('Unexpected adjSide. Change to "L" or "R" then re-run.')
        screen('CloseAll'); clear all; return;
end
 
%Running through all trials
for k = 1:numRepeats
    for i = 1:numTrials/numRepeats
        refStimName = sortedStimNames{i,1};
        adjStimName = sortedStimNames{i,2};
        %Run lightness adjustment procedure. Note that the adjustment is
        %recorded as a lightness value on the scale we created (-30 to +30 in
        %increments of 5). The function also returns the number of adjustments
        %made (the second return argument).
        cnt = (k-1)*numTrials/numRepeats; %THIS LINE WAS MY PROBLEM FOR ORIGINAL RUN OF LF3. FIXED NOW.
        [subData{i+cnt,3}, subData{i+cnt,4}] = ...
            GetLightnessAdjustment(win, refStimName, adjStimName,...
            refStimCoords, adjStimCoords,...
            faceNamesToIndsMap, faceIndsToRGBMap_upright,...
            faceNamesToLightValsMap,...
            patchNamesToIndsMap, patchIndsToRGBMap,...
            patchNamesToLightValsMap);
    end
end

cd(subDataDir); save(subFilename, 'subData'); cd(wd)
% Screen('Close'); 


%% Post-Experiment Survey
ShowImgUntilKeyPressed(win, 'SurveyInstructions.jpg');
x = 'center'; y = my-300;
%Free response question
DrawFormattedText(win, freeQ, x, y);
Screen('Flip', win)
subData{1,5} = GetEchoString2(win, freeQ, x, y);
%Five likert statemtns
for i = 1:length(likertQs)
    subData{i+1,5} = circleLikert(c, likertQs{i}, scaleText, circleColors, slidePosInit);
end


%% Saving subject data and ending experiment
cd(subDataDir); save(subFilename, 'subData'); cd(wd)
ShowImgUntilKeyPressed(win, 'EndOfExpt.jpg');

ShowCursor; 
Screen('CloseAll'); clear all; clear mex;












 