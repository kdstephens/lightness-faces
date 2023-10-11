function [input, t] = GetEchoInput (win, wd, stimuli, inputType, allowedInputs,...
                               displayMsg, x, y)

% [input, t] = GetEchoInput(win, stimuli, inputType, allowedInputs,...
%                                                   displayMsg, x, y)
%
% Adapted from GetEchoString.m. For inputTypes see isstrprop.m (typical
% examples: 'digit', 'alpha'). allowedInputs is a cell that gives the set 
% of inputs the user is allowed. x and y are the screen coordinates for the
% given displayMsg.

FlushEvents;
input = ''; %initialize input string
isValid = 0; %start by assuming their input is not valid

%Getting input
while true
    [char, when] = GetChar;
    if isempty(char)
        input = '';
        return;
    end
    switch (abs(char))
        case{13, 3, 10}
            % ctrl-C, enter, or return
            %checking input against those allowed
            if isstrprop(input, inputType) %if input is of the given type
                for i = 1:length(allowedInputs)
                    if strcmp(input, allowedInputs{i}) %if input is one of the allowedInputs
                        isValid = 1;
                    end
                end
                if isValid
                    isValid = 0; %reset
                    break; 
                end
                input = '';
            else
                input = '';
                %                    return;
            end   
        case 8
            % backspace
            if ~isempty(input)
                input = input(1:length(input)-1);
            end   
        otherwise
            input = [input, char]; %ok<AGROW>
    end
    
    output = [displayMsg, ' ', input]; %output echoes input
    
    %update other side of screen with new message (+ everything from
    %before) and flip.
    screenImg = Screen('MakeTexture', win, stimuli);
    Screen('DrawTexture', win, screenImg);
    %        Screen('DrawText', win, output, x, y);
    DrawFormattedText(win, output, x, y);
    Screen('Flip', win);
end

t = when.secs;
cd(wd)