%zadanie 4.1
r = 1;
g = @(y) sqrt(r^2 - y.^2);
d = r; %maksimum funkcji g(y)

x0 = 0;
y0 = 0;
a = -1;
b = 1;
N = 10000;

counter = 0;
counter2 = 0;

acc_X = zeros(1,N);
acc_Y = zeros(1,N);
other_X = zeros(1,N);
other_Y = zeros(1,N);

for i = 1:N
    %losujemy punkt (x,y)
    x = a + (b-a).*rand(1,1);
    y = a + (b-a).*rand(1,1);
    if x^2 + y^2 <= r^2
        counter = counter + 1;
        acc_X(counter) = x;
        acc_Y(counter) = y;
    else
        counter2 = counter2 + 1;
        other_X(counter2) = x;
        other_Y(counter2) = y;
    end
     
end


acc_X(:,[(counter+1):N])=[]; % wycinanie niepotrzebnych zer od konca
acc_Y(:,[(counter+1):N])=[]; 
other_X(:,[(counter2+1):N])=[]; 
other_Y(:,[(counter2+1):N])=[]; 

I = counter / N * (b-a)^2 % liczba punktow w kole / liczba wszytskich punktow * pole 'siatki'
my_pi = I / r^2 


figure
scatter(acc_X,acc_Y,'MarkerEdgeColor',[0 .7 .7],'MarkerFaceColor',[0 .7 .7],'LineWidth',1)

hold on
scatter(other_X,other_Y,'MarkerEdgeColor',[0 .3 .3],'MarkerFaceColor',[0 .3 .3],'LineWidth',1)
  
hold on
syms x y
fimplicit((x-x0).^2 + (y-y0).^2 -r^2,'color','white','LineWidth',3)

hold on
rectangle('Position',[-1 -1 2 2],'EdgeColor',[0 .8 .5],'LineWidth',3)
legend('Accepted','Other') 

%porownanie wyniku numerycznego z calkowym
pi_integral = 2 * integral(g,-r,r) / r^2
delta = abs(pi_integral - my_pi) % roznica miedzy pi numerycznym a calkowym


