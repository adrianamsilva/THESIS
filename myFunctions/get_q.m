function [ q ] = get_q( lambda,q_ik, r_ik,n_nodes,n_anchors,T_0,dim )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

q=[];
for k=1:T_0
    q_tau=[];
    for i=1:n_nodes
        for j=1:n_anchors
        q_tilde=lambda*q_ik(i*dim-1:i*dim,j,k)/r_ik(i,j);

        q_tau=[q_tau;q_tilde];
        end
    end
     q=[q;q_tau];
end












end

