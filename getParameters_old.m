function [R0, R1, C1, R2, C2, Rc, Cc, Ru, Cs, Tair] = getParameters_old(soc, temp, i,n)
    %%Pletts book vol 1 Page 32
    % R0 = 8.2e-3;
    % R1 = 15.8e-3;
    % C1 = 2400/(4*R1);
    % R2 = R1;
    % C2 = C1;
    % Cc = 44.07;  %JK-1
    % Ru = 2.0751;  %Kelvin/W
    % Cs = 4.5; 
    % Rc = 7.4013; 
    % Tair = 297; 
    
    %This function is used only during the initialization. So the values are
    %returned for soc = 0.5, T = 297K, and i = 0
    [R0, R1, C1, R2, C2, Rc, Cc, Ru, Cs, Tair] = getParameters(0.5, 298, 0,n);
end

