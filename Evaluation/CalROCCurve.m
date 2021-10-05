function [TPR, FPR] = CalROCCurve(algPath, algSuffix, gtPath, gtSuffix, thresholds, color)
    
    algFiles = dir(fullfile(algPath, strcat('*', algSuffix)));
    gtFiles = dir(fullfile(gtPath, strcat('*', gtSuffix)));

    if length(algFiles) ~= length(gtFiles)
        error('the number of files is mismatching');
    end
    
    imgTPR = zeros(length(gtFiles), length(thresholds));
    imgFPR = zeros(length(gtFiles), length(thresholds));
    parfor i = 1:length(gtFiles)
        algImgName = algFiles(i).name;
        gtImgName = strrep(algImgName, algSuffix, gtSuffix);
        if strfind( algImgName(1:strfind(algImgName,'DXXX')-1), gtImgName(1:strfind(gtImgName,'DXXX')-1) )
            % get ground truth
            GT = imread(fullfile(gtPath,strcat(gtImgName(1:strfind(algImgName,'DXXX')+3),'.png')));
           
            % get foreground map
            FG = im2double(imread(fullfile(algPath,algImgName)));
              
            % compute precision and recall
            [imgTPR(i,:), imgFPR(i,:)] = CalROC(FG, GT, thresholds);
        else
            error('Img name is mismatching.');
        end
    end
    TPR = mean(imgTPR, 1);
    FPR = mean(imgFPR, 1);

%     if ~strcmp(color, '0')
%         plot(FPR, TPR, color, 'linewidth', 2);
%     end
    
end