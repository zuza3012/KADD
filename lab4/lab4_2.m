a = -1; 
c = 0.25; 
b = 1;
h = 2/(b-A);
k1 = @(x) 2*(x-A)/((b-A)*(c-A));
k2 = @(x) 2*(b-x)/((b-A)*(b-c));

counter3 = 0;
M = 10000;
r = [];
while counter3 < M
    x2 = a + (b-a).*rand(1,1);
    y2 = a + (b-a).*rand(1,1);
    
    if (x2 <= c) && (x2 >= a)
        counter3= counter3 + 1;

        if(y2 > 0)&&(y2 < k1(x2)) 
            r = [r, x2];
        end    
        
    elseif (x2 > c) && (x2 <= b)
        counter3 = counter3 + 1;

        if (y2 >= 0) && (y2 < k2(x2))  
            r = [r, x2];
        end
        
    end
    
end

xx1 = a:0.25:c;
xx2 = (c+0.25):0.25:b;
xx = [xx1, xx2];

yy1 = arrayfun(k1,xx1);
yy2 = arrayfun(k2,xx2);
yy = [yy1, yy2];


figure
histogram(r,'Normalization','pdf')
hold on
plot(xx,yy,'LineWidth',3,'color','yellow')
legend('Histogram funkcji namiotowej','f')
title('Funkcja namiotowa + histogram (1000 punktow)')
