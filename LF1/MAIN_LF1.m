function MAIN_LF1
% MAIN_LF1
%{
This experiment is a replication/extension of Experiment 1 in
Levin&Banaji, 2006 (see p. 504 for their description of the
experimental procedure).

On each trial the experiment shows subjects two faces, one labeled the
"reference face" and one labeled the "adjustable face." The subjects' task
is to manipulate the adjustable face so that its "shading" matches that of
the reference face as closely as possible. Adjustments are made using the
up-arrow key and down-arrow key. Hitting either key once exchanges the
current adjustable face with the same face that is either 5 grey-levels
lighter or 5 grey-levels darker. All faces are drawn from the same folder.
 
The experiment has two within-subjects factor (race of reference face vs.
race of adjustable face) with three levels each (white, black, or ambiguous),
giving 9 total conditions for each subject (i.e., factorial design).
There are also two two-level between subjects factors:
Orientation (upright vs. inverted) and Adjustment screen-side(right vs. left).

In each trial, the reference face is set at one of  five different
luminance levels (-10, -5, +5, 0, +10). The initial luminance of the
adjustable face is offset from the reference face by +/-2 or +/-4 levels (in
increments of 5). Therefore, within each of the 9 conditions, there were 20
trials (for a total of 180 trials per subject).
%}

Screen('CloseAll'); clear all; clear mex;

%% Constants / Initialization
wd = cd; %sets experiment's working directory as the current director
cd ..
addpath(strcat(cd, '/general-functions')); %add general functions to working path
cd(wd)

%Display constants
scrnRes = [1280 1024]; %[2560 1440];
scrnWidth = 33.97; %59.69; %cm (measured with measuring tape) <- computer in lab
pixelsPercm = scrnRes(1)/scrnWidth;
faceDist = 10; %cm; distance between the center point of the two faces
faceDist = faceDist*pixelsPercm; %pixels

%For subject
subDataDir = strcat(wd,'/SubData');
subID = GetNextSubID(subDataDir, wd);
subFilename = strcat(int2str(subID), '.mat');

%For experiment
%Note: the loaded container maps are essentially hash maps for indexing the face
%.pngs by filename and associating those indexes with the RGB matrix for
%each image.
load('faceNamesToIndsMap.mat');
load('faceNamesToLightValsMap');
fwidth = 80; %pixels
fheight = 100; %pixels
% rectWidth = 640; rectHeight = 480; %containing rectange in which faces will be drawn
numTrials = 180;
adjSide = 'L'; %run half subjects with ajustment face on left side of screen, half with it on right.


%% Set Random Generate to Clock (otherwise will get same random numbers at the start of each Matlab session)
s = RandStream.create('mt19937ar','seed',sum(100*clock));
RandStream.setDefaultStream(s);


%% Get stimuli and put in the order to be used in the experiment
% upright faces for odd numbered subjects, inverted faces for even
if mod(subID,2) %then odd numbered subject
    load('faceIndsToRGBMap_upright.mat');
else %even numbered subject
    load('faceIndsToRGBMap_inverted.mat');
end

%Set-up stimuli for whole experiment; REF STIM IN FIRST COLUMN, ADJ STIM
%IN SECOND COLUMN. I tried to get the image names elegently, but resorted
%to a brute-force approach. I'll have to change this if we make any changes
%to the experiment.
stimNames = cell(numTrials,2);
stimNames = ArrangeNamesViaBruteForce(stimNames);

%randomly permute the names
sortedStimNames = cell(numTrials,2);
[sortedStimNames(:,1),sortedStimNames(:,2)] = ...
    RepAndPermVects(1,1,stimNames(:,1),stimNames(:,2));

%Initialize subData
subData = cell(numTrials,4); %3RD COLUMN FOR LIGHTNESS ADJ VAL; 4TH COLUMN FOR NUMBER OF ADJUSTMENTS
subData(:,1) = sortedStimNames(:,1); %store data in same random order subjects are viewing it - ref stim in first column, adj stim in second.
subData(:,2) = sortedStimNames(:,2);


