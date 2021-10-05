function [Pre, Rec] = CalPreRecCurve(algPath, algSuffix, gtPath, gtSuffix, thresholds, color)
    
    algFiles = dir(fullfile(algPath, strcat('*', algSuffix)));
    gtFiles = dir(fullfile(gtPath, strcat('*', gtSuffix)));

    if length(algFiles) ~= length(gtFiles)
        error('the number of files is mismatching');
    end
    
    imgPre = zeros(length(gtFiles), length(thresholds));
    imgRec = zeros(length(gtFiles), length(thresholds));
    for i = 1:length(gtFiles)
        algImgName = algFiles(i).name;
        gtImgName = strrep(algImgName, algSuffix, gtSuffix);
        if strfind( algImgName(1:strfind(algImgName,'.')-1), gtImgName(1:strfind(gtImgName,'.')-1) )
            % get ground truth
            GT = imread(fullfile(gtPath,gtImgName));
                        
            % get foreground map
            FG = imread(fullfile(algPath,algImgName));
            
            % compute precision and recall
            for k = 1:length(thresholds)
                [imgPre(i, k), imgRec(i, k)] = CalPreRec(FG, GT, thresholds(k));
            end
        else
            error('Img name is mismatching.');
        end
    end
    Pre = mean(imgPre, 1);
    Rec = mean(imgRec, 1);
    
    if ~strcmp(color, '0')
        plot(Rec, Pre, color, 'linewidth', 2);
    end
    
end


