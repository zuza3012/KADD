varX = 5;
varY = 2;
cov = 0.01;
rho = cov / (sqrt(varX * varY));
muX = 0.1;
muY = 0.5;

f = @(x,y) (1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY)))));
%normalizacja f
q = mydblquad(f,-inf,inf,-inf,inf)

x = -5:0.25:5;
y = x;


[xg,yg] = meshgrid(x,y);
l = length(xg);
F = 1/q *(1 / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1 / (2*(1- rho^2)) * ((xg - muX).^2 / varX + (yg - muY).^2 / varY - 2*rho.*(xg-muX)*(yg-muY)/(varX*varY))));


%nie wiem czy ta normalizacja jest porzadna
d = cumsum(cumsum(F,1),2);
distr = d / d(end);

% test = ones(3,3);
% test(1,1) = 1;
% test(1,2) = 2;
% test(1,3) = 3;
% test(2,1) = 4;
% test(2,2) = 5;
% test(2,3) = 6;
% test(3,1) = 7;
% test(3,2) = 8;
% test(3,3) = 9;
% test;
% c = cumsum(test); % to samo co umsum(test,1
% a = cumsum(test,1); % sumowanie po kolumnach
% b = cumsum(a,2); % sumowanie po wierszach

%dystrybuanty brzegowe

fx = @(x)arrayfun(@(x)integral(@(y)(1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY))))),-inf,inf),x);
Cx = 1 / integral(fx, -Inf, Inf);
Fx = arrayfun(fx,x)*Cx;

fy = @(y)arrayfun(@(y)integral(@(x)(1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY))))),-inf,inf),y);
Cy = 1 / integral(fy, -Inf, Inf);
Fy = arrayfun(fy,y) * Cy;

%do ewentualnej dystrybuanty x-a (o ile to jest dobrze)
%dxx = cumsum(a);
%dx = dxx / dxx(end)

% wartosc oczekiwana
Ex = integral( @(x) x.*( arrayfun(@(x)integral(@(y)(1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY))))),-inf,inf),x)), -Inf, Inf)
Ey = integral( @(y) y.*( arrayfun(@(y)integral(@(x)(1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY))))),-inf,inf),y)),-Inf, Inf)
Exy = integral( @(y) y.*( arrayfun(@(y)integral(@(x)x.*(1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY))))),-inf,inf),y)),-Inf, Inf)

% wariancja
varX_ = integral( @(x) (x.*x.* (arrayfun(@(x)integral(@(y)(1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY))))),-inf,inf),x))), -Inf, Inf) - Ex^2
varY_ = integral( @(y) (y.*y.*( arrayfun(@(y)integral(@(x)(1. / (sqrt(varX*varY*(1-rho^2))*2*pi) * exp(-1. / (2*(1- rho^2)) * ((x - muX).^2 / varX + (y - muY).^2 / varY - 2*rho.*(x-muX).*(y-muY)/sqrt((varX*varY))))),-inf,inf),y))),-Inf, Inf) - Ey^2

%kowariancja
cov_ = Exy - Ex*Ey

%wpolczynnik korelacji
rho_ = cov_ / (sqrt(varX_*varY_))

%macierz korelacji
cov_matrix = [ varX_, rho_*sqrt(varX_*varY_);
                rho_*sqrt(varX_*varY_), varY_]
                        

figure
%zwieksza rozmiar figure na fulla
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
title('Amazing Graph')
 
subplot(2,2,1)
surf(xg,yg,F);
xlabel("x")
ylabel("y")
zlabel("F")
legend('F')
 

subplot(2,2,2)
surf(xg,yg,distr);
xlabel("x")
ylabel("y")
zlabel("Distribution")
legend('Distribution')

subplot(2,2,3)
minx = 0;
maxx = max(Fx(:));
y1 = [minx, maxx];
x1 = [Ex, Ex];
y2 = [fx(Ex - sqrt(varX_))*Cx,fx(Ex - sqrt(varX_)) * Cx];
x2 = [Ex - sqrt(varX_),Ex + sqrt(varX_)];
plot(x,Fx,x1,y1, x2,y2);

xlabel("x")
ylabel("Fx")
legend('Marginal density function X', 'Expected value', 'Stdv')

subplot(2,2,4)
miny = 0;
maxy = max(Fy(:));
y4 = [miny, maxy];
x4 = [Ey, Ey];
y5 = [fy(Ey - sqrt(varY_))*Cy,fy(Ey - sqrt(varY_)) * Cy];
x5 = [Ey - sqrt(varY_),Ey + sqrt(varY_)];
plot(y,Fy,x4,y4,x5,y5);

xlabel("x")
ylabel("Fy")
legend('Marginal density function Y','Expected value', 'Stdv')


function [y] = mydblquad(fun,a,b,c,d)
    innerintegral = @(x)arrayfun( ...
    @(xi,y1i,y2i)quadgk(@(y)fun(xi*ones(size(y)),y),y1i,y2i), ... % kontynuacja linijka nizej
    x,c*ones(size(x)),d*ones(size(x)));
    y = quadgk(innerintegral,a,b); 
end

