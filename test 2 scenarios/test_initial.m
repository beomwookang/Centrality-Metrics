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
y_si = zeros(1,k_size);  %y-axis plotting index 1 (for initial calculation

%D = ct_degree(A.Adj,n);
Dc = centrality(G, 'betweenness');
D = [Dc linspace(1,n,n)'];
Dsorted = sortrows(D, 1, 'descend');  %sort by degree in descending order
    
for k = 1:k_size  %number of node removal
    Ai = A.Adj;  %for initial calculation
    
    for i=1:k
        Ai(Dsorted(i,2),:) = zeros(1,n);  %remove connections between node with highest degree
        Ai(:,Dsorted(i,2)) = zeros(n,1);
    end
    
    Si = largestcomponent(Ai);
    n_Si = length(Si);    %size of giant component after k removal at once
    y_si(k) = n_Si;
end

toc

subplot(1,2,2);
plot(x_k, y_si, '--bo');
xlabel('number of removed nodes');
ylabel('size of giant component');