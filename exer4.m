#Network with Alternatives

clc;
clear all;
close all;
a=0.001:0.001:0.999;
lambda=10000;
L=1024;
C1=15*1024*1024;
C2=12*1024*1024;
m1=C1/L;
m2=C2/L;
l1=a*lambda;
l2=(1-a)*lambda;
E1=l1./(m1-l1);
E2=l2./(m2-l2);
ET=(E1+E2)/lambda;
plot(a,ET);
ylabel("Average Waiting Time (sec)");
xlabel("Probability A");
[ET_min,a_min]=min(ET);
display("Minimizing E(T), value of a is:");
display(a(a_min));
display("Minimum delay is:");
display(ET_min);

#Open Network

#Intensities Function

function [r1 r2 r3 r4 r5 ergodic] = intensities (lambda1, lambda2, mu1, mu2, mu3, mu4, mu5)
 r1 = lambda1 / mu1;
 r2 = ((2 / 7) * lambda1 + lambda2) / mu2;
 r3 = (4 / 7) * lambda1 / mu3;
 r4 = (3 / 7) * lambda1 / mu4;
 r5 = ((4 / 7) * lambda1 + lambda2) / mu5;
 if (r1 < 1 &&
 r2 < 1 &&
 r3 < 1 &&
 r4 < 1 &&
 r5 < 1)
 ergodic = true;
 else
 ergodic = false;
 endif
 display(r1);
 display(r2);
 display(r3);
 display(r4);
 display(r5);
endfunction

#Mean Clients Function

function [clients1 clients2 clients3 clients4 clients5] = mean_clients(lambda1, lambda2, mu1, mu2,
mu3, mu4, mu5)
[r1 r2 r3 r4 r5] = intensities (lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);
 clients1 = r1/(1-r1);
 clients2 = r2/(1-r2);
 clients3 = r3/(1-r3);
 clients4 = r4/(1-r4);
 clients5 = r5/(1-r5);
endfunction

#Average Waiting Time Plot

lambda1 = (0.1: 0.01: 0.99)*6;
lambda2 = 1;
mu1 = 6;
mu2 = 5;
mu3 = 8;
mu4 = 7;
mu5 = 6;

for i = 1:1:90
  [c1 c2 c3 c4 c5] = mean_clients(lambda1(i), lambda2, mu1, mu2, mu3, mu4, mu5);
  clients = [c1 c2 c3 c4 c5];
  waiting_times(i) = sum(clients) / (lambda1(i) + lambda2);
endfor

figure(2);
plot(lambda1, waiting_times);
xlabel("l1");
ylabel("Average Waiting Time");
grid on;


