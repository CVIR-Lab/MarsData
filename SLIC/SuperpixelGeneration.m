function [idxImg, adjcMatrix, pixelList] = SuperpixelGeneration(Img, spn, comp)
[idxImg, spNum] = SLIC_mex(Img, spn, comp);
%%
adjcMatrix = GetAdjMatrix(idxImg, spNum);
%%
pixelList = cell(spNum, 1);
for n = 1:spNum
    pixelList{n} = find(idxImg == n);
end