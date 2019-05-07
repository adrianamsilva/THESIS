clc;
clear all;
close all;

addpath(genpath('.\myFunctions'))


%% Network
n_nodes = 3;
n_anchors = 3;

dim = 2; %2D

%number of edges and pairs of edges node-node and node-anchor of the network
[ n_edges_node_node, n_edges_node_anchor ] = get_n_edges( n_nodes, n_anchors );
[ edges_node_node, edges_node_anchor ] = get_edges( n_nodes, n_anchors );


%% Input variables
%Noise parameters
range_dev_node_node = 0.5;       %sigma
range_dev_node_anchor = 0.5;     %varsigma
prior_dist_dev = 0.5;            %gamma
prior_position_dev = 2;          %beta
angle_deviation = 6000;          %concentration parameter

%% TRAJECTORY
% Options : 'linear','spiral'
trajectory_type = 'linear';

[ nodes, anchors, T_0 ] = generate_trajectory( trajectory_type );

%% MEASUREMENTS
%d_vec coresponds to the n_edges_ij*T_0 matrix of distances between nodes;
%r_ik corresponds to the i*k*T_0 matrix of distances between nodes and anchors

[ d_ij, d_vec, r_ik ] = get_distances( nodes, anchors, T_0, n_nodes, n_anchors,...
    edges_node_node, n_edges_node_node, range_dev_node_node, range_dev_node_anchor );

%u_ij coresponds to the n_edges_ij*dim*T_0 matrix of unit vectors between nodes;
%q_ik corresponds to the (i*dim)*k*T_0 matrix of distances between nodes and anchors
[ u_ij, q_ik ] = get_unit_vectors( nodes, anchors, n_nodes, n_anchors, T_0,...
    edges_node_node, n_edges_node_node, angle_deviation, dim );

%% MATRICES MLE
%Lengths
len_x = n_edges_node_node*dim*T_0;
len_y = n_edges_node_node*dim*T_0;
len_w = n_nodes*n_anchors*dim*T_0;

%MLE Matrices
[ A, E, sigma_N, sigma_A, alpha, u, q, d, r ] = matrices_MLE( n_nodes,n_anchors,...
    n_edges_node_node, edges_node_node, anchors, dim, T_0, range_dev_node_node,...
    range_dev_node_anchor, angle_deviation, u_ij, d_vec,q_ik, r_ik, len_y, len_w );

%% MISSING DATA AND MAP MATRICES

%Percentage of missing measurements
missing_points_percentage = 0;

%Generates random points
[ M_all_edges, missing_index, total_points, number_missing_points ] = get_missing_data_3( edges_node_node,...
                                edges_node_anchor, n_edges_node_node, n_edges_node_anchor, T_0, missing_points_percentage );

%Missing edges
[ d_missing, r_missing, missing_d_ij, missing_r_ik, u_missing, q_missing] = get_matrices_with_missing_data( M_all_edges,...
                                missing_index, number_missing_points,total_points, n_edges_node_node, n_edges_node_anchor,...
                                d, r, u, q, T_0, edges_node_anchor, edges_node_node,dim );

%MAP Matrices and prior measurements                            
[J, K, d_prior, N, r_prior, sigma_X, sigma_Omega, sigma_Upsilon, x_prior,B,D,len_omega,len_upsilon] = get_priors( missing_d_ij,...
                                missing_r_ik, dim, n_nodes, T_0, edges_node_node, n_edges_node_node, edges_node_anchor,...
                                n_edges_node_anchor, d, r, prior_position_dev, prior_dist_dev, len_y, len_x, len_w,nodes );


%% MLE

%Cost function and Lipschitz constant
[ M_mle,b_mle,L_mle,K_mle] = get_quadratic_mle(A,B,D,E,u,q,alpha,sigma_N,sigma_A,len_x,len_y,len_w);

len_z_mle=len_x+len_y+len_w; %Length of z
z_0_mle=zeros(len_z_mle,1);  %Initialization

%Fista
[z_mle_fista,k_iter_fista ] = fista( L_mle,z_0_mle,M_mle,b_mle,len_x,len_y,len_w,dim,d,r);

%Cvx
[ z_mle_cvx ] = cvx_cost_function(len_z_mle,len_x,len_y,len_w,M_mle,b_mle,K_mle,d,r,dim);

%% MAP

%Cost function and Lipschitz constant
[M_map,b_map,L_map,K_map] = get_quadratic_map(A,B,D,E,J,K,N,u,q,alpha,x_prior,d_prior,r_prior,sigma_N,...
                            sigma_A,sigma_X,sigma_Omega,sigma_Upsilon,len_x,len_y,len_w,len_omega,len_upsilon);
                        
len_z_map=len_z_mle+len_omega+len_upsilon; %Length of z
z_0_map=zeros(len_z_map,1);                %Initialization                     

%Nesterov
[z_map_nesterov,k_iter_nesterov ]= nesterov( L_map,z_0_map,M_map,b_map,K_map,J,K,N,len_x,len_y,len_w,len_omega,...
                                             len_upsilon,dim,d,r,prior_position_dev,prior_dist_dev );

%Cvx
[ z_map_cvx ] = cvx_cost_function(len_z_map,len_x,len_y,len_w,M_map,b_map,K_map,d,r,dim);


%% PLOTS

%Plot fista mle
x_mle_fista=z_mle_fista(1:len_x);
[ x_est_mle_fista ] = get_positions( x_mle_fista, len_x, dim, n_nodes);
get_plots( anchors, nodes, x_est_mle_fista )
title('MLE fista')

%Plot cvx mle
x_mle_cvx=z_mle_cvx(1:len_x);
[ x_est_mle_cvx ] = get_positions( x_mle_cvx, len_x, dim, n_nodes);
get_plots( anchors, nodes, x_est_mle_cvx )
title('MLE Cvx')

%Plot nesterov map
x_map_nesterov=z_map_nesterov(1:len_x);
[ x_est_map_nesterov ] = get_positions( x_map_nesterov, len_x, dim, n_nodes);
get_plots( anchors, nodes, x_est_map_nesterov )
title('MAP Nesterov')

%Plot cvx map
x_map_cvx=z_map_cvx(1:len_x);
[ x_est_map_cvx ] = get_positions( x_map_cvx, len_x, dim, n_nodes);
get_plots( anchors, nodes, x_est_map_cvx )
title('MAP Cvx')


