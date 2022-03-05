pkg load statistics

clc;
clear all;
close all;

# TASK: In a common diagram, design the Probability Mass Function of Poisson processes
# with lambda parameters 3, 10, 30, 50. In the horizontal axes, choose k parameters 
# between 0 and 70. 

k = 0:1:70;
lambda = [3,10,30, 50];

for i=1:columns(lambda)
  poisson(i,:) = poisspdf(k,lambda(i));
endfor

colors = "rbkm";
figure(1);
hold on;
#theloume ola ta l ektos apo to 30 pou einai stin thesi 3
for i=1:columns(lambda)
  if (i != 3)
    stem(k,poisson(i,:),colors(i),"linewidth",1.2);
  endif
endfor
hold off;

title("Probability Mass Function of Poisson processes");
xlabel("k values");
ylabel("probability");
legend("lambda=3","lambda=10","lambda=50");

# TASK: regarding the poisson process with parameter lambda 30, compute its mean 
# value and variance

index = find(lambda == 30);
chosen = poisson(index,:);
mean_value = 0;
for i=0:(columns(poisson(index,:))-1)
  mean_value = mean_value + i.*poisson(index,i+1);
endfor

display("mean value of Poisson with lambda 30 is");
display(mean_value);

second_moment = 0;
for i=0:(columns(poisson(index,:))-1)
  second_moment = second_moment + i.*i.*poisson(index,i+1);
endfor

variance = second_moment - mean_value.^2;
display("Variance of Poisson with lambda 30 is");
display(variance);

# TASK: consider the convolution of the Poisson distribution with lambda 10 with 
# the Poisson distribution with lambda 50. 

first = find(lambda==10);
second = find(lambda==50);
poisson_first = poisson(first,:);
poisson_second = poisson(second,:);

composed = conv(poisson_first,poisson_second);
new_k = 0:1:(2*70);

figure(2);
hold on;
stem(k,poisson_first(:),colors(1),"linewidth",1.2);
stem(k,poisson_second(:),colors(2),"linewidth",1.2);
stem(new_k,composed,"mo","linewidth",2);
hold off;
title("Convolution of two Poisson processes");
xlabel("k values");
ylabel("Probability");
legend("lambda=10","lambda=50","convolution");

# TASK: show that Poisson process is the limit of the binomial distribution.
k = 0:1:200;
# Define the desired Poisson Process
lambda = 30;
i = 1:1:3;
n = lambda.*power(10, i); 
p = lambda./n;

figure(3);
title("Poisson process as the limit of the binomial process");
xlabel("k values");
ylabel("Probability");
hold on;
for i=1:3
  binomial = binopdf(k,n(i),p(i));
  stem(k.+50*(i-1),binomial,colors(i),'linewidth',1.2);
endfor
legend("n=300","n=3000","n=30000");
hold off;

#Exponential Distrubution A

k = 0:0.00001:8;
inverse_lambda = [0.5,1,3];

for i=1:columns(inverse_lambda)
  exp_density(i,:) = exppdf(k,inverse_lambda(i));
endfor

colors = "rbkm";
figure(4, "graphicssmoothing","off");
hold on;
for i=1:columns(inverse_lambda)
   plot(k,exp_density(i,:),colors(i),"linewidth",3);
endfor
hold off;

title("Probability Mass Function of Exponential processes");
xlabel("k values");
ylabel("probability");
legend("1/lambda=0.5","1/lambda=1","1/lambda=3");

#Exponential Distrubution B

for i=1:columns(inverse_lambda)
  exp_distrib(i,:) = expcdf(k,inverse_lambda(i));
endfor

colors = "rbkm";
figure(5, "graphicssmoothing","off");
hold on;
for i=1:columns(inverse_lambda)
   plot(k,exp_distrib(i,:),colors(i),"linewidth",3);
endfor
hold off;

title("Cumulative Distribution Function of Exponential Processes");
xlabel("k values");
ylabel("probability");
legend("1/lambda=0.5","1/lambda=1","1/lambda=3", "location", "east");

#Exponential Distrubution C

inverse_lambda = 2.5;
distrib = expcdf(k,inverse_lambda);

printf("P(X>30000) is %d\n", 1-distrib(30000));
printf("P(X>50000|X>20000) is %d\n", (1-distrib(50000))/(1-distrib(20000)));

#Poisson Counting Process A

random_events = exprnd(1./5, 1, 100);   
#orismata: 1/l, arithmos grammwn, posa gegonota thelw
cnt=0;

for i=1:columns(random_events)
  x(i)=random_events(i) + cnt;
  cnt=x(i);
  N(i)=i;
endfor

figure(6);
stairs(x,N);
xlabel("t (sec)");
ylabel("N(t)");
title("Poisson counting process");

#Poisson Counting Process B
numberofevents = [100, 200, 300, 500, 1000, 10000];

for i=1:columns(numberofevents)
  cnt = 0;
  random_events = exprnd(1./5, 1, numberofevents(i));
  for j=1:columns(random_events)
    cnt = random_events(j) + cnt;
  endfor
  mean = numberofevents(i)./cnt;
  printf("For %d events, mean is %d\n", numberofevents(i), mean);
endfor