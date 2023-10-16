function [gender, ethnicity] = GetSubjectMakeup(ancillarySubData)

% [gender, ethnicity] = GetSubjectMakeup(ancillarySubData)
% 
% Given an ancillarySubData cell (Each row of is a subject. The four 
% columns give age, gender, ethnicity, and handedness), gives the 
% male-female makeup and the ethnicity make-up of the subject population. 

%% Initialization
nSubs = size(ancillarySubData,1); 
gender.nMale = 0; 
gender.nFem = 0;
gender.nOther = 0; 
ethnicity.nWhite = 0; 
ethnicity.nHisp = 0; 
ethnicity.nBlack = 0; 
ethnicity.nNative = 0; 
ethnicity.nAsian = 0; 
ethnicity.nOther = 0; 


%% Getting info
for sub = 1:nSubs
    
    %Gender
    switch ancillarySubData{sub, 2}
        case 1
            gender.nMale = gender.nMale + 1; 
        case 2
            gender.nFem = gender.nFem + 1; 
        otherwise
            gender.nOther = gender.nOther + 1; 
    end
    
    %Ethnicity
    switch ancillarySubData{sub, 3}
        case 1
           ethnicity.nWhite = ethnicity.nWhite + 1; 
        case 2
            ethnicity.nHisp = ethnicity.nHisp + 1; 
        case 3
            ethnicity.nBlack = ethnicity.nBlack + 1; 
        case 4
            ethnicity.nNative = ethnicity.nNative + 1; 
        case 5
            ethnicity.nAsian = ethnicity.nAsian + 1; 
        otherwise
            ethnicity.nOther = ethnicity.nOther + 1; 
    end
    
end
    
