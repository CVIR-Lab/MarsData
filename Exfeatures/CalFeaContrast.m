function [FC,KRC]=CalFeaContrast(F_map,MeanPos,pixelList,rr,cc)
KpcaFeaDistM = GetDistanceMatrix((F_map)); % the distance of KPCA feature between two subregions 
posDistM = GetDistanceMatrix(MeanPos); % the distance of intensity between two subregions
spaSigma =1;     %sigma for spatial weight0.7,1
PosWeight = Dist2WeightMatrix(posDistM, spaSigma);
% KpcaFeaDistM = F_map;
% KRC = KpcaFeaDistM.* PosWeight;
% KRC = KpcaFeaDistM;
KRC = mapminmax(sum(KpcaFeaDistM,1),0,1);
% KRC = (KRC - min(KRC)) / (max(KRC) - min(KRC) + eps);
KRC = (KRC - min(KRC)) / (max(KRC) - min(KRC) );


% removeLowVals = true;
% if removeLowVals
% %     thresh = max(graythresh(KRC),0.75);  %ostu method
%     thresh = graythresh(KRC);  %ostu method
%     KRC(KRC < thresh) = 0;
% end
[FC, ~] = CreateContrastImage(KRC, pixelList, rr, cc);
FC = mat2gray(FC);
