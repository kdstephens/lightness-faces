function ShowImgUntilKeyPressed(win, fileName)

% ShowImgUntilKeyPressed(win, fileName)
%
% PsychToolbox function that takes in an image filename and displays the the image in
% the current PsychToolbox window (input as win) until a key is pressed. 

img = imread(fileName);
screenImg = Screen('MakeTexture', win, img);
Screen('DrawTexture', win, screenImg); 
Screen('Flip', win); 

%Wait for keypress from subject to continue
WaitSecs(1);
keyIsDown = 0 ; 
while ~keyIsDown 
    keyIsDown = KbCheck(); 
end
FlushEvents


