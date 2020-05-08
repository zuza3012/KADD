data1 = csvread('dane1.csv',1,0);
data2 = csvread('dane2.csv',1,0);

d1 = zeros(length(data1) - 1, 2);
d2 = zeros(length(data2) - 1, 2);

r1 = sqrt((data1(:,1).^2 + data1(:,2).^2));
r2 = sqrt((data2(:,1).^2 + data2(:,2).^2));

dr1 = zeros(length(r1) - 1, 2);
dr2 = zeros(length(r2) - 1, 2);

for k=1:length(d1) - 1
    d1(k,1) = abs(data1(k+1,1) - data1(k,1));  
    d1(k,2) = abs(data1(k+1,2) - data1(k,2));   
end

for j=1:length(d2) - 1
   d2(j,2) = abs(data2(j+1,2) - data2(j,2));
   d2(j,1) = abs(data2(j+1,1) - data2(j,1));   
end

for n=1:length(dr1) - 1 
   dr1(n,1) = abs(r1(n+1,1) - r1(n,1));   
end

for m=1:length(dr2) - 1 
   dr2(m,1) = abs(r2(m+1,1) - r2(m,1));   
end

c1 =cumsum(d1(:,1));
c2 =cumsum(d2(:,1));
for l=1:length(c1) 
    c1(l,1) = c1(l,1) / l;
end

for d=1:length(c2) 
    c2(d,1) = c2(d,1) / d;
end

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

subplot(2,3,1)
plot(data1(:,1), data1(:,2))

subplot(2,3,4)
plot(data2(:,1), data2(:,2))

subplot(2,3,2)
histogram(d1,'Normalization','pdf')

subplot(2,3,5)
histogram(d2,'Normalization','pdf')

subplot(2,3,6)
plot(1:1:length(c2), c2, '.')

subplot(2,3,3)
plot(1:1:length(c1), c1, '.')

a = 1;
f = @(x) 1/a * exp(-x/a);
r = rand(2);

for e= 1:length(r)
    for f= 1:length(r)
        value = r(e,f);
        r(e,f) = -a * log(1-value);
    end   
end
length(r)

r = reshape(r,[length(r)*length(r),1]);

alfa = 0 + (2*pi-0).*rand(length(r)*length(r),1);


x = r * reshape(cos(alfa),[1,length(alfa)]);
y = r * reshape(sin(alfa),[1,length(alfa)]);

sx = size(x);
sy = size(y);
x = reshape(x,[sx(1,1)*sx(1,2),1]);
y = reshape(y,[sy(1,1)*sy(1,2),1]);

data_write = zeros(length(x),2);
data_write(:,1) = x;
data_write(:,2) = y;


csvwrite('data_write.csv',data_write)