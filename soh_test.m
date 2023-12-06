clear SOH_Estimation
temp = X_ekf(5,:);
i = U_mpc;
% for n = 1:1
    for k = 1:length(i)
        [SOH(1700*(n-1)+k), I_Ah(1700*(n-1)+k)] = SOH_Estimation(temp(k), i(k));
    end
% end

figure(2)
plot(I_Ah)
figure(3)
plot(SOH)
