function [ alpha ] = get_alpha( anchors,T_0,n_nodes )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
alpha=[];
for k=1:T_0
    for i=1:n_nodes
        alpha=[alpha;anchors(:,k)];
     end
end





end

