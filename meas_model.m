function y_meas = meas_model(x,v,u,n)
%Returns the measurement of terminal voltage and surface temperature with
%noise. 
    SOC = x(1);
    I = u;
    Tc = x(4);
    R0 = x(6);

    [R00, R1, C1, R2, C2, Rc, Cc, Rs, Cs, Tair] = getParameters(SOC, Tc, I,n);
    Vocv = 14.7958*SOC^6-36.6148 * SOC^5 + 29.2355 * SOC^4 -6.2817 * SOC^3 - 1.6476 * SOC^2 + 1.2866 * SOC + 3.4049;
    v = [normrnd(0,1e-2); normrnd(0,1e-1)];
    
    y_meas = [Vocv-x(2)-x(3)-u*x(6); x(5)];
    y_meas = y_meas + v;

end