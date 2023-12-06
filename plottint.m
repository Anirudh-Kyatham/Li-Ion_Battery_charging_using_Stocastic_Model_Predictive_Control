clear all

data = readmatrix("data.csv");
u = data(:,1);
x1 = data(:,2);
x2 = data(:,3);
x3 = data(:,4);
x4 = data(:,5);
x5 = data(:,6);
Rs = 0.005;

Vocv = (14.7958*x1.^6 -36.6148 * x1.^5 + 29.2355 * x1.^4 - 6.2817 * x1.^3 - 1.6476 * x1.^2 + 1.2866 * x1 + 3.4049);
Vbatt = Vocv - x2- x3 - Rs*u;

T = size(data, 1);
t = 0:T-1;

figure(1)
subplot(4,1,1)
stairs(u(1:end-1), 'LineWidth',1.5);
title("Charging current");
% xlabel("time(sec)");
ylabel("Ampere");
legend("I");
ylim([-155 155]);
grid on

% figure(2)
subplot(4,1,2)
plot(t, x1*100, LineWidth=1.5);
title("State of Charge");
% xlabel("time(sec)");
ylabel("%");
legend("SOC");
ylim([0 100]);
grid on

% figure(3)
subplot(4,1,3)
plot(t, x2, t,x3, t,Vocv, LineWidth = 1.5 )
title("Voltage");
% xlabel("time(sec)");
ylabel("Volt");
legend("V_{C1}", "V_{C2}", "V_{OCV}");
grid on

% figure(4)
subplot(4,1,4)
plot(t, x4, t,x5, LineWidth = 1.5 )
title("Temperature");
xlabel("time(sec)");
ylabel("Kelvin");
legend("T_{core}", "T_{surface}");
grid on