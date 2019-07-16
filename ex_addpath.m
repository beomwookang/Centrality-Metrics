addpath('Referred/largestcomponent/');
addpath('Referred/randGraphs/');

A = erdosRenyi(20, 0, 4);
plotGraphBasic(A, 6, 1);
G = largestcomponent(A.Adj);
