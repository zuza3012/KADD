% Nalezy upewnic sie czy folder zawierajacy data.mat jest podany poprawnie
folder = 'D:\MATLAB\KADDy\KADD\lab9';  
fullMatFileName = fullfile(folder,  'data.mat')
if ~exist(fullMatFileName, 'file')
  message = sprintf('%s does not exist', fullMatFileName);
  uiwait(warndlg(message));
else
  s = load(fullMatFileName); 
  X1 = s.data(:,1); % col 1
  Y1 = s.data(:,2);

  X2 = s.data(:,3);
  Y2 = s.data(:,4);

  X3 = s.data(:,5);
  Y3 = s.data(:,6);

  X4 = s.data(:,7);
  Y4 = s.data(:,8);
end

mX1 = mean(X1)
mX2 = mean(X2)
mX3 = mean(X3)
mX4 = mean(X4)
mY1 = mean(Y1)
mY2 = mean(Y2)
mY3 = mean(Y3)
mY4 = mean(Y4)

vX1 = var(X1)
vX2 = var(X2)
vX3 = var(X3)
vX4 = var(X4)
vY1 = var(Y1)
vY2 = var(Y2)
vY3 = var(Y3)
vY4 = var(Y4)


corr1 = corr(X1, Y1)
corr2 = corr(X2, Y2)
corr3 = corr(X3, Y3)
corr4 = corr(X4, Y4)

figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

subplot(2,2,1)
scatter(X1,Y1)
X = [ones(length(X1),1) X1];
b = X\Y1;
hold on
yCalc2 = X*b(2,1) + b(1,1);
plot(X,yCalc2, 'color', 'red')
legend('Data','Fit','Location','best');
xlabel('X1');
ylabel('Y1');
xlim([min(X1) max(X1)]);
ylim([min(Y1) max(Y1)]);

subplot(2,2,2)
scatter(X2,Y2)
X = [ones(length(X2),1) X2];
b = X\Y2;
hold on
yCalc2 = X*b(2,1) + b(1,1);
plot(X,yCalc2, 'color', 'red')
legend('Data','Fit','Location','best');
xlabel('X2');
ylabel('Y2');
xlim([min(X2) max(X2)]);
ylim([min(Y2) max(Y2)]);

subplot(2,2,3)
scatter(X3,Y3)
X = [ones(length(X3),1) X3];
b = X\Y3;
hold on
yCalc2 = X*b(2,1) + b(1,1);
plot(X,yCalc2, 'color', 'red')
legend('Data','Fit','Location','best');
xlabel('X3');
ylabel('Y3');
xlim([min(X3) max(X3)]);
ylim([min(Y3) max(Y3)]);


subplot(2,2,4)
scatter(X4,Y4)
X = [ones(length(X4),1) X4];
b = X\Y4;
hold on
yCalc2 = X*b(2,1) + b(1,1);
plot(X,yCalc2, 'color', 'red')
legend('Data','Fit','Location','best');
xlabel('X4');
ylabel('Y4');
xlim([min(X4) max(X4)]);
ylim([min(Y4) max(Y4)]);



