function [F, H] = Jacobian()

% Define symbolic variables
syms SOC V1 V2 Tc Ts R0
syms I
syms Vocv
[R00, R1, C1, R2, C2, Rc, Cc, Rs, Cs, Tair] = getParameters_old(SOC, Tc, I,0);
 
% Define state vector and input vector
x = [SOC V1 V2 Tc Ts R0];
u = [I];
 
% Call the battery model function symbolically
dx_symbolic = xdot(x, u,0);

Vocv = 14.7958*SOC^6-36.6148 * SOC^5 + 29.2355 * SOC^4 -6.2817 * SOC^3 - 1.6476 * SOC^2 + 1.2866 * SOC + 3.4049;
dy_symbolic = [Vocv-V1-V2-I*R0;
               Ts];
 
% Compute the Jacobian matrix
F = jacobian(dx_symbolic, x);

H = jacobian(dy_symbolic, x);

end
