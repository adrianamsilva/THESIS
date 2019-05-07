function [ A,A_T_0 ] = get_matrix_A( n_nodes,n_edges,edges,dim,T_0 )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
n_edges=3;
n_nodes=3;
dim=2;
edges=nchoosek([1:n_nodes],2);
%Arc-node incidence matrix
C=zeros(n_edges,n_nodes);

for i=1:n_edges
    for k=1:n_nodes
        if k==edges(i,1)
            C(i,k)=1;
        end
        if k==edges(i,2)
            C(i,k)=-1;
        end
        
    end
end

I_dim=eye(dim);
A=kron(C,I_dim);


A_T_0=kron(eye(T_0),A);

end

