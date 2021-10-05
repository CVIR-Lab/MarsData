function mae = MAE2(smap, gtImg)
% Code Author: Wangjiang Zhu
% Email: wangjiang88119@gmail.com
% Date: 3/24/2014
smap = im2double(smap);
gtImg = im2double(gtImg);
if size(smap,3) > 1
    smap = smap(:,:,1);
end
if size(gtImg,3) > 1
    gtImg = gtImg(:,:,1);
end
if size(smap,1)~=size(gtImg,1) || size(smap,2)~=size(gtImg,2)
    smap = imresize(smap, size(gtImg));
end
smap = ( smap - min(smap(:)) ) ./ ( max(smap(:)) - min(smap(:)) );
gtImg = ( gtImg - min(gtImg(:)) ) ./ ( max(gtImg(:)) - min(gtImg(:)) );
smap = im2uint8(smap);
gtImg = im2uint8(gtImg);


if size(smap, 1) ~= size(gtImg, 1) || size(smap, 2) ~= size(gtImg, 2)
    error('Saliency map and gt Image have different sizes!\n');
end

if ~islogical(gtImg)
    gtImg = gtImg(:,:,1) > 25;
end

smap = im2double(smap(:,:,1));
fgPixels = smap(gtImg);
fgErrSum = length(fgPixels) - sum(fgPixels);
bgErrSum = sum(smap(~gtImg));
mae = (fgErrSum + bgErrSum) / numel(gtImg);