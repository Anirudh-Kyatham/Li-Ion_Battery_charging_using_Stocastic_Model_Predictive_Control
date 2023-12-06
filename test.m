clear all;
x = [0 0.5 0.5 320 320]';
c_rate = -1.6667;
u_in = .3*c_rate;
[R0, R1, C1, R2, C2, Rc, Cc, Rs, Cs, Tair] = getParameters(x(1), x(4), u_in);


X = x;
V1 = x(2); V2 = x(3);
Vocv = 14.7958*x(1)^6-36.6148 * x(1)^5 + 29.2355 * x(1)^4 -6.2817 * x(1)^3 - 1.6476 * x(1)^2 + 1.2866 * x(1) + 3.4049;
Vbatt = Vocv - V1- V2 - R0*x(1);
for i = 1:7200
    x = x + xdot(x, u_in);
    X = [X x];

    [R0, R1, C1, R2, C2, Rc, Cc, Rs, Cs, Tair] = getParameters(x(1), x(4), u_in);

    Vocv = 14.7958*x(1)^6-36.6148 * x(1)^5 + 29.2355 * x(1)^4 -6.2817 * x(1)^3 - 1.6476 * x(1)^2 + 1.2866 * x(1) + 3.4049;
    Vbatt = [Vbatt Vocv - V1- V2 - R0*x(1)];
end
figure()
t = 1:size(X, 2);
subplot(3,1,1)
plot(t, X(1,:), t,X(2,:), t, X(3,:));
legend('x1', 'x2', 'x3')
subplot(3,1,2)
plot(t, X(4,:), t,X(5,:));
legend('x4', 'x5')
subplot(3,1,3)
plot(t, Vbatt);
legend('Vbatt')
