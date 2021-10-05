function [meanP,meanR,meanF] = CalMeanFmeasure(algPath, algSuffix, gtPath, gtSuffix, setCurve, color)

    algFiles = dir(fullfile(algPath, strcat('*', algSuffix)));  
    gtFiles = dir(fullfile(gtPath, strcat('*', gtSuffix)));

    if length(algFiles) ~= length(gtFiles)
        error('the number of files is mismatching');
    end
    
    if setCurve
        imgFmeasures = zeros(length(algFiles), length(0:1:255));
        imgAvgPres = zeros(length(algFiles), length(0:1:255));
        imgAvgRecs = zeros(length(algFiles), length(0:1:255));
    else
        imgFmeasures = zeros(length(algFiles), 1);
        imgAvgPres = zeros(length(algFiles), 1);
        imgAvgRecs = zeros(length(algFiles), 1);
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
            [Pres, Recs, Fmeasures] = Fmeasure(FG, GT, setCurve);
        else
            error('Img name is mismatching.');
        end
        imgAvgPres(i,:) = Pres;        
        imgAvgRecs(i,:) = Recs;
        imgFmeasures(i,:) = Fmeasures;  
    end
        meanF = mean(imgFmeasures, 1);
        meanP = mean(imgAvgPres,1);
        meanR = mean(imgAvgRecs,1);
        if ~strcmp(color, '0')
            plot(meanF, 'color', rand(1,3), 'linewidth', 2);
        %else
        %    fprintf('Fmeasure for %s: %s\n', salSuffix, num2str(meanF));
        end
end