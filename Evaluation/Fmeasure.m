function [Pres, Recs, Fmeasures] = Fmeasure(FG, GT, setCurve)
    
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
    Fmeasures = zeros(1,length(threshold));
    Pres = zeros(1,length(threshold));
    Recs = zeros(1,length(threshold));
    for i = 1:length(threshold)
        TP = sum(sum((FG>=threshold(i)) & (GT>25)));
        algFGPix = sum(sum(FG>=threshold(i)));
        gtFGPix = sum(sum(GT>25));
        if algFGPix == 0
            Pres(1,i) = 0;
        else
            Pres(1,i) = TP/algFGPix;
        end
        if gtFGPix == 0
            Recs(1,i) = 0;
        else
            Recs(1,i) = TP/gtFGPix;
        end
        if  Pres(1,i) == 0 && Recs(1,i) == 0
            Fmeasures(1,i) = 0;
        else
            Fmeasures(1,i) = 1.3* Pres(1,i)* Recs(1,i)/(0.3* Pres(1,i)+ Recs(1,i));
        end
    end

end
