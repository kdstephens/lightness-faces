function subID = GetNextSubID(subDir, wd)
%function subID = GetNextSubID(datafolder, wd)
% Takes in the subject data directory, subDir, and figures out 
% the next subject ID number, SubID, based on the file names in datafolder.
% returns to the working directory, wd, when finished. 

cd (subDir) %only works if datafolder is in the current working directory
datlist = dir('*.mat');
if size(datlist,1) == 0
    subID = 1;
else
    for i = 1:size(datlist,1)
        m = strvcat(datlist(i).name); %stores the file name as Char entries in a matrix
        m = m(1:length(m)-4);         %removes '.mat' from the file-name matrix
        n(i) = str2num(m);            %#ok<AGROW,*ST2NM,*VCAT>
    end
    sublist = sort(n);
    lastsub = sublist(length(sublist));
    subID = lastsub+1;
end
cd(wd)  %returns to the current working directory