function [c, ceq] = nonLinearConstraints(x, x_ekf, N, lbx, ubx,Qbatt, n)
    I = x;
    ceq = [];
    c = [];
       
    SOC = [x_ekf(1); zeros(N-1,1)]; 
    V1 =  [x_ekf(2); zeros(N-1,1)];
    V2 =  [x_ekf(3); zeros(N-1,1)];
    Tc =  [x_ekf(4); zeros(N-1,1)];
    Ts =  [x_ekf(5); zeros(N-1,1)];
    R0 = [x_ekf(6); zeros(N-1,1)];

    for t = 1:N-1
        [R00, R1, C1, R2, C2, Rc, Cc, Rs, Cs, Tair] = getParameters(SOC(t), Tc(t), I(t),n);
        %R00 is not used

        Vocv = (14.7958*SOC(t)^6 -36.6148 * SOC(t)^5 + 29.2355 * SOC(t)^4 - 6.2817 * SOC(t)^3 - 1.6476 * SOC(t)^2 + 1.2866 * SOC(t) + 3.4049);
        Vbatt = Vocv - V1(t)- V2(t) - R0(t)*I(t); 

        SOC(t+1) = SOC(t) - 1/Qbatt * I(t);
        V1(t+1) = V1(t) - 1/(R1*C1) * V1(t) + 1/C1 * I(t);
        V2(t+1) = V2(t) - 1/(R2*C2) * V2(t) + 1/C2 * I(t);
        Tc(t+1) =  Tc(t) + (V1(t)*I(t) + V2(t) * I(t) + R0(t)*I(t)*I(t))/Cc + 1/(Rc*Cc) * (Ts(t)-Tc(t));
        Ts(t+1) = Ts(t) + (Tair - Ts(t))/(Cs*Rs)-(Ts(t)-Tc(t))/(Cs*Rc);
        R0(t+1) = R0(t);

        c = [c; [eye(6);-eye(6)]*[SOC(t) V1(t) V2(t) Tc(t) Ts(t) R0(t)]' - [ubx;-lbx] ];
    end
end

