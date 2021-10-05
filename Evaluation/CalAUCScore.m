function [AUC] = CalAUCScore(algPath, algSuffix, gtPath, gtSuffix)
    
    algFiles = dir(fullfile(algPath, strcat('*', algSuffix)));
    gtFiles = dir(fullfile(gtPath, strcat('*', gtSuffix)));
    if length(algFiles) ~= length(gtFiles)
        error('the number of files is mismatching');
    end
    
    imgAUC = zeros(length(gtFiles), 1);
    for i = 1:length(gtFiles)
        algImgName = algFiles(i).name;        
        gtImgName = strrep(algImgName, algSuffix, gtSuffix);
        
        if strfind( algImgName(1:strfind(algImgName,'DXXX')-1), gtImgName(1:strfind(gtImgName,'DXXX')-1) )
            % get ground truth
            GT = imread(fullfile(gtPath,strcat(gtImgName(1:strfind(algImgName,'DXXX')+3),'.png')));
                        
            % get foreground map
            FG = imread(fullfile(algPath,algImgName));
            
            % compute precision and recall
            imgAUC(i) = AUC_Borji(FG, GT, 10, 0.1, 0);
            
        else
            error('Img name is mismatching.');
        end
    end
    imgAUC(isnan(imgAUC)) = 0;
    AUC = mean(imgAUC, 1);
end