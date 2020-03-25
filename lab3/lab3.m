r = rand(10);
r2 = rand(100);
a = 1;
f = @(x) 1/a * exp(-x/a);
g = @(x) 1 / sqrt(2*pi) * exp(-x.^2 / 2);
G = @(x) 1/2 * (1+erf(x / sqrt(2)));

q1 = integral(f,0,Inf);
C1 = 1/q1;

q2 = integral(g,-Inf,Inf);
C2 = 1/q2;

%liczby z rozkladu funkcji f(x)
for i= 1:length(r)
    for j= 1:length(r)
        value = r(i,j);
        r(i,j) = -a * log(1-value);
    end   
end
width = 0.9;
% liczby z  rozkladu funkcji g(x)
r_g = @(u) fzero(@ (x) 1/2 * (1+erf(x / sqrt(2))) - u,0);
rand_g = arrayfun(r_g,r2);

% generowanie danych do wykresy f(x)
x = 0:0.25:max(r(:))+width;
ff = arrayfun(f,x)*C1;

% generowanie danych do wykresy g(x)


xx = min(rand_g(:)):0.25:max(rand_g(:));
gg = arrayfun(g,xx)*C2;

figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

subplot(1,2,1)
plot(x,ff,'LineWidth',3)
hold on
h1 = histogram(r,'Normalization','pdf')
h1.FaceColor = [0 0.1 0.4];
h1.BinWidth = width;
legend('f', 'histogram f')
title('f(x) with histogram (100 random points)')

subplot(1,2,2)
plot(xx,gg,'LineWidth',3, 'color','yellow')
hold on
h2 = histogram(rand_g,'Normalization','pdf')
h2.FaceColor = [0 0.5 0.5];
legend('g', 'histogram g')
title('g(x) with histogram (10 000 random points)')



 
