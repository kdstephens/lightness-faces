function varargout = RepAndPermVects(numRepeats, isSameRndOrdr, varargin)

% varargout = RepAndPermVects(numRepeats,isSameRndOrdr,varargin)
%
% takes in possibly multiple input vectors (in the cell varargin) copies 
% each element of each vector numRepeats number of times and then randomly 
% permutes each vector into a larger vector. if isSameRndOrdr is set to 1, 
% uses the same random ordering for each ouput vector.

for i = 1:length(varargin)
    output = repmat(varargin{i}, numRepeats, 1);
    if i==1
        rndOrdr = randperm(size(output,1));
    elseif ~isSameRndOrdr %then use a new rndOrdr for each input vector
        rndOrdr = randperm(size(output,1));
    end
    varargout{i} = output(rndOrdr);
end