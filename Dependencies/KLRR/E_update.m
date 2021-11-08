function E = E_update(beta, K, L, mu, Z, L2_mu)
% 2beta*KEL +mu*E -(L2+mu*Z)
% this is a sylvester equation AXB ¨C X + C = 0, and can be solved by discrete-time Lyapunov equations
A = -2*beta.*K./mu;
B = L;
C = (L2_mu + mu.*Z)./mu;
E = dlyap(A,B,C);
end