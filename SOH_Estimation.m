function [SOH, I_Ah] = SOH_Estimation(T, I)
%% SOH Estimation
%%Paper: Capacity and Power fade cycle-life nodel for plug-in Hybrid
%%Assuming Charge depleting and charge sustaining time are same (Ratio =1)

SOC_min = 0.1;
persistent I_amp

if isempty(I_amp)
    I_amp = 0;
end

persistent S_nom

if isempty(S_nom)
    S_nom = 1;
end

%for ratio = 1
alpha_c = 137;
beta_c = 420;
gamma_c = 9610;
b =0.34;
c =3;
z =0.48;
SOC_0 =0.1;
E_a_c = 22406;
E_a_c = (32699+55546)/2;  %NREl data: https://www.nrel.gov/docs/fy18osti/70616.pdf
R_g = 8.314;   %Gas constant
ratio = 1;

%Capacity Fade
a_c = alpha_c + beta_c*(ratio)^b + gamma_c*(SOC_min-SOC_0)^c;
for k=1:length(I)
    I_amp = I_amp + abs(I(k))
end
% S_loss = a_c * exp(-E_a_c/R_g * (1/T))*I_amp^z

kcyc = (1.456+4.009)*1e-4 /2 ; %NREL data
S_loss = kcyc * exp(-E_a_c/R_g * (1/T- 1/298))*(I_amp/3600)^z;


SOH = S_nom - (S_nom*S_loss/100);
I_Ah = I_amp;
S_nom = SOH;

end