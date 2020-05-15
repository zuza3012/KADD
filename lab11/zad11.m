x = [-0.9 -0.7 -0.5 -0.3 -0.1 0.1 0.3 0.5 0.7 0.9];
y = [2 60 89 102 99 106 142 215 334 532];
dy = [2 8 4 10 8 15 5 8 15 20];

figure
plot(x,y,'o', 'DisplayName', 'Data')
hold on

k = 0;
while true
    k = k + 1;
    X = zeros(length(x), k + 1);
    X(:,1) = 1;

    w = zeros(length(x), length(x));

    for i=1:length(x)
        w(i,i) = dy(i)*dy(i);
    end
    for j=2:k+1
        X(:,j) = x.^(j-1);
    end
    Y = reshape(y,[length(y),1]);

    beta = inv((X' * inv(w))*X)*X'*inv(w)*Y;
   
    expectedY = X*beta;
    
    xx = -0.9:0.01:0.9 ;  
     
    p = fliplr(reshape(beta,[1, length(beta)]));
    yy = polyval(p,xx);
    
    plot(xx, yy, 'DisplayName',strcat('Degree ' + " " + num2str(k)))
    legend('-DynamicLegend');
    
  
    [h,p,st] = chi2gof(x, 'Frequency',y, 'Expected', expectedY, 'NParams',length(x) - length(beta) - 1, 'Alpha', 0.05);
    if h ==0
        break
    end
end






