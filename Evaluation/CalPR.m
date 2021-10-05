function [precision, recall] = CalPR(smapImg, gtImg, targetIsFg, targetIsHigh)
% Code Author: Wangjiang Zhu
% Email: wangjiang88119@gmail.com
% Date: 3/24/2014

smapImg = im2double(smapImg);
gtImg = im2double(gtImg);
if size(smapImg,3) > 1
    smapImg = smapImg(:,:,1);
end
if size(gtImg,3) > 1
    gtImg = gtImg(:,:,1);
end
if size(smapImg,1)~=size(gtImg,1) || size(smapImg,2)~=size(gtImg,2)
    smapImg = imresize(smapImg, size(gtImg));
end
smapImg = ( smapImg - min(smapImg(:)) ) ./ ( max(smapImg(:)) - min(smapImg(:)) );
gtImg = ( gtImg - min(gtImg(:)) ) ./ ( max(gtImg(:)) - min(gtImg(:)) );
smapImg = im2uint8(smapImg);
gtImg = im2uint8(gtImg);

if ~islogical(gtImg)
    gtImg = gtImg(:,:,1) > 25;
end
if any(size(smapImg) ~= size(gtImg))
    error('saliency map and ground truth mask have different size');
end

if ~targetIsFg
    gtImg = ~gtImg;
end

gtPxlNum = sum(gtImg(:));

targetHist = histc(smapImg(gtImg), 0:255);
nontargetHist = histc(smapImg(~gtImg), 0:255);

if targetIsHigh
    targetHist = flipud(targetHist);
    nontargetHist = flipud(nontargetHist);
end
targetHist = cumsum( targetHist );
nontargetHist = cumsum( nontargetHist );

precision = targetHist ./ (targetHist + nontargetHist);

if any(isnan(precision))
    warning('there exists NAN in precision, this is because of your saliency map do not have a full range specified by cutThreshes\n');    
end

recall = targetHist / gtPxlNum;
recall(recall==Inf) = 1;
recall(isnan(recall)) = 1;
precision(precision==Inf) = 1;
precision(isnan(precision)) = 1;