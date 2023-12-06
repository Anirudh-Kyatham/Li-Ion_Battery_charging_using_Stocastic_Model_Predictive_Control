function [x_ekf, P_ekf, k_ekf] = ekf(x_in, y_ekf, u_in, P, F_jacobian, H_jacobian)
    I = u_in(1);
    SOC = x_in(1);
    V1 = x_in(2);
    V2 = x_in(3);
    Tc = x_in(4);
    Ts = x_in(5);
    
    F = subs(F_jacobian, I);
    H = subs(H_jacobian, SOC);
    [R0, R1, C1, R2, C2, Rc, Cc, Rs, Cs, Tair] = getParameters(SOC, Tc, I);
    
    Vocv = 14.7958*SOC^6-36.6148 * SOC^5 + 29.2355 * SOC^4 -6.2817 * SOC^3 - 1.6476 * SOC^2 + 1.2866 * SOC + 3.4049;
    
    
    w = [normrnd(0, 1e-6);normrnd(0,1e-2);normrnd(0,1e-2);normrnd(0,.1);normrnd(0,.1)];
    v = [normrnd(0,1e-2); normrnd(0,0.1)];
    
    Q = cov(diag(w));
    R = cov(diag(v));
    
    %prediction
    x_pred = x_in + xdot(x_in, u_in) + w;
    y_pred = [Vocv-V1-V2-I*Rs; Ts];
    P_pred = F * P * F' + Q;
    
    %measurement
    y_meas = y_ekf + v;
    S = H* P_pred * H' + R;
    
    %Kalman gain
    K = P_pred*H'*pinv(S);
    
    %Correction
    x_ekf = x_pred + K * (y_meas - y_pred);
    P_ekf = (eye(5) - K*H)*P_pred;

    x_ekf = double(x_ekf);
    P_ekf = double(P_ekf);
    k_ekf = K;
end