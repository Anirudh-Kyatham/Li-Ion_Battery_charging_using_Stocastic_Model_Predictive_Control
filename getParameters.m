function [R0, R1, C1, R2, C2, Rc, Cc, Ru, Cs, Tair] = getParameters(SOC, temp, i,n)
%returns the battery parameters based on given SOC, temperature and current
%(charging or discharging)

% R0 =  0.0121; %Ohms
% R1 = 0.0155;  %Ohms
% C1 = 166.8685/R1; 
% R2 = 0.0155;
% C2 = C1;

%%Pletts book vol 1 Page 32
% R0 = 8.2e-3;
% R1 = 15.8e-3;
% C1 = 2400/(4*R1);
% R2 = R1;
% C2 = C1;

% SOC and Temp varying parameters
% Table I: Rs
R_s0d = 0.0048;
R_s0c = 0.0055;
T_refRsd = 31.0494;
T_refRsc = 22.2477;
T_shiftRsd = -15.3253;
T_shiftRsc = -11.5943;

% Table II: R1
R_10d = 7.1135e-4;
R_10c = 0.0016;
R_11d = -4.3865e-4;
R_11c = -0.0032;
R_12d = 2.3788e-4;
R_12c = 0.0045;
T_refR1d = 347.4707;
T_refR1c = 159.2819;
T_shiftR1d = -79.5816;
T_shiftR1c = -41.4548;

% Table III: R2
R_20d = 0.0288;
R_20c = 0.0113;
R_21d = -0.073;
R_21c = -0.027;
R_22d = 0.0605;
R_22c = 0.0339;
T_refR2d = 16.6712;
T_refR2c = 17.0224;

% Table IV: C1
C_10d = 335.4518;
C_10c = 523.215;
C_11d = 3.1712e3;
C_11c = 6.417e3;

C_12d = -1.3214e3;
C_12c = 7.5555e3;
C_13d = 53.2138;
C_13c = 50.7107;

C_14d = -65.4786;
C_14c = -131.2298;
C_15d = 44.3761;
C_15c = 162.4688;

% Table V: C2
C_20d = 3.1887e4;
C_20c = 6.2449e4;
C_21d = -1.1593e5;
C_21c = -1.055e5;

C_22d = 1.0493e5;
C_22c = 4.4432e4;
C_23d = 60.3114;
C_23c = 198.9753;

C_24d = 1.0175e4;
C_24c = 7.5621e3;
C_25d = -9.5924e3;
C_25c = -6.9365e3;

% Check if charging or discharging to select appropriate coefficients
if i >= 0
    % Discharging
    R0 = R_s0d * exp(T_refRsd/(temp - T_shiftRsd));
    R1 = (R_10d + R_11d*SOC + R_12d*(SOC.^2))*exp(T_refR1d/(temp - T_shiftR1d));
    R2 = (R_20d + R_21d*SOC + R_22d*(SOC.^2))*exp(T_refR2d/temp);
    C1 = (C_10d + C_11d*SOC + C_12d*(SOC.^2))*(C_13d + C_14d*SOC + C_15d*(SOC.^2))*temp;
    C2 = (C_20d + C_21d*SOC + C_22d*(SOC.^2))*(C_23d + C_24d*SOC + C_25d*(SOC.^2))*temp;
else
    % Charging
    R0 = R_s0c * exp(T_refRsc/(temp - T_shiftRsc));
    R1 = (R_10c + R_11c*SOC + R_12c*(SOC.^2))*exp(T_refR1c/(temp - T_shiftR1c));
    R2 = (R_20c + R_21c*SOC + R_22c*(SOC.^2))*exp(T_refR2c/temp);
    C1 = (C_10c + C_11c*SOC + C_12c*(SOC.^2))*(C_13c + C_14c*SOC + C_15c*(SOC.^2))*temp;
    C2 = (C_20c + C_21c*SOC + C_22c*(SOC.^2))*(C_23c + C_24c*SOC + C_25c*(SOC.^2))*temp;
end

Cc = 44.07;  %JK-1
Ru = 2.0751;  %Kelvin/W
Cs = 4.5; 
Rc = 7.4013; 
Tair = 298 + 5*sin(2*pi*5e-4*n); 
end

