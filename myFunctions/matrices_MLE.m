function [ A_T_0, E_T_0,sigma_N, sigma_A,alpha,u,q,d,r ] = matrices_MLE( n_nodes,n_anchors,n_edges_node_node,edges_node_node,anchors,dim, T_0,range_dev_node_node, range_dev_node_anchor,angle_deviation, u_ij, d_vec,q_ik, r_ik, len_y, len_w )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%matrix A
[ A, A_T_0 ] = get_matrix_A( n_nodes, n_edges_node_node, edges_node_node, dim, T_0 );

%matrix E
[ E , E_T_0] = get_matrix_E( n_nodes, n_anchors, T_0, dim );

%Sigmas
[ sigma_N, sigma_A ] = create_sigmas( range_dev_node_node, range_dev_node_anchor, len_y, len_w );

%Alpha
[ alpha ] = get_alpha( anchors, T_0, n_nodes );

%Vector with all u_ij measurements
[ u ] = get_u( angle_deviation, u_ij, d_vec, n_edges_node_node, T_0, dim );

%Vector with all q_ik measurements
[ q ] = get_q( angle_deviation ,q_ik, r_ik, n_nodes, n_anchors, T_0, dim );

%Vector with all d_ij measurements
[ d ] = get_d( d_vec, T_0, n_edges_node_node );

%Vector with all q_ik measurements
[ r ] = get_r( r_ik, T_0, n_nodes, n_anchors );


end

