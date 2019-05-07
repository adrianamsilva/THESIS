function [ r ] = get_r( r_ik,T_0,n_nodes,n_anchors )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

r=[];
for k=1:T_0
    for i=1:n_nodes
        for j=1:n_anchors
        r=[r;r_ik(i,j,k)];
        end
     end
end


end

