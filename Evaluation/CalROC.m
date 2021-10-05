function [TPR, FPR] = CalROC(FG, GT, thresholds)

% check input
GT = im2double(GT);
if size(GT,3)>1
    GT = GT(:,:,1);
end
FG = im2double(FG);
if size(FG, 3)>1
    FG = FG(:,:,1);
end
if size(GT,1)~=size(FG,1) || size(GT,2)~=size(FG,2)
    FG = imresize(FG, [size(GT,1), size(GT,2)]);
end
FG = ( FG - min(FG(:)) ) ./ ( max(FG(:)) - min(FG(:)) );
GT = ( GT - min(GT(:)) ) ./ ( max(GT(:)) - min(GT(:)) );


TPR = zeros(1,length(thresholds));
FPR = zeros(1,length(thresholds));
for k = 1:length(thresholds)
    tt = thresholds(k);
    TP = sum(sum((FG>=tt) & (GT>0.1)));
    FP = sum(sum((FG>=tt) & (GT<=0.1)));

    P = sum(sum(GT>0.1));
    N = sum(sum(GT<=0.1));
    if P ~= 0 && N ~= 0
        TPR(k) = TP/P;
        FPR(k) = FP/N;
    elseif P == 0 && N ~= 0
        TPR(k) =  0;
        FPR(k) = FP/N;
    elseif P ~= 0 && N == 0
        TPR(k) = TP/P;
        FPR(k) = 0;
    else    
        TPR(k) = 0;
        FPR(k) = 0;
    end
end
    
end