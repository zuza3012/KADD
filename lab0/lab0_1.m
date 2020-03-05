random = -1 + (1+1)*rand(10,1)
Y = zeros(1,30)
for i = 1:30
    Y(i) = cos(2*pi/i);
end
% y sorted in ascending order
sortYInc = sort(Y)
% y sorted in descending order
sortYDec =  sort(Y,'descend')

minY = min(Y)
maxY = max(Y)

%bez tego nie policzy sumy, bo nie ;)
clear sum
sumY = sum(Y)

clear prod
prodY = prod(Y)

meanY = mean(Y)
stdY = std(Y)
% factoral function from file  factorial.m
factorial(3)

