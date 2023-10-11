function [imgsRGB imgNames] = GetImgs(imgDir, wd, imgNames, imgType, rescaleVal)

% [imgsRGB imgNames] = GetImgs(imgDir, wd, imgNames, imgType, rescaleVal)
%
% returns a cell column vector with the RGB images and image names. Can
% also take in the image names and only retreive certain
% desired images. Returns to the given working directory when finished.
% Also allows for a rescale value, in case the user wants the images to be
% re-sized to a scaled version of their current size. 

cd(imgDir)

if nargin < 5
    rescaleVal = 1; 
end

if nargin > 3 %then imgType given; assumes user wants all images of given type from the given directory
    imgStruct = dir(imgType);
    imgNames = {imgStruct.name}';
end
%if ~nargin>3, then imgNames specified in input.

%read imgs
imgsRGB = cell(length(imgNames),1); %initialize
for i = 1:length(imgNames)
    imgsRGB{i} = imread(imgNames{i});
    if rescaleVal ~= 1
        imgsRGB{i} = imresize(imgsRGB{i}, rescaleVal);
    end
end
cd(wd)