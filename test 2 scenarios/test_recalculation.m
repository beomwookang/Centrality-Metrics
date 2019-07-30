clear; clc; clf;

k_size = 200;
n = 200;  %inital size of network

A = er2(n, 0.1); %generate random graph
G = graph(A.Adj, 'upper');
subplot(1,2,1);
plot(G);         %initial graph
xlabel('original network');

tic
x_k = 1:k_size;   %x-axis plotting index
y_sr = zeros(1,k_size);  %y-axis plotting index 2 (for recalculation)

%D = ct_degree(A.Adj,n);
Dc = centrality(G, 'betweenness');
D = [Dc linspace(1,n,n)'];
Dr = D;       %static array for recalculation
[mv,mi] = max(Dr(:,1));
    
ri = 1;     %index for where to start new iteration
r_id = zeros(1,k_size);     %result history after each recalculation
r_id(1) = Dr(mi,2);     %save the first history

for k = 1:k_size  %number of node removal
    Ar = A.Adj;  %for recalculation
  
    %for recalculation
    for i = 1:ri
        Ar(Dr(r_id(i),2),:) = zeros(1,n);     %use history step by step to remove nodes
        Ar(:,Dr(r_id(i),2)) = zeros(n,1);
    end
    
    if ri > k
        continue;       %boundary condition
    end
    Dr = ct_degree(Ar,n);       %proceed one latest recalculation
    [mv,mi] = max(Dr(:,1));     %find the index of the top node
    r_id(ri+1) = mi;            %save the newest index in the history
    ri = ri + 1;                %to the next step
    
    Sr = largestcomponent(Ar);
    n_Sr = length(Sr);
    y_sr(k) = n_Sr;
end

toc

subplot(1,2,2);
plot(x_k, y_sr, '--rx');
xlabel('number of removed nodes');
ylabel('size of giant component');