function WeightOnEdge = ComputeWeight(KernelDist, FstSndAdjMat_lowTri_Back,Sig)
    distMatEdge = KernelDist(FstSndAdjMat_lowTri_Back>0);
%     distMatEdge(distMatEdge > 3 * Sig) = Inf;   %cut off > 3 * sigma distances
    distMatEdge = mapminmax(distMatEdge',0,1)'; % row normalize to [0,1] 
    WeightOnEdge = distMatEdge;
    % get the weights on edges
%     WeightOnEdge = exp((-1/2*Sig)*distMatEdge);
    % weightOnEdge = exp(-distMatEdge.^2 ./ (2 * Sigma * Sigma) );
%     WeightOnEdge = mapminmax(WeightOnEdge',0,1)'; % row normalize to [0,1] 
%     WeightOnEdge = (WeightOnEdge - min(WeightOnEdge)) / (max(WeightOnEdge) - min(WeightOnEdge) + eps);
