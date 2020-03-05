function [fact] = factorial(m)
    fact = 1;
    for i = 1:m
        fact = fact * i;
    end
end