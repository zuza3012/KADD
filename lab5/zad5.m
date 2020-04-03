f = @(x) (1-x.^2); 
C = 1/(integral(f,-1,1));

g = @(x) cos(x);

a = -1;
b = 1;
N = 10000;

r_x = [];

invDist = @ (x) asin(x -sind(1));

X = a:0.025:b;
counter = 0;
while counter ~= N
    %punkt o wspolrzednych (x,y) z rozkladu g(x) = cos(x) - metoda
    %odwrotnej dystrybuanty
    u = a + (b-a).*rand(1,1);%  z przedzialu (a,b)
    x = invDist(u); 
    y = rand(); %liczba z przedzialu (0,1)
    
    if  y < f(x)*C
      counter =counter + 1;
      r_x = [r_x,x];
    end   
end

F = arrayfun(f, X)*C;

%Dystrybuanata liczona analitycznie
D = @(x) (-1/3*x.^3 +x +2/3)*C;
D_teor = arrayfun(D,X);

%empirycznie
mean_emp = mean(r_x);
median_emp = median(r_x);
var_emp =var(r_x);
q1_emp =  quantile(r_x,0.25);
q3_emp = quantile(r_x,0.75);

%analitycznie
mean_teor = integral(@(x)x.*(1-x.^2),-1,1)*C;
median_teor = fzero(@(x) C*(x - x.^3 / 3 + 2/3)- 0.5,0);  %sprawdzamy gdzie wartoœæ dystrybuanta = 0.5
q1_teor = fzero(@(x)C*(x - x.^3 / 3 + 2/3) - 0.25,0);
q3_teor = fzero(@(x)C*(x - x.^3 / 3 + 2/3) - 0.75,0);
Ex_2 = integral(@(x)x.*x.*(1-x.^2),-1,1)*C;
var_teor = Ex_2 - mean_teor^2;


statistical_Parameters = {'Mean';'Median';'Variance';'First quartile';'Third quartile'};
Empirically = [mean_emp;median_emp;var_emp;q1_emp;q3_emp];
Teoretically = [mean_teor;median_teor;var_teor;q1_teor;q3_teor];
T = table(statistical_Parameters,Teoretically,Empirically);

figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

TString = evalc('disp(T)');

%boldowanie
TString = strrep(TString,'<strong>','\bf');
TString = strrep(TString,'</strong>','\rm');
TString = strrep(TString,'_','\_');
FixedWidth = get(0,'FixedWidthFontName');
%wyswietlanie
annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

subplot(1,2,2)

histogram(r_x,'Normalization','pdf')
hold on
plot(X,F,'color','yellow','LineWidth',3)
hold on
plot(X,D_teor,'color','green','LineWidth',3)
hold on
[fH,xH] = ecdf(r_x);
plot(xH,fH, 'color','blue','LineWidth',3)

legend('Histogram','f(x)','Dystrybuanta analityczna','Dystrybuanta empiryczna','Location','SouthOutside')
hold off
