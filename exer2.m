pkg load queueing;

close all;
clear all;
clc;

#Analysis of Queue M/M/1: b

m = 5.05:0.05:10;
lambda = 5;

#auti i entoli epistrefei ta xaraktiristika tis ouras

[U, R, Q, X, p0] = qsmm1(lambda, m); 

figure(1);
for i=1:columns(lambda)
  plot(m,U,"linewidth",1.2);
endfor
title("Server Utilization Diagram");
xlabel("m values");
ylabel("Server Utilization");

figure(2);
for i=1:columns(lambda)
  plot(m,R,"linewidth",1.2);
endfor
title("Server Response Time Diagram");
xlabel("m values");
ylabel("Server Response Time");

figure(3);
for i=1:columns(lambda)
  plot(m,Q,"linewidth",1.2);
endfor
title("Average Number of Requests in the System Diagram");
xlabel("m values");
ylabel("Average Number of Requests in the System");

figure(4);
for i=1:columns(lambda)
  plot(m,X,"linewidth",1.2);
endfor
title("Server Throughput diagram");
xlabel("m values");
ylabel("Server Throughput");

#Birth-Death Process: Queue M/M/1/K: b i)

lambda = 5;
mu = 10;
states = [0, 1, 2, 3, 4]; % system with capacity 4 states
% the initial state of the system. The system is initially empty.
initial_state = [1, 0, 0, 0, 0];

% define the birth and death rates between the states of the system.
births_B = [lambda, lambda/2, lambda/3, lambda/4];
deaths_D = [mu, mu, mu, mu];

% get the transition matrix of the birth-death process
transition_matrix = ctmcbd(births_B, deaths_D);
% get the ergodic probabilities of the system
P = ctmc(transition_matrix);
disp("Transition matrix is:"), disp(transition_matrix)
disp("Ergodic probabilities are:"), disp(P)

#Birth-Death Process: Queue M/M/1/K: b ii)

% plot the ergodic probabilities (bar for bar chart)
figure(5);
bar(states, P, "r", 0.5);

#Birth-Death Process: Queue M/M/1/K: b iii) and iv)

n=[0,1,2,3,4];
counter=0;
for i=1:5
  counter=n(i)*P(i)+counter;
endfor
block=P(5);
disp("Mean value of customers is:"), disp(counter)
disp("Blocking probability is:"), disp(block)

#Birth-Death Process: Queue M/M/1/K: b v) and vi)

% transient probability of state 0 until convergence to ergodic probability. Convergence takes place P0 and P differ by 0.01
mu = [1, 5, 10, 20];

#gia kathe diaforetiko m ypologizoume ergodikes
#kai sxediazoume ta diagrammata twn pithanotitwn
#mexri na ftasoun tis ergodikes kata 99%

for j=1:columns(mu)
  
  deaths_D = [mu(j), mu(j), mu(j), mu(j)];
  transition_matrix = ctmcbd ( births_B , deaths_D );
  P = ctmc(transition_matrix);
  index = 0;
  Prob0 = [];
  Prob1 = [];
  Prob2 = [];
  Prob3 = [];
  Prob4 = [];
  for T = 0 : 0.01 : 50
    index = index + 1;
    P0 = ctmc(transition_matrix, T, initial_state);
    Prob0 ( index ) = P0 (1) ;
    Prob1 ( index ) = P0 (2) ;
    Prob2 ( index ) = P0 (3) ;
    Prob3 ( index ) = P0 (4) ;
    Prob4 ( index ) = P0 (5) ;
    if P0 - P < 0.01
      break;
   endif
  endfor

  T = 0 : 0.01 : T;
  figure(j+5);
  str = sprintf("Probabilities of system states with lambda = %d and mu = %d", lambda, mu(j));
  title (str)
  xlabel (" Time (sec)")
  ylabel (" Probability ")
  hold on;
  plot(T, Prob0, "r", "linewidth", 1.5);
  plot(T, Prob1, "g", "linewidth", 1.5);
  plot(T, Prob2, "b", "linewidth", 1.5);
  plot(T, Prob3, "k", "linewidth", 1.5);
  plot(T, Prob4, "m", "linewidth", 1.5);
  legend (" State : 0"," State : 1"," State : 2"," State : 3"," State : 4");
  hold off;
endfor