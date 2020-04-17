%zadanie 8.1
x = linspace(-1, 1, 100);
dist = makedist('Uniform', 'lower', -1, 'upper', 1);
updf_x = pdf(dist, x);

y = linspace(-1, 1, 100);
dist_y = makedist('Uniform', 'lower', -1, 'upper', 1)
updf_y = pdf(dist_y, y);
f_ = [];
U = updf_x + updf_y;
%c = 1 / trapz(U);
%U = U * c*100;
dist_u = makedist('Uniform', 'lower', -1, 'upper', 1)
updf_u = unifpdf(U,-1,1)

splot_1 = conv(updf_x,updf_y);
xs = linspace(-1,length(splot_1)/100,length(splot_1));
Q = 1 / trapz(splot_1);
splot_1 = splot_1 * Q * 100;
 
figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1)
plot(xs, splot_1, x ,updf_u)
legend('splot 1','U ')

title('8.1')
%zadanie 8.2
N = 5;

for i=1:3
    expected_v = 0;
    expected_v2 = 0;
    var3 = 0;
    if i == 1
        splot_i = conv(updf_x,updf_y);
    else
        x_new = linspace(-1, 1, 100);
        dist_new = makedist('Uniform', 'lower', -1, 'upper', 1);
        new = pdf(dist_new, x_new);      
        splot_i = conv(splot_i,new);

    end

    x_ = linspace(-1,length(splot_i)/100,length(splot_i));

    q = 1 / trapz(splot_i);
    splot_i = splot_i * q * 100; %bo linspace
   
    %znajdujemy maksimum i idpowiadaj¹cy mu x
    [pks,locs] = findpeaks(splot_i);
    mu = x_(locs);
    %mu = mean(splot_i) to tez daje zly wynik nie wiadomo czemu
    
    %obliczanie E(x) i E(x^2)oraz var
    for j=1:length(x_)
        expected_v =  expected_v + x_(j)*splot_i(j);
        expected_v2 =  expected_v2 + x_(j)*x_(j)*splot_i(j);
        var3 = var3 + (x_(j) - mu).^2*splot_i(j);
    end
    %przez 100 bo linspace
    expected_v = expected_v / 100;
    expected_v2 = expected_v2 / 100;
    var3 = var3 / 100;
    
    %var_ = var(splot_i) % to nie wiedziec czemu daje zly wynik
    var2 = expected_v2 - expected_v^2;
    
    f = @(x) 1/sqrt(2*pi*var2) * exp(-1/2*(x - mu).^2./var2);
    
    subplot(2,1,2)
    hold on
    p0 = plot(x, U, '.','LineWidth',2,'HandleVisibility','off')
    
    
    hold on
    p1 = plot(x_,splot_i,'LineWidth',3);
    
    %do wyswietlania odpowiednio legendy
    Legend=cell(i,1)
    for iter=1:i
         Legend{iter}=strcat('splot ', num2str(iter));
    end
    
    legend(Legend)
    title('8.2')
    hold on
    p2 = plot(x_, f(x_), 'color','black','HandleVisibility','off');
    hold off
    drawnow;   
end









