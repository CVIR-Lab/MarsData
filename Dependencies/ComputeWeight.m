function weightOnEdge = ComputeWeight(KernelDist, fstSndReachMat_lowTri_Back,Sig)
    % convert distance matrix to vector
    distMatEdge = KernelDist(fstSndReachMat_lowTri_Back>0);
%      distMatEdge = KernelDist;
    %distMatEdge = normalize(distMatEdge); % row normalize to [0,1] 
    distMatEdge = mapminmax(distMatEdge',0,1)'; % row normalize to [0,1] 
    % get the weights on edges
    weightOnEdge = exp((-1/Sig)*distMatEdge);
    % weightOnEdge = exp(-distMatEdge.^2 ./ (2 * Sigma * Sigma) );