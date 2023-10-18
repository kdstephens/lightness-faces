function [adjVal, numAdjs] = GetLightnessAdjustment(win, refStimName, adjStimName,...
                      refStimCoords, adjStimCoords,...
                      refNamesToIndsMap, refIndsToRGBMap,... %refNamesToLightValsMap,...
                      adjNamesToIndsMap, adjIndsToRGBMap,adjNamesToLightValsMap)
                         
% [adjVal numAdjs] = GetLightnessAdjustment(win, refStimName, adjStimName,...
%                       refStimCoords, adjStimCoords,...
%                       faceNamesToIndsMap, faceIndsToRGBMap,faceNamesToLightValsMap,...
%                       patchNamesToIndsMap, patchIndsToRGBMap,patchNamesToLightValsMap)
%
% Psychtoolbox function that displays a reference image and an adjustment 
% image side by side and uses the method of adjustment to get a lightness
% rating from the subject. The namesToIndsMap and the indsToRGBMap are used
% when making the adjustments. See 'MAIN_LF1.m' for more details about the
% specific experiment this function is used for. 


%% Initialization
initVal = adjNamesToLightValsMap(adjStimName); %initial lightness value
deltaVal = 0; %initial adjustment val = 0
numAdjs = 0; %initially 0 adjustments made
KbName('UnifyKeyNames');
% up = KbName('UpArrow');
% down = KbName('DownArrow'); %#ok<*NASGU>
% rtrn = KbName('return');

%Initial adjustment and reference stimuli
refStimInd=refNamesToIndsMap(refStimName); refStimRGB=refIndsToRGBMap(refStimInd);
adjStimInd=adjNamesToIndsMap(adjStimName); adjStimRGB=adjIndsToRGBMap(adjStimInd);
%Make reference texture (never changes, so don't need it in the loop below)
screenRefStim = Screen('MakeTexture', win, refStimRGB);


%% Adjustment Loop
while true
    %Drawing stimuli and accompanying text
    Screen('DrawTexture', win, screenRefStim, [], refStimCoords);
    screenAdjStim = Screen('MakeTexture', win, adjStimRGB);
    Screen('DrawTexture', win, screenAdjStim, [], adjStimCoords);
    Screen('Flip', win);
    
    %Getting input from subject. Keeps going even if user accidentally hits
    %a key other than up-arrow, down-arrow, or spacebar
    keyCode = zeros(1,256); name = KbName(keyCode); 
    while (~strcmp(name,'UpArrow') && ~strcmp(name,'DownArrow') &&...
                                      ~strcmp(name,'space'))
        [~, keyCode] = KbStrokeWait();
        name = KbName(keyCode); 
        if iscell(name) %happens when the subject accidently hits the up and down arrow keys at the same time. Not doing this causes matlab to crash in these cases. 
            name = name{1}; 
        end
    end
   
    %Making appropriate adjustments based on input
    switch name
        case 'UpArrow'
            numAdjs = numAdjs + 1; 
            %only change when up-arrow pressed if current adjStim lightness val is not an upper bound (30).
            if ~(initVal + deltaVal == 30)
                adjStimInd = adjStimInd + 1;
                deltaVal = deltaVal + 5;
            end
        case 'DownArrow'
            numAdjs = numAdjs + 1; 
            %only change when down-arrow pressed if current adjStim lightness val is not a lower bound (-30). 
            if ~(initVal + deltaVal == -30)
                adjStimInd = adjStimInd - 1;
                deltaVal = deltaVal - 5; 
            end
        case 'space'
            adjVal = initVal + deltaVal;
            break;
        otherwise
            warning('Unexpected input got through. Double check code.')
            screen('CloseAll'); clear all; return; 
    end      
    adjStimRGB = adjIndsToRGBMap(adjStimInd);
end

Screen('Close')


