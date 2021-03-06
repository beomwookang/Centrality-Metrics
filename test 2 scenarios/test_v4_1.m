clear; clc; clf;

scale = 300;

k_perc = 1;

n = scale;  %inital size of network
k_size = ceil(n*k_perc);

A = er2(n, 0.1); %generate random graph
G = graph(A.Adj, 'upper');
subplot(1,2,1);
plot(G);         %initial graph
xlabel('original network');

tic
x_k = linspace(0,k_perc,n);   %x-axis plotting index
y_si = zeros(1,k_size);  %y-axis plotting index 1 (for initial calculation)
y_sr = zeros(1,k_size);  %y-axis plotting index 2 (for recalculation)

%D = ct_degree(A.Adj,n);
Dc = centrality(G, 'degree');
D = [Dc linspace(1,n,n)'];
Dr = D;       %static array for recalculation
Dsorted = sortrows(D, 1, 'descend');  %sort by degree in descending order
    
ri = 1;     %index for where to start new iteration
r_id = zeros(1,k_size);     %result history after each recalculation
r_id(1) = Dsorted(1,2);     %save the first history

Ai = A.Adj;  %for initial calculation
Ar = A.Adj;  %for recalculation

for k = 1:k_size  %number of node removal
    Ai(Dsorted(k,2),:) = zeros(1,n);  %remove connections between node with highest degree
    Ai(:,Dsorted(k,2)) = zeros(n,1);
    
    [~,binsize] = conncomp(graph(Ai));
    

    n_Si = max(binsize);    %size of giant component after k removal at once
    y_si(k) = n_Si/n;
    
    %for recalculation
    Ar(Dr(r_id(k),2),:) = zeros(1,n);     %use history step by step to remove nodes
    Ar(:,Dr(r_id(k),2)) = zeros(n,1);
    
    if ri > k
        continue;       %boundary condition
    end
    
    Gr = graph(Ar, 'upper');
    Dc = centrality(Gr, 'degree');       %proceed one latest recalculation
    Dr = [Dc linspace(1,n,n)'];
    [mv,mi] = max(Dr(:,1));     %find the index of the top node
    r_id(ri+1) = mi;            %save the newest index in the history
    ri = ri + 1;                %to the next step
    
%    Sr = largestcomponent(Ar);
    [~,binsize] = conncomp(graph(Ar));
%    n_Sr = length(Sr);
    n_Sr = max(binsize);
    y_sr(k) = n_Sr/n;
end

toc

subplot(1,2,2);
plot(x_k, y_si, '--bo');
hold on;
plot(x_k, y_sr, '--rx');
xlabel('number of removed nodes');
ylabel('size of giant component');
hold off;