%% Psychtoolbox set-up
%Open onscreen win:
screenNumber = max(Screen('Screens'));
[win, screenRect] = Screen('OpenWindow', screenNumber, [],[],[],2);
% [win, screenRect] = Screen('OpenWindow', screenNumber, [],[0 0 1280 720],[],2); %top left quarter of mac in lab, for debugging
% [win, screenRect] = Screen('OpenWindow', screenNumber, backgroundColor,[0 0 1366/2 768/2],[],2); %top left quarter of laptop, for debugging
%Get the midpoint (mx, my) of this window, x and y
[mx, my] = RectCenter(screenRect);

%Show instructions
ShowImgUntilKeyPressed(win,'Instructions.jpg');
% HideCursor;


%% Running Experiment
%text constants (Note: faces are 80x100 pixels).
textLx = mx/2 - 80; textLy = my/2 - 100;
textRx = mx/2 + 80; textRy = my/2 - 100;
adjText = 'Adjustment Face'; refText = 'Reference Face';

%Coordinates for left-side face
faceLx1 = mx - faceDist/2 - fwidth/2; %desired top-left x-coordinate of left side face
faceLy1 = my - fheight/2; %desired top-left y-coordinate of left side face
faceLx2 = faceLx1 + fwidth; %desired top-left y-coordinate of left side face
faceLy2 = faceLy1 + fheight; %desired bottom-right y-coord of left side face
%Coordinates for right-side face
faceRx1 = mx + faceDist/2 - fwidth/2; 
faceRy1 = my - fheight/2; 
faceRx2 = faceRx1 + fwidth; 
faceRy2 = faceRy1 + fheight;

% %coordinates for left-side face
% faceLx1 = mx - rectWidth/2 - fwidth/2; %desired top-left x-coordinate of left side face
% faceLy1 = my - rectHeight/2; %desired top-left y-coordinate of left side face
% faceLx2 = faceLx1 + fwidth; %desired bottom-right x-coord of left side face
% faceLy2 = faceLy1 + fheight; %desired bottom-right y-coord of left side face
% %coordinates for right-side face
% faceRx1 = mx + rectWidth/2 - fwidth/2; 
% faceRy1 = my - rectHeight/2;
% faceRx2 = faceRx1 + fwidth; 
% faceRy2 = faceRy1 + fheight;

%matching L/R coordinates with adjustment/reference face
switch (adjSide)
    case 'L'
        adjFaceCoords = [faceLx1, faceLy1, faceLx2, faceLy2];
        adjTextCoords = [textLx, textLy];
        refFaceCoords = [faceRx1, faceRy1, faceRx2, faceRy2];
        refTextCoords = [textRx, textRy];
    case 'R'
        adjFaceCoords = [faceRx1, faceRy1, faceRx2, faceRy2];
        adjTextCoords = [textRx, textRy];
        refFaceCoords = [faceLx1, faceLy1, faceLx2, faceLy2];
        refTextCoords = [textLx, textLy];
    otherwise
        warning('Unexpected adjSide. Change to "L" or "R" then re-run.')
        screen('CloseAll'); clear all; return;
end
 
%Running through all trials
for i = 1:numTrials
    refFaceName = sortedStimNames{i,1};
    adjFaceName = sortedStimNames{i,2};
    %Run lightness adjustment procedure. Note that the adjustment is
    %recorded as a lightness value on the scale we created (-30 to +30 in
    %increments of 5). The function also returns the number of adjustments
    %made (the second return argument). 
    [subData{i,3}, subData{i,4}] = ...
                         getLightnessAdjustment(win, refFaceName, adjFaceName,...
                            refFaceCoords, adjFaceCoords,...
                            refText, adjText, refTextCoords, adjTextCoords,...
                            faceNamesToIndsMap, faceIndsToRGBMap,...
                            faceNamesToLightValsMap);
end


%% Saving subject data and ending experiment
cd(subDataDir); save(subFilename, 'subData'); cd(wd)
ShowImgUntilKeyPressed(win, 'EndOfExpt.jpg');

ShowCursor; 
Screen('CloseAll'); clear all; clear mex;












 