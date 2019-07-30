function [Cl] = ct_load(A, b)

n = length(A);  %number of nodes
Cl = zeros(n, 1);   %container for load centrality

for v = 1:n
   Cl(v) = n*log10(n)*(n/v)^b;
end