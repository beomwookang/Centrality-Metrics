clear; clc; clf;

k_size = 300;
n = 300;  %inital size of network

A = er2(n, 0.1); %generate random graph
G = graph(A.Adj, 'upper');
subplot(1,2,1);
plot(G);         %initial graph
xlabel('original network');

tic
x_k = 1:k_size;   %x-axis plotting index
y_si = zeros(1,k_size);  %y-axis plotting index 1 (for initial calculation)
y_sr = zeros(1,k_size);  %y-axis plotting index 2 (for recalculation)

%G = graph(A.Adj);
degs = mixed_degree_decompostion(A.Adj, 0.7);
%degs = centrality(G, 'betweenness');
[degsorted,nodesort] = sort(degs,'descend');

%D = ct_degree(A.Adj,n);
%Dr = D;       %static array for recalculation
%Dsorted = sortrows(D, 1, 'descend');  %sort by degree in descending order
    
%ri = 1;     %index for where to start new iteration
%r_id = zeros(1,k_size);     %result history after each recalculation
%r_id(1) = Dsorted(1,2);     %save the first history

%Ai = A.Adj;  %for initial calculation
Ar = A.Adj;  %for recalculation

nodesort2=size(nodesort);
nodesort2(1) =nodesort(1);
for k=1:n-1
    Ar(nodesort2(k),:) = zeros(1,n);
    Ar(:,nodesort2(k)) = zeros(n,1);
    
    %Gr = graph(Ar);
    ndegs = mixed_degree_decompostion(Ar,0.7);
    %ndegs = centrality(Gr, 'betweenness');
    [tdeg,tempnode]=max(ndegs);
    if tdeg==0
        temp = setdiff(1:n,nodesort2);
        nodesort2(k+1:n)=temp;
        break;
    else
        nodesort2(k+1) = tempnode;
    end
end
    

%for k = 1:k_size  %number of node removal
    
%    for i=1:k
%        Ai(Dsorted(k,2),:) = zeros(1,n);  %remove connections between node with highest degree
%        Ai(:,Dsorted(k,2)) = zeros(n,1);
%    end
    
%    Si = largestcomponent(Ai);
%    [~,binsize] = conncomp(graph(Ai));
    
%    n_Si = length(Si);    %size of giant component after k removal at once
%    n_Si = max(binsize);
%    y_si(k) = n_Si;
    
    %for recalculation
%    for i = 1:ri
%        Ar(Dr(r_id(k),2),:) = zeros(1,n);     %use history step by step to remove nodes
%        Ar(:,Dr(r_id(k),2)) = zeros(n,1);
%    end
    
%    if ri > k
%        continue;       %boundary condition
%    end
%    Dr = ct_degree(Ar,n);       %proceed one latest recalculation
%    [mv,mi] = max(Dr(:,1));     %find the index of the top node
%    r_id(ri+1) = mi;            %save the newest index in the history
%    ri = ri + 1;                %to the next step
    
%    Sr = largestcomponent(Ar);
%    [~,binsize] = conncomp(graph(Ar));
%    n_Sr = length(Sr);
%    n_Sr = max(binsize);
%    y_sr(k) = n_Sr;
%end

y_si = flipud(orderednodeaddition(A.Adj,flipud(nodesort(:))));
y_sr = flipud(orderednodeaddition(A.Adj,flipud(nodesort2(:))));

toc

subplot(1,2,2);
plot(x_k, y_si, '--bo');
hold on;
plot(x_k, y_sr, '--rx');
xlabel('number of removed nodes');
ylabel('size of giant component');
hold off;