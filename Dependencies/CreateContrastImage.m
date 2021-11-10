function [img, ContrastValue] = CreateContrastImage(ContrastValue, pixelList, r, c)

if (~iscell(pixelList))
    error('pixelList should be a cell');
end

if (length(pixelList) ~= length(ContrastValue))
    error('different sizes in ContrastValue and pixelList');
end

img = zeros(r, c);
for i=1:length(pixelList)
    img(pixelList{i}) = ContrastValue(i);
end
