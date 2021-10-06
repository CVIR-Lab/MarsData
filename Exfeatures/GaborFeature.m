function featMat = GaborFeature(GrayImg,pixelList)
[h,w,c] = size(GrayImg);
featureimg = zeros(h,w,c);
pos = 1;
%% gabor filter
scales =3;
directions =6;
[EO, BP] = gaborconvolve(GrayImg, scales, directions, 6,0.5,0.65);%6,0.5,0.65

for wvlength = 1:scales
    for angle = 1:directions
        Aim = abs(EO{wvlength,angle});
        maxres = max(Aim(:));
        for i = 1:h
            for j = 1:w
                featureimg(i,j,pos) = Aim(i,j)/maxres*255;
            end
        end
        pos = pos+1;
    end
end
featMat = GetMeanFeat(featureimg, pixelList);  
featMat = featMat./255;
% featMat = mat2gray(featMat);

