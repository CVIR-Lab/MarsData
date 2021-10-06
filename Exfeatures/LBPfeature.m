function textCellHists = LBPfeature(GrayImg,idxImg,pixelList)
[FX,FY] = gradient(double(GrayImg));
NI = max(idxImg(:));
for k = 1:NI
  subFX = FX(pixelList{k});
  subFY = FY(pixelList{k});
%   normsubFX(k,1) = norm(subFX,1);  
%   normsubFY(k,1) = norm(subFY,1);  
  meansubFX(k,1) = mean(abs(subFX));
  meansubFY(k,1) = mean(abs(subFY));
end
% normsubFX = normalization(normsubFX);
% normsubFY = normalization(normsubFY);
meansubFX = normalization(meansubFX);
meansubFY = normalization(meansubFY);

textCellHists = [meansubFX,meansubFY];
% textCellHists = [normsubFX,normsubFY,meansubFX,meansubFY];
end