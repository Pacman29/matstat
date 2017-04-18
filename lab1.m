close all;

x = csvread('temp.csv');

M_min = min(x);
M_max = max(x);
R = range(x);
MX = mean(x);
DX = var(x);
sigma = sqrt(DX);

fprintf('Min = %.2f\nMax = %.2f\nR = %.2f\n', M_min, M_max, R);
fprintf('MX = %f\nDX = %f\n', MX, DX);

% определение кол-ва промежутков разбиения
J_m = fix(log2(length(x))) + 2 ;
% упорядочение
[y1, x1] = hist(x, J_m);
% нормирование

for i=1:length(x1)
    fprintf('%d. промежуток: %.2f ; %.2f колличество: %d \n',i,x1(i)-R/(2*J_m),x1(i)+R/(2*J_m),y1(i));
    last = x1(i);
end

y1 = y1/(sum(y1)*(x1(2) - x1(1)));
step = sigma/100;

xnorm = (MX - R):step:(MX + R);
ynormp = normpdf(xnorm, MX, sigma);
ynormc = normcdf(xnorm, MX, sigma);

figure
bar(x1, y1, 1);
hold on;
plot(xnorm, ynormp, 'r');
hold off;

figure
ecdf(x);
axis tight;
hold on;
plot(xnorm, ynormc, 'r');
hold off;
