r = 1;
s = 0; % srodek hiperkuli (kazdej wspolrzednej)
n = 10; %ilosc wymiarow

a = 1;
N = 1000;   %ilosc punktow generowanych
proc = [];

for k = 1:n
    
    all = []; % wspolrzedne x ilosc punktow
    acc = [];
    other = [];
    coordinates = zeros(1,k);
    sum2 = 0;
    for i = 1:N        
        sum2 = 0;
        %losujemy punkt (x,y)
        for j = 1:k
            coordinates(j) = -a + (a+a).*rand(1,1);         
            sum2 = sum2 + (coordinates(j) - s)^2; % losujemy wspolrzedne z hiperszescianu
        end
        all = [all; coordinates]; % dodaje coordinates do all

        % sprawdzamy co nalezy do hiperkuli   
        if sum2 <= r^2
            acc = [acc; coordinates];  
        else
            other = [other; coordinates];
        end
        coordinates = [];

    end
    sAcc = size(acc);
    sAll= size(all);
    k = sAcc(1);
    M = sAll(1);
    proc = [proc, k/M];
end



if n == 3
    figure
    scatter3(acc(:,1),acc(:,2),acc(:,3),'MarkerEdgeColor','red','MarkerFaceColor','red','LineWidth',1)
    hold on
    scatter3(other(:,1),other(:,2),other(:,3),'MarkerEdgeColor','blue','MarkerFaceColor','blue','LineWidth',1)
end

figure
X = 1:1:n;
plot(X, proc, 'color','black', 'LineWIdth',1)
xlabel('Dimention')
ylabel('Percentage of accepted points')
title('Accuracy of Monte Carlo method')
