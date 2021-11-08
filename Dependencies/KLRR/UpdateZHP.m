function [Z, P,E,time_cost_ZPE,t] = UpdateZHP( KK, L, alpha, beta)
% This routine solves the following structured matrix fractorization optimization problem,
%   min |Z|_{*} + alpha*|Phi(F)P|_{21}+beta*tr(EQE^T)
%   s.t., P = I-Z , E = Z
% inputs:
%       KK -- the kernel matrix N*N data matrix, and N is the number of dimension.
%       L -- N*N laplacian matrix,
%       alpha -- the penalty for |Phi(F)P|_{21}
%       beta -- the penalty for tr(EQE^T)
% outputs:
%       Z -- D*N low-rank matrix
%       P -- D*N low-rank matrix
%       E -- D*N structured-sparse matrix
%
%% References
%   [1] Houwen Peng et al.
%         Salient Object Detection via Structured Matrix Decomposition.
%         TPAMI 2017
%   [2] Shijie Xiao et al. Robust Kernel Low-Rank Representation. TNNLS
%         2016
%%
eps1 = 1e-4; %threshold for the error in constraint
eps2 = 1e-2; %threshold for the change in the solutions
t_max = 1e3;
deltamu = 2.5;%1.1
mu =1e-2;
mu_max = 1e10;
% norm2X = norm(KK,2);
% eta = norm2X*norm2X*1.02;%
eta = max(eig(KK))*1.02;%

[d, n] = size(KK);
[V_K,Sig_K,~] = svd (KK) ;
Sig_sq =sqrt(diag(Sig_K))  ; %vector
% to save time
% normfF = norm(KK,'fro');
normfF = sqrt(trace(KK));
%% initial parameters for updating P
rk = sum(Sig_sq>Sig_sq(1)*1e-3);%%Sig_sq(1)*1e-3
Sig_sq_K = Sig_sq(1:rk);
Sigma_uInv = 1./Sig_sq_K;
Vk = V_K(:,1:rk);
% initialize optimization variables
Z = zeros(d,n);
P = eye(d,n);%eye(d,n)sparse
E = zeros(d,n);
L1 = zeros(d,n);
I = eye(n);
L2 = zeros(d,n);

%% start the loop
t = 0;
tic;
while t < t_max
%     while t < 120

    t = t + 1;
    % copy Z and S to compute the change in the solutions
    Zt = Z;
    Et = E;
    Pt = P;
    % to save time
    L1_mu = L1./mu;
    L2_mu = L2./mu;
    %% update Z
%     Z = update_Z(Zt, P, E, L1_mu, L2_mu,I, mu,eta);
    Z = Z_update(P, E, mu, L1_mu,L2_mu,I);
%     Z(Z<0) =0;
    %% udpate E
%     Q = V_K*diag(Sig_sq)*L*diag(Sig_sq)*V_K';
%     temp = 2*beta.*Q+ mu.*eye(d,n);
%     E =  temp\(mu.*Z+L2); 
    E = E_update(beta, KK, L, mu, Z, L2_mu);
%     E(E<=0) =0;
   %% update P
    P_x = I - Z + L1_mu;
    tau = mu./alpha;
    P = update_P(P_x, Vk, Sigma_uInv,tau,Sig_sq_K,n,rk) ;
%      P(P<0) =0;
    %% convergence condition
    leq1 = I - Z - P;
    leq2 = Z-E;
    relChgZ(t) = norm(Z - Zt,'fro')/normfF;
    relChgE(t) = norm(leq2,'fro')/normfF;
%     relChgZ(t) = norm(Z - Zt,'fro')/normfF;
%     relChgE(t) = norm(E - Et,'fro')/normfF;
%     recErr1(t) = relChgE(t);
    recErr1(t) = max(relChgZ(t), relChgE(t));
    recErr2(t)= norm(leq1,'fro')/normfF;
    convergenced = recErr2(t) <eps1 && recErr1(t) < eps2;
%     figure(10) 
%     plot(1:t-1,relChgZ(1:t-1),'k','linewidth',2);
%     hold on;
%     plot(1:t-1,relChgE(1:t-1),'y','linewidth',2);
%     hold on;
% %     plot(1:t-1,recErr1(1:t-1),'r','linewidth',2);
% %     hold on;
%     plot(1:t-1,recErr2(1:t-1),'b','linewidth',2);
%     hold off;
%     drawnow;
%     pause(0.0000000001);
   
    if t==1 || mod(t,40)==0 || convergenced
        disp(['iter ' num2str(t) ',mu=' num2str(mu,'%2.1e') ...
            ',rank=' num2str(rank(Z,1e-3*norm(Z,2))) ',stopADM=' num2str(recErr2(t),'%2.3e')]);
    end
    if convergenced
        disp('ADM done.');
        break
    else
        L1 = L1 + mu*leq1;
        L2 = L2 + mu*leq2;
%        if mu*recErr1(t) < eps2
        mu = min(mu_max,mu*deltamu);
%         end
    end
end
toc;
time_cost_ZPE = toc;