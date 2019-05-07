function [ u ] = get_u( kappa, u_ij,d_ij,n_edges,T_0,dim )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here


u=[];
for k=1:T_0
    u_tau=[];
    for i=1:n_edges
        u_tilde=kappa*u_ij(i*dim-1:i*dim,k)/d_ij(i);

        u_tau=[u_tau;u_tilde];
    end
     u=[u;u_tau];
end










end

