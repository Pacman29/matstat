close all; clc;

X = csvread('temp.csv'); 

gamma = 0.9;
alpha = (1 - gamma)/2;
N = 1:length(X);

meanX = mean(X);
varX = var(X);

M = [];
S = [];
for i=N
    M = [M, mean(X(1:i))];
    S = [S, var(X(1:i))];
end;

figure
plot([N(1), N(end)], [meanX, meanX], 'm');
hold on;
plot(N, M, 'g');
Ml = M - sqrt(S./N).*tinv(1 - alpha, N - 1);
plot(N, Ml, 'b');
Mh = M + sqrt(S./N).*tinv(1 - alpha, N - 1);
plot(N, Mh, 'r');
grid on;
hold off;
legend('\mu\^(x_N)', '\mu\^(x_n)', '\mu_{--}(x_n)', '\mu^{--}(x_n)');
fprintf('M = %.2f\nD = %.2f\n\n', meanX, varX);
fprintf('mu low = %.2f\nmu high = %.2f\n', Ml(end), Mh(end));

figure
plot([N(1), N(end)], [varX, varX], 'm');
hold on;
plot(N, S, 'g');
Sl = S.*(N - 1)./chi2inv(1 - alpha, N - 1);
plot(N, Sl, 'b');
Sh = S.*(N - 1)./chi2inv(alpha, N - 1);
plot(N, Sh, 'r');
grid on;
hold off;
legend('S^2(x_N)', 'S^2(x_n)', '\sigma_{--}(x_n)', '\sigma^{--}(x_n)');
fprintf('sigma low = %.2f\nsigma high = %.2f\n', Sl(end), Sh(end));