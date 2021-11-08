function P = update_P(P_x, Vk, Sigma_uInv,tau,Sig_sq_K,n,rk)
for i = 1:n
    ci = P_x(:,i);
    hu = Vk'*ci;
    if norm(Sigma_uInv.*hu)>(1/tau)
        f = @(x) hu'*(diag((Sig_sq_K.^2)./((Sig_sq_K.^2+x*tau).^2)))*hu - 1./(tau.^2);
        ub = sqrt(hu'*(diag(Sig_sq_K.^2))*hu) - (Sig_sq_K(rk).^2)./tau;
        a_low_temp = sqrt(hu'*(diag(Sig_sq_K.^2))*hu) - (Sig_sq_K(1).^2)./tau;
        lb = max(0,a_low_temp);
%     lb = 0;
        a = bisection(f, lb, ub, 1e-2);
        P(:,i) = ci - Vk*(((Sig_sq_K.^2)./(Sig_sq_K.^2+a*tau)).*hu);
        b(i) = a;
    else
        P(:,i) = ci - Vk*hu;
%         P(:,i) = 1e-3;
    end
  
end
