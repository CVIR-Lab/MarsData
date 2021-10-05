function [Q]= WFb(FG,GT,Beta2)
% WFb Compute the Weighted F-beta measure (as proposed in "How to Evaluate
% Foreground Maps?" [Margolin et. al - CVPR'14])
% Usage:
% Q = FbW(FG,GT)
% Input:
%   FG - Binary/Non binary foreground map with values in the range [0 1]. Type: double.
%   GT - Binary ground truth. Type: logical.
% Output:
%   Q - The Weighted F-beta score

%Check input
GT = im2double(GT);
if size(GT,3)>1
    GT = GT(:,:,1);
end
% get foreground map
FG = im2double(FG);
if size(FG, 3)>1
    FG = FG(:,:,1);
end
if size(GT,1)~=size(FG,1) || size(GT,2)~=size(FG,2)
    FG = imresize(FG, [size(GT,1), size(GT,2)]);
end
FG = ( FG - min(FG(:)) ) ./ ( max(FG(:)) - min(FG(:)) );
GT = ( GT - min(GT(:)) ) ./ ( max(GT(:)) - min(GT(:)) );
GT = logical(GT>0.1); % pixels whose value>0.1 are annotated as groud truth.

if (~isa( FG, 'double' ))
    error('FG should be of type: double');
end
if ((max(FG(:))>1) || min(FG(:))<0)
    error('FG should be in the range of [0 1]');
end
if (~islogical(GT))
    error('GT should be of type: logical');
end
if nargin < 3
    Beta2 = 1;
end

dGT = double(GT); %Use double for computations.

E = abs(FG-dGT);
% [Ef, Et, Er] = deal(abs(FG-GT));

[Dst,IDXT] = bwdist(dGT);
if sum(IDXT) ==0
    Q = 1;
    return;
end
%Pixel dependency
K = fspecial('gaussian',7,5);
Et = E;
Et(~GT)=Et(IDXT(~GT)); %To deal correctly with the edges of the foreground region
EA = imfilter(Et,K);
MIN_E_EA = E;
MIN_E_EA(GT & EA<E) = EA(GT & EA<E);
%Pixel importance
B = ones(size(GT));
B(~GT) = 2-1*exp(log(1-0.5)/5.*Dst(~GT));
Ew = MIN_E_EA.*B;

TPw = sum(dGT(:)) - sum(sum(Ew(GT))); 
FPw = sum(sum(Ew(~GT)));

R = 1- mean2(Ew(GT)); %Weighed Recall
P = TPw./(eps+TPw+FPw); %Weighted Precision

%Q = (2)*(R*P)./(eps+R+P); %Beta=1;
Q = (1+Beta2)*(R*P)./(eps+R+(Beta2.*P));
end