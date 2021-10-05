function [overlapRatio] = CalOverlapRatio(FG, GT, setCurve)
    %Check input    
    if size(FG,3) ==3
        FG = FG(:,:,1);
    end
    FG = im2double(FG);
    if size(GT,3) == 3 
        GT = GT(:,:,1);         
    end
    GT = im2double(GT);
    if size(FG,1)~=size(GT,1)  ||  size(FG,2)~=size(GT,2)            
        FG = imresize(FG, size(GT));
    end
    FG = ( FG - min(FG(:)) ) ./ ( max(FG(:)) - min(FG(:)) );
    GT = ( GT - min(GT(:)) ) ./ ( max(GT(:)) - min(GT(:)) );
    FG = im2uint8(FG);
    GT = im2uint8(GT);

    
    % calculate
    if setCurve
        threshold = 0:1:255;
    else
        threshold = mean(FG(:))*2;
    end
    overlapRatio = zeros(1,length(threshold));
    parfor i = 1:length(threshold)
        intersection = sum(sum((FG>=threshold(i)) & (GT>25)));
        union = sum(sum((FG>=threshold(i)) | (GT>25)));
        if intersection ~= 0
            overlapRatio(1,i) = intersection/union;  
        else
            overlapRatio(1,i) = 0;
        end
    end
    
end