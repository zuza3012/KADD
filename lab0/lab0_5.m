x = -3 : 0.25 : 3;
y = -3 : 0.25 : 3;
M = zeros(25,25);
for i = 1: 25
    for j = 1: 25  
       M(i,j) = x(i) * exp(-x(i)^2 - y(j)^2); 
    end  
end


surf(x,y,M)
xlabel("x")
ylabel("y")
zlabel("z")
title("Fancy Graph : x * exp(-x^2 - y^2)")

