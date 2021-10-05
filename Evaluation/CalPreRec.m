function [pre, rec] = CalPreRec(FG, GT, threshold)
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

    TP = sum(sum((FG>=threshold) & (GT>0.1)));
    gtFGPix = sum(GT(:)>0.1);
    algFGPix = sum(sum(FG>=threshold));
    
    if algFGPix~=0 && gtFGPix~=0
        pre = TP/algFGPix;
        rec = TP/gtFGPix;
    elseif algFGPix == 0 && gtFGPix~=0
        pre = 0;
        rec = TP/gtFGPix;
    elseif algFGPix~=0 && gtFGPix == 0
        pre = TP/algFGPix;
        rec = 0;
    else
        pre = 0;
        rec = 0;
    end
    
end