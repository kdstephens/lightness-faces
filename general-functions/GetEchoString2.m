function string = GetEchoString2(windowPtr, msg, x, y, textColor, bgColor, useKbCheck, varargin)
% string = GetEchoString(window, msg, x, y, [textColor], [bgColor], [useKbCheck=0], [deviceIndex], [untilTime=inf], [KbCheck args...])
% 
% Get a string typed at the keyboard. Entry is terminated by
% <return> or <enter>.
%
% Typed characters are displayed in the window. The delete
% character is handled correctly. Useful for i/o in a Screen window.
%
% If the optional flag 'useKbCheck' is set to 1 then KbCheck is used - with
% potential optional additional 'KbCheck args...' for getting the string
% from the keyboard. Otherwise GetChar is used. 'useKbCheck' == 1 is
% restricted to standard alpha-numeric keys (characters, letters and a few
% special symbols). It can't handle all possible characters and doesn't
% work with non-US keyboard mappings. Its advantage is that it works
% reliably on configurations where GetChar may fail, e.g., on MS-Vista and
% Windows-7.
%
% See also: GetNumber, GetString, GetEchoNumber
%

% 2/4/97    dhb       Wrote GetEchoNumber.
% 2/5/97    dhb       Accept <enter> as well as <cr>.
%           dhb       Allow string return as well.
% 3/3/97    dhb       Updated for new DrawText.  
% 3/15/97   dgp       Created GetEchoString based on dhb's GetEchoNumber.
% 3/20/97   dhb       Fixed bug in erase code, it wasn't updated for new
%                       initialization.
% 3/31/97   dhb       More fixes for same bug.
% 2/28/98   dgp       Use GetChar instead of obsolete GetKey. Use SWITCH and LENGTH.
% 3/27/98   dhb       Put an abs around char in switch.
% 12/26/08  yaosiang  Port GetEchoString from PTB-2 to PTB-3.
% 03/20/08  tsh       Added FlushEvents at the start and made bgColor and
%                     textcolor optional
% 10/22/10  mk        Optionally allow to use KbGetChar for keyboard input.
% 02/25/14  KDS       Changed Screen('DrawText'..) to DrawFormattedText(..)
%                     (lines 60 and 91). Also added wrapat for
%                     DrawFormattedText so that subject's typing doesn't go
%                     off screen (line 68). Also only returns if the user
%                     inputs something, even if they hit enter. 

if nargin < 7
    useKbCheck = [];
end

if isempty(useKbCheck)
    useKbCheck = 0;
end

if nargin < 6
    bgColor = [];
end

if nargin < 5
    textColor = [];
end

if ~useKbCheck
    % Flush the keyboard buffer:
    FlushEvents;
end

% Write the message
% % Screen('DrawText', windowPtr, msg, x, y, textColor, bgColor);
% DrawFormattedText(windowPtr, msg, x, y, textColor); <--- have to put DrawFormattedText before calling this fuction
% Screen('Flip', windowPtr, 0, 1);

string = '';
wrapat = 80; %characters
while true
    if useKbCheck
        char = GetKbChar(varargin{:});
    else 
        char = GetChar;
    end

    if isempty(char)
        string = '';
        return;
    end
        
    switch (abs(char))
        case {13, 3, 10}
            % ctrl-C, enter, or return
            if ~isempty(string) %only break if the user inputs something (i.e., they HAVE to input something). 
                break;
            end
        case 8
            % backspace
            if ~isempty(string)
                string = string(1:length(string)-1);
            end
        otherwise
            string = [string, char]; %#ok<AGROW>
    end

    output = [msg, ' ', string];
%     Screen('DrawText', windowPtr, output, x, y, textColor, bgColor);
    DrawFormattedText(windowPtr, output, x, y, textColor, wrapat);
    Screen('Flip', windowPtr);
end
