function FstSndAdjMat = GetFstSndAdjMat(idxImg, spn)
% FUNCTION: Get the first and second order reachable matrix
% INPUT:
%   idxImg          --   superpixel labels
%   spn          --   superpixel number
% OUTPUT:
%   FstAdjMat             --  the first order reachable matrix
%   FstSndAdjMat          --  the first and second order reachable matrix
%   FstSndAdjMat_lowTri   --  the lower triangular matrix of the first and second order reachable matrix

    height = size(idxImg,1);
    %Get edge pixel locations (4-neighbor)
    topbotDiff = diff(idxImg, 1, 1) ~= 0; 
    topEdgeIdx = find( padarray(topbotDiff, [1 0], false, 'post') ); %those pixels on the top of an edge

    botEdgeIdx = topEdgeIdx + 1;
    leftrightDiff = diff(idxImg, 1, 2) ~= 0;
    leftEdgeIdx = find( padarray(leftrightDiff, [0 1], false, 'post') ); %those pixels on the left of an edge
    rightEdgeIdx = leftEdgeIdx + height;
    %Get the first order reachable matrix
    FstAdjMat = zeros(spn, spn);
    FstAdjMat( sub2ind([spn, spn], idxImg(topEdgeIdx), idxImg(botEdgeIdx)) ) = 1;
    FstAdjMat( sub2ind([spn, spn], idxImg(leftEdgeIdx), idxImg(rightEdgeIdx)) ) = 1;
    FstAdjMat = FstAdjMat + FstAdjMat';
    FstAdjMat(1:spn+1:end) = 1;    %set diagonal elements to 1
    FstAdjMat = sparse(FstAdjMat);
%     FstSndAdjMat = double(FstAdjMat);
    % Get the first and second order reachable matrix
    FstSndAdjMat = (FstAdjMat * FstAdjMat + FstAdjMat) > 0;
    FstSndAdjMat = double(FstSndAdjMat);
    % return lower triangular matrix
%     FstSndAdjMat_lowTri = tril(FstSndAdjMat, -1);
end