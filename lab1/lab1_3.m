%mozliwe, ze to wymaga poprawy - polecenia gdzies sa na kartce
f = @(x) (exp(-(x-1).^2) + exp(-(x+1).^2))
inF = integral(f, -Inf, Inf)
C = 1 / inF
x = -5:0.01:5;
f1 = @(x)( x.*(exp(-(x-1).^2) + exp(-(x+1).^2)))
f2 = @(x) x.*x.*(exp(-(x-1).^2) + exp(-(x+1).^2))
Y = exp(-(x-1).^2) + exp(-(x+1).^2)
f3 = @(x)(exp(-(x - 2 ).^2 / (2*0.2)) ) * 1/(sqrt(2*pi*0.2))
F = (exp(-(x ).^2 / (2*0.2)) ) * 1/(sqrt(2*pi*0.2))


distr = cumsum(F*0.01);

expectedValue = C * integral(f1, -Inf, Inf);
secondMoment = C * integral(f2, -Inf, Inf);

stdV = sqrt(secondMoment - expectedValue^2);
variance = stdV^2

mode = findpeaks(Y);
mode2 = findpeaks(F);

%median2 = min(abs(distr - 0.5))
%median = prctile(Y, 0.5)
%median22 = abs(distr - 0.5)

M = median(f3,0.5,  -5, 0.01);
fii = f3(-5);
data = zeros(1, 500);

for i = 1 : 500
    j = i / 100;
    f3(j);
    data(i) = f3(j);
end
M = quantile(data, 0.5);


function [xq] = median(f, q, start, step)
    suma = 0;
    i = start;
    while(abs(suma - q) > 0.01)
        suma = suma + f(i);
       fi = f(i);
        abs(suma - q);
        if(abs(suma - q) < 0.1)
            xq = suma;
            break;
        end  
        i = i + step;
    end
end

