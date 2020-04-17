N = 10000;
[gX, gY] = galton(50);

x = [];
w = [];
counter = 0;
%rysowanie tablicy
for j = 1:N
    x_ = 0;
    tmpX = 0;    
    for i = 1:50
        r = randi(2);    % 1- idziemy w lewo, 2 - w prawo
        if r ==1
            x_ = tmpX - 1;
            tmpX = x_;           
        else
            x_ = tmpX + 1;
            tmpX = x_;           
        end
               
    end
    x = [x; x_]; 
    
    m = mod(j,100)
    
    if m == 0
        counter = counter +1
        xx = min(x):0.25:max(x)
        histogram(x,'Normalization','pdf')
        hold on
        plot(xx, gauss, 'color','black', 'LineWidth',3)
        hold off
        drawnow;
        
    end
    
    %pause(0.001)
   
    %pause(0.01)
end

function [x, y] = galton(N)
 x = 0;
 y = 0;
 for i = 1:N
    xx = -(N-i):2:((N-i)+2);
    n = length(xx);
    x(end:end+n-1) = xx;
    y(end:end+n-1) = ones(1, n)*(i);
 end
 x = x(1:end-1);
 y = y(1:end-1);
end
