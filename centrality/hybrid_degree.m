function [Ch] = hybrid_degree(A, a, b, p)

%HYBRID_DEGREE
%          Hybrid degree centraliy metric
%          Ch = hybrid_degree(A), where A is an adjacency matrix, p is
%          spreading probability, a is normalizing factor, b is adjusting ratio,
%          computes hybrid degree centrality for each node in A
%          This metric adopts modified local centrality (Chen 12') 
%          and degree (Freeman 79') for each node.

%          Author: Beom Woo Kang
%          Date: Jul 30, 2019

%          Reference:
%          Q. Ma and J. Ma, “Identifying and ranking influential spreaders 
%          in complex networks with consideration of spreading probability”,
%          Physica A: Statistical Mechanics and its Applications, vol.465, pp.312–330, 2017.

n = length(A);
Ch = zeros(n,1);

%compute modified local centrality (MLC)
Cl = local(A);      %original local centrality
for v = 1:n
    Nv = find(A(v,:));
end