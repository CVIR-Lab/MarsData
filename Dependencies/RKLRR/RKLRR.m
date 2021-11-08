function [Z,P,time_cost_ZPE] = RKLRR( lambda, K)
[VK,Sigma_2,~] = svd(K);
sigmaK = sqrt(diag(Sigma_2));
rk = sum(sigmaK>sigmaK(1)*1e-3);
sigmaK = sigmaK(1:rk);
%Sigma_u = diag(sigma);
Sigma_uInv = 1./sigmaK;
Vk = VK(:,1:rk);
n = size(K,1);
Z = zeros(n,n);
L = Z;
P = eye(n);
I = eye(n);

rho = 1;
rho_max = 1e10;
delta_rho = 0.1;
diff = 1e-6;
Niter = 1e3;
tic;
for t = 1:Niter
    temp = I - P + L./rho;
    [U,sig,V] = svd(temp,'econ');
    sig = diag(sig);
    svp = length(find(sig>1/rho));
    if svp>=1
        sig = sig(1:svp)-1/rho;
    else
        svp = 1;
        sig = 0;
    end
    Z = U(:,1:svp)*diag(sig)*V(:,1:svp)';
    
    C = I - Z + L./rho;
    tau = rho/lambda;
    
    for i = 1:n
        ci = C(:,i);
        hu = Vk'*ci;
        if norm(Sigma_uInv.*hu)>(1/tau)
            f = @(x) hu'*(diag((sigmaK.^2)./((sigmaK.^2+x*tau).^2)))*hu - 1/(tau^2);
            alpha = bisection(f, 0, 200, 1e-4);
            P(:,i) = ci - Vk*(((sigmaK.^2)./(sigmaK.^2+alpha*tau)).*hu);
        else
            P(:,i) = ci - Vk*hu;
        end
    end
    
    L = L + rho*(I - Z - P);
    rho = min(rho_max,rho*(1+delta_rho));
    stop = max(max(abs(I - Z - P)));
    fprintf('%d: inf_norm =  \t %.6f \t rank = %d\n', t, stop,rank(Z,1e-3*norm(Z,2)));   
    if stop<=diff
        break;
    end
end
toc;
time_cost_ZPE = toc;
end