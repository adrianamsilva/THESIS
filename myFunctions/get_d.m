function [ d ] = get_d( d_ij,T_0,n_edges )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

d=[];
for k=1:T_0
    for i=1:n_edges
        d=[d;d_ij(i,k)];
     end
end






end

