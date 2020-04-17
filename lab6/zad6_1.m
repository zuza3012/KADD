N = 10000;
[gX, gY] = galton(50);

x = zeros(1,N);

x_ = 0;
y_ = 0;
tmpX = 0;
tmpY = 50;
%rysowanie tablicy

for i = 1:50
    r = randi(2);    % 1- idziemy w lewo, 2 - w prawo
    if r ==1
        x_ = tmpX - 1;
        tmpX = x_;
        y_ = tmpY - 1;
        tmpY = y_;
    else
        x_ = tmpX + 1;
        tmpX = x_;
        y_ = tmpY - 1;
        tmpY = y_;
    end
    %x(j) = x_;
    plot(x_,y_,'*','color','black') 
    hold on
    plot(gX,gY,'o')
    hold off
    drawnow  
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
