x = 0: 0.01 : pi
y = sin(x)

df = diff(y) / 0.01
df(315) = df(314)
p = plot(y, df)

xlabel("y")
ylabel("df")
%to open more than one figure 
figure()

p2 = plot(x, df)
xlabel("x")
ylabel("df")

figure()

p3 = plot(x,y,x, df)
xlabel("x")
ylabel("values")
legend("y", "df")
title("Numerical integration")

%calculate integral
fun = @(x) sin(x)
myInt = integral(fun,0, pi)
