function [meanOverlapRatio] = CalOverlap_Batch(algPath, algSuffix, gtPath, gtSuffix, setCurve, color)
    
    algFiles = dir(fullfile(algPath, strcat('*', algSuffix)));  
    gtFiles = dir(fullfile(gtPath, strcat('*', gtSuffix)));

    if length(algFiles) ~= length(gtFiles)
        error('the number of files is mismatching');
    end
    
    if setCurve
        imgOverlapRatio = zeros(length(algFiles), length(0:1:255));
    else
        imgOverlapRatio = zeros(length(algFiles), 1);
    end
    for i = 1:length(algFiles)
        algImgName = algFiles(i).name;
        gtImgName = strrep(algImgName, algSuffix, gtSuffix);
        if strfind( algImgName(1:strfind(algImgName,'DXXX')-1), gtImgName(1:strfind(gtImgName,'DXXX')-1) )
            % get ground truth
            GT = imread(fullfile(gtPath,strcat(gtImgName(1:strfind(algImgName,'DXXX')+3),'.png')));
            
            % get foreground map
            FG = imread(fullfile(algPath,algImgName));
            
            % compute weighted F-measure            
            imgOverlapRatio(i,:) = CalOverlapRatio(FG, GT, setCurve);
        else
            error('Img name is mismatching.');
        end
    end
    
    meanOverlapRatio = mean(imgOverlapRatio, 1);
    if ~strcmp(color, '0')
        plot(meanOverlapRatio, 'color', rand(1,3), 'linewidth', 2);
    end
end