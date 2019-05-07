function [ E ,E_T_0] = get_matrix_E( n_nodes,n_anchors,T_0,dim )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

%We assume that each node is connected with all the anchors
E=zeros(n_nodes*n_anchors,n_anchors);

anchor=1;

    for j=1:n_nodes
        E(anchor:anchor+n_anchors-1,j)=1;
        anchor=anchor+n_anchors;
    end
E= kron(E,eye(dim)); 
E_T_0=kron(eye(T_0),E);

end

