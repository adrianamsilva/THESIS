function [n_edges_node_node,n_edges_anchor_node]=get_n_edges(n_nodes,n_anchors)
%this function gives the number of edges between nodes of the network
%   input: number of nodes
%   output: number of edges

k_1=1;
e_k_1=0;

if n_nodes==1
    n_edges_node_node=0;
else
    for ii=2:n_nodes
        n_edges_node_node=e_k_1+k_1;
        
        k_1=k_1+1;
        e_k_1=n_edges_node_node;
    end
end

n_edges_anchor_node=n_anchors*n_nodes;

end
