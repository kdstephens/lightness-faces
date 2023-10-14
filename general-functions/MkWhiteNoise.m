function Noise = MkWhiteNoise( SizeX, SizeY )
%Noise = MkWhiteNoise( SizeX, SizeY )
%This function generates Gaussian white noise
%by setting each pixel to a value drawn randomly
%from a normal distribution with mean equal to neutral gray.

if nargin < 2
    SizeY = SizeX;
end

Noise = 127 + 42*randn(SizeY, SizeX);
Noise = uint8(Noise) +1;

% showImage(Noise, 'grayscale');

end

