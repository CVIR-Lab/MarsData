function Z = Z_update(P, E, mu, L1_mu,L2_mu,I)
temp = 0.5.* ( I - P + E + L1_mu - L2_mu);
[U,T,V] = svd(temp,'econ');
%         [U,T,V] = svd(temp);
T = diag(T);
svp = length(find(T>(1/(2*mu))));

if svp>=1
    T = T(1:svp)-1/(2*mu);
else
    svp = 1;
    T = 0;
end
Z = U(:,1:svp) * diag(T) * V(:,1:svp)';
%     Z(Z<0)=0;
