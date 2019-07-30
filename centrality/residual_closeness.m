function Cr = residual_closeness(A)

%RESIDUAL_CLOSENESS
%          Residual closeness centraliy metric
%          Cr = residual_closeness(A), where A is an adjacency matrix,
%          computes residual closeness for each node by using k-shell decomposition

%          Author: Beom Woo Kang
%          Date: Jul 30, 2019

%          Reference:
%          C. Dangalchev, “Residual closeness in networks”,
%          Physica A: Statistical Mechanics and its Applications, vol.365, no.2, pp.556–564, 2006.

n = length(A);
Cr = zeros(n,1);

G = graph(A);
D = distances(G);

for i = 1:n
    sum = 0;
    for j = 1:n
        sum = sum + (0.5)^D(i,j);
    end
    Cr(i) = sum - 1;        %exclude the case (0.5)^D(i,i); D(i,i) = 0
end

%normalize result
cmax = max(Cr);
Cr = Cr./cmax;
    