function [ edges_node_node,edges_node_anchor ] = get_edges( n_nodes,n_anchors )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

edges_node_node=nchoosek([1:n_nodes],2);

edges_node_anchor=unique(nchoosek([1:n_nodes 1:n_anchors],2),'rows');

end

