N = 10000;
[gX, gY] = galton(50);
x = [];

for j = 1:N
    x_ = 0;    
    for i = 1:50
        r = randi(2);    % 1- idziemy w lewo, 2 - w prawo
        if r ==1
            x_ = x_ - 1;           
        else
            x_ = x_ + 1;           
        end                
    end
    x = [x; x_]; 
    mu = mean(x);
    var_ = var(x);
    xx = -25:0.25:25;
    f = @(x) 1/sqrt(2*pi*var_) * exp(-1/2*(x - mu).^2./var_);
 
    if (j < 100)
        a = 1;
    elseif (j < 1000)
        a = 10;
    elseif (j < 10000)
        a = 100;
    else
        a = 1000;
    end
     m = mod(j,a);
    
    if m == 0
        histogram(x,'Normalization','pdf','BinEdges', -25:2:25)
        hold on
        plot(xx, f(xx),'color','black', 'LineWidth',3)
        hold off
        drawnow;   
    end
           
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
