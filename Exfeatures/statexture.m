function t = statexture(grayimGT,pixelList)
for i = 1:length(pixelList)
subregion = grayimGT(pixelList{i});
p = imhist(subregion);
p = p./numel(subregion);
L = length(p);
[~,mu] =  statmoments(p,3);
% mean value 
t(i,1) = mu(1);
% standard deviation
% t(i,2) = mu(2).^0.5;
% smoothness
% first normalize the variance to [0,1] by dividing it by £¨L-1)^2
% varn = mu(2)/(L-1)^2;
% t(i,3) =  1/(1+varn);
% Third moment(normalized by (L-1)^2 also)
% t(i,4) = mu(3)/(L-1)^2;
% uniformly
% t(i,5) = sum(p.^2);
% entropy 
% t(i,6) = -sum(p.*(log2(p+eps)));
end
end
function[v,unv] = statmoments(p,n)
Lp = length(p);
if Lp~= 256
    error('P must be a 256 vector');
end
G = Lp-1;
p = p/sum(p);
p = p(:);
z = 0:G;
% Normalize the z's to the range [0,1]
z = z./G;
% the mean
m = z*p;
% center random variable about the mean
z = z-m;
% compute the central moments
v = zeros(1,n);
v(1) = m;
for j = 2:n
    v(j) = (z.^j)*p;
end
if nargout >1
    %compute the uncetralized moments
    unv = zeros(1,n);
    unv(1)= m.*G;
    for j = 2:n
        unv(j) = ((z*G).^j)*p;
    end
end
end