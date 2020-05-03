dataEmp = [0 1 2 3 4 5 6 7 8; 47 69 84 76 49 16 11 3 0];

nk = zeros(1,9);
pp = zeros(1,9);

for i=1:9
   nk(i) = dataEmp(2, i) * dataEmp(1, i);
end

n = dataEmp(2, :);
nk_sum = sum(nk);
n_sum = sum(n);
lambda = nk_sum / n_sum;

expValue1 = zeros(1,9);
expValue2 = zeros(1,9);
for i=0:8
   pp(i+1) = lambda.^i*exp(-1*lambda)/factorial(i);
   expValue1(i+1) = pp(i+1)* n_sum ;
   expValue2(i+1) = 1 / 8* n_sum ;
end

w = (n-expValue1).^2./expValue1;
chi1 = sum(w); %chi1 recznie

w2 = (n-expValue2).^2./expValue2;
chi2 = sum(w2); %chi2 recznie

k = 0:8;

[h,p,st] = chi2gof(k, 'Ctrs', k, 'Frequency',n, 'Expected', expValue1, 'NParams',1, 'Alpha', 0.01)
[h2,p2,st2] = chi2gof(k, 'Ctrs', k, 'Frequency',n, 'Expected', expValue2, 'NParams',2, 'Alpha', 0.9999999)

chiTable1 = 18.4753; % 7 stopni swobody dla testu zgodnosci z poissonem bo 9 danych - 1 parametr - 1
%chi1 < chiTabl1e wiec dane mog¹ byæ opisane rozk³¹dem poissona, h = 0

% nie znaleziono pozomu istotnosci ktory dawalby h2 = 0 dla rozkladu
% jednostajnego

n = dataEmp(2, :) / n_sum;
figure
bar(k,n)
hold on
plot(k,pp, 'LineWidth', 3, 'color','yellow')

title(strcat('Rozklad poissona \lambda = ',num2str(lambda)))

