#Simulation of a System M/M/1/10 

clc;
clear all;
close all;

lambda = [1, 5, 10]; 
mu = 5;
%the threshold used to calculate probabilities 
for i=1:3
  threshold(i) = lambda(i)/(lambda(i) + mu);
endfor

%holds the transitions of the simulation in transitions steps 
transitions = 0;
arrivals = zeros(1,11); 
conv_check = false; 


#Debugging Code (for lambda = 1)

%{
rand("seed",1);
transitions = 0;
current_state = 1;  % holds the current state of the system
arrivals = zeros(1,11); 

while transitions < 30
  random = rand (1);
  transitions = transitions + 1;
  printf("Current state = %d\n", current_state - 1);
  %periptosi na exoume arrival se mia katastasi ektos tis katastasis me 10 pelates 
    if current_state == 1 || (random < threshold(i) && current_state < 11)
      arrivals(current_state) = arrivals(current_state) + 1;
      printf("Arrival\n");
      printf("Total Arrivals in this state are %d\n\n", arrivals(current_state));
      current_state = current_state + 1;
    %periptosi na exoume arrival stin katastasi me 10 pelates
    elseif (random < threshold(i))
      arrivals(current_state) = arrivals(current_state) + 1;
      printf("Arrival\n");
      printf("Total Arrivals in this state are: %d\n\n", arrivals(current_state));
    %periptosi na exoume departure
    else
        printf("Departure\n");
        printf("Total Arrivals in this state are: %d\n\n", arrivals(current_state));
        current_state = current_state - 1;
    end
end
%}



#Simulation for different lambdas

rand("seed",1);

for i=1:3  %gia ola ta lambda
  
  total_arrivals = 0; 
  current_state = 1;  
  previous_mean_clients = 0;
  index = 0;
  transitions = 0; 
  arrivals = zeros(1,11); 
  conv_check = false;
  result = []; 
  
  while (transitions <= 1000000 && ~conv_check)
    random = rand (1);
    % generating a random number between 0 and 1
    transitions = transitions + 1;
    %periptosi na exoume arrival se mia katastasi ektos tis katastasis me 10 pelates
    if current_state == 1 || (random < threshold(i) && current_state < 11)
      total_arrivals = total_arrivals + 1;
      arrivals(current_state) = arrivals(current_state) + 1;
      current_state = current_state + 1;
    %periptosi na exoume arrival stin katastasi me 10 pelates
    elseif (random < threshold(i))
      total_arrivals = total_arrivals + 1;
      arrivals(current_state) = arrivals(current_state) + 1;
    %periptosi na exoume departure
    else
        current_state = current_state - 1;
    end
    
    %check for convergence every 1000 transitions
    if mod(transitions, 1000) == 0 
      index = index + 1;
     
      %Ergodic Probabilites
      for j = 1:11
        P(j) = arrivals(j)/total_arrivals; 
      end
      
      %P(blocking)
      P_blocking = P(11);
      
      
      %Mean Clients   
      mean_clients = 0;
      for j = 1:11
        mean_clients = mean_clients + (j-1)*P(j);
      end
      result(index) = mean_clients; 
      
      %Average waiting time
      Average_waiting_time = mean_clients/(lambda(i)*(1 - P_blocking));
      
    
      if abs(mean_clients - previous_mean_clients) < 0.00001 
        conv_check = true;
      end
      previous_mean_clients = mean_clients;
      if conv_check || transitions > 1000000
        printf("P(blocking) for lambda = %d is %d\n",lambda(i), P_blocking);
        printf("Average waiting time for lambda = %d is %d\n\n",lambda(i), Average_waiting_time);
      end
    end
  endwhile
  
  first_figure = 2*i - 1;
  second_figure = 2*i;
  for j=1:2
    str1 = sprintf("Average number of clients in the M/M/1/10 queue: Convergence for lambda = %d",lambda(i));
    str2 = sprintf("Probabilities for lambda = %d", lambda(i));
    figure(first_figure);
    plot(result,"b","linewidth",1.3);
    title(str1);
    grid on;
    xlabel("transitions in thousands");
    ylabel("Average number of clients");

    figure(second_figure);
    bar(0:1:10, P,'b',0.7);
    grid on;
    title(str2);
  end
end 