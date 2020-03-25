f = @(x) exp(-(x-1).^2) + exp(-(x+1).^2)

C = 1 / integral(f, -Inf, Inf);

x = -5:0.01:5;
y = exp(-(x-1).^2) + exp(-(x+1).^2)
C2 = 1 / trapz(x, y)