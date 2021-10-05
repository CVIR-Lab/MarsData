function meanWF = CalMeanWF(algPath, algSuffix, gtPath, gtSuffix, Betas)

algFiles = dir(fullfile(algPath, strcat('*', algSuffix)));
gtFiles = dir(fullfile(gtPath, strcat('*', gtSuffix)));

if length(algFiles) ~= length(gtFiles)
    error('the number of files is mismatching');
end

imgFmeasures = zeros(length(algFiles), length(Betas));
for i = 1:length(algFiles)
    algImgName = algFiles(i).name;
    gtImgName = strrep(algImgName, algSuffix, gtSuffix);
    if strfind( algImgName(1:strfind(algImgName,'DXXX')-1), gtImgName(1:strfind(gtImgName,'DXXX')-1) )
        % get ground truth
        GT =  imread(fullfile(gtPath,strcat(gtImgName(1:strfind(algImgName,'DXXX')+3),'.png')));
       
        % get foreground map
        FG = imread(fullfile(algPath,algImgName));
        
        % compute weighted F-measure
        Fmeasures = zeros(1,length(Betas));
        for k = 1:length(Betas)
            Fmeasure = WFb(FG, GT, Betas(k));
            Fmeasures(k) = Fmeasure;
        end

    else
        error('Img name is mismatching.');
    end
    imgFmeasures(i,:) = Fmeasures;  
end

for i = 1:size(imgFmeasures,1)
    for j = 1:size(imgFmeasures,2)
        if isnan(imgFmeasures(i,j))
            imgFmeasures(i,j) = 0;
        end
    end
end
    meanWF = mean(imgFmeasures, 1);    
    %fprintf('WF for %s: %s\n', salSuffix, num2str(meanWF));
end