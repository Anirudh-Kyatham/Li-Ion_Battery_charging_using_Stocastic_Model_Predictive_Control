function dxdt = xdot(x,u,n)
    % System dynamics in continuous time domain

    [R00, R1, C1, R2, C2, Rc, Cc, Rs, Cs, Tair] = getParameters_old(x(1),x(5),u,n);
    Q_batt = 3600;  %1Ahr in As
    Vocv = 14.7958*x(1)^6-36.6148 * x(1)^5 + 29.2355 * x(1)^4 -6.2817 * x(1)^3 - 1.6476 * x(1)^2 + 1.2866 * x(1) + 3.4049;
    Vbatt = Vocv - x(2)-x(3) - R00*u;
    Qgen = u * (Vocv - Vbatt);

    x1= -1/Q_batt * u;
    x2 = -1/(R1*C1) * x(2) + 1/C1 * u;
    x3 = -1/(R2*C2) * x(3) + 1/C2 * u;
    x4 =  (x(2)*u + x(3) * u + R00*u*u)/Cc + 1/(Rc*Cc) * (x(5)-x(4));
    x5 = (-1/(Rs*Cs) - 1/(Rc*Cs))*x(5) + 1/(Rc*Cs)*x(4) + 1/(Rs * Cs) * Tair;
    x6 = 0;
    
    dxdt = [x1 x2 x3 x4 x5 x6]'; 
    
end

