clear; clc; clf;

k_size = 100;
n = 100;  %inital size of network

A = er2(n, 0.1); %generate random graph
G = graph(A.Adj, 'upper');
subplot(1,2,1);
plot(G);         %initial graph
xlabel('original network');

tic
x_k = 1:k_size;   %x-axis plotting index
y_si = zeros(1,k_size);  %y-axis plotting index 1 (for initial calculation)
y_sr = zeros(1,k_size);  %y-axis plotting index 2 (for recalculation)

D = ct_degree(A.Adj,n);
D = sortrows(D, 1, 'descend');  %sort by degree in descending order
    
for k = 1:k_size  %number of node removal
    Ai = A.Adj;  %for initial calculation
    Ar = A.Adj;  %for recalculation
    
    for i=1:k
        Ai(D(i,2),:) = zeros(1,n);  %remove connections between node with highest degree
        Ai(:,D(i,2)) = zeros(n,1);
    end
    
    Si = largestcomponent(Ai);
    n_Si = length(Si);    %size of giant component after k removal at once
    y_si(k) = n_Si;
    
    %for recalculation
    Ar(D(1,2),:) = zeros(1,n);   %remove connections
    Ar(:,D(1,2)) = zeros(n,1);
    Dr = ct_degree(Ar,n);  %recalculate after removal
    %Dr = sortrows(Dr, 1, 'descend'); %sort new degree list
    [mv,mi] = max(Dr(:,1));  %find top node
 
    for i=2:k
       Ar(Dr(mi,2),:) = zeros(1,n);   %remove connections
       Ar(:,Dr(mi,2)) = zeros(n,1);
       
       Dr = ct_degree(Ar,n);  %recalculate after removal
       %Dr = sortrows(Dr, 1, 'descend'); %sort new degree list
       [mv,mi] = max(Dr(:,1));
    end
    
    Sr = largestcomponent(Ar);
    n_Sr = length(Sr);
    y_sr(k) = n_Sr;
end

toc

subplot(1,2,2);
plot(x_k, y_si, '--bo');
hold on;
plot(x_k, y_sr, '--rx');
xlabel('number of removed nodes');
ylabel('size of giant component');
hold off;
