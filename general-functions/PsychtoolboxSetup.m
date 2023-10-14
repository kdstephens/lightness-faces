% psychtoolboxSetup
% run experiment setup scripts here, like graphics etc

function [c] = PsychtoolboxSetup(backgroundColor)

% if you're using randomization, it's important to seed your random number
% generator!
% RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock))); %seed rand

%graphics stuff
screenNumber = max(Screen('Screens')); % 0 = main display
if nargin > 0
    c.backgroundColor = backgroundColor; 
else
    c.backgroundColor = GrayIndex(screenNumber);
end

%screen / coordinates
if max(Screen('Screens'))>0 %dual screen
    c.dual = get(0,'MonitorPositions');
   % c.scrsz = [0,0,(c.dual(2,3)-c.dual(2,1)),(c.dual(2,4)-c.dual(2,2))];
    c.scrsz = [0,0,(c.dual(1,3)-c.dual(1,1)),(c.dual(1,4)-c.dual(1,2))];

elseif max(Screen('Screens'))==0 % one screen
    c.scrsz = get(0,'ScreenSize') ;
end

% PsychDebugWindowConfiguration([], 0.25); %Creates transparent window for debugging.
[c.win, c.winRect] = Screen('OpenWindow', screenNumber, c.backgroundColor);
% [c.win, c.winRect] = Screen('OpenWindow', screenNumber, c.backgroundColor,[0 0 1366/2 768/2]); %top left corner of my laptop. 
% [c.win, winRect] = Screen('OpenWindow', screenNumber, [],[0 0 1280 720],[],2); %top left quarter of mac in lab, for debugging
[c.mx, c.my] = RectCenter(c.winRect);

% Set fonts
Screen('TextFont',c.win,'Arial');
Screen('TextSize',c.win,20);
% Screen('FillRect', c.win, 0);  % 0 = black background
% c.textColor = 255;
c.textColor = 0; 

% % Print a loading screen
% DrawFormattedText(c.win, 'Loading -- the experiment will begin shortly','center','center',0);
% Screen('Flip',c.win);


ListenChar(2) %Ctrl-c to enable Matlab keyboard interaction.
% ShowHideWinTaskbarMex(0);
% HideCursor; % Remember to type ShowCursor or sca later

end