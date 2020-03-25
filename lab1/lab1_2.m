f = @(x) exp(-(x-1).^2) + exp(-(x+1).^2)

C = 1 / integral(f, -Inf, Inf);
x = -5:0.01:5;
y = arrayfun(f,x)*C
distr = cumsum(y)*0.01;

subplot(2,1,1) % 2,1,1 - 2 wykresy, 1 columna, 1 wers
plot(x, y,'color','green', 'LineWidth',3)
xlabel("x")
ylabel("y")
title("Function")

subplot(2,1,2) % 2,1,1 - 2 wykresy, 1 columna, 2 wers
plot(x, distr,'color','red','LineWidth',2)
xlabel("x")
ylabel("y")
title("Distribution")


