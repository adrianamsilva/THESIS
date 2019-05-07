function [ M,missing_index,total_points,number_missing_points ] = get_missing_data_3( edges_node_node, edges_node_anchor,n_edges_node_node, n_edges_node_anchor, T_0,missing_points_percent)
%UNTITLED2 Summary of this function goes here
%   we only get one missing measurement per each time instant
%   we assume we don't have two consecutive missing instants

M  = get_all_edges_time( n_edges_node_node,n_edges_node_anchor,edges_node_node,edges_node_anchor,T_0  );

%Total of points and number of missing points
total_points=(n_edges_node_node+n_edges_node_anchor)*T_0;
number_missing_points=round(missing_points_percent/100*total_points);


%Selects the missing indexes
missing_index= get_missing_indexes( total_points,number_missing_points,n_edges_node_node,n_edges_node_anchor );






end

function [ M ] = get_all_edges_time( n_edges_node_node,n_edges_node_anchor,edges_node_node,edges_node_anchor,T_0 )
%Create cell with all de edges of tipe i-j and i-k
nn_edges=cell(n_edges_node_node,2);
na_edges=cell(n_edges_node_anchor,2);

for i=1:n_edges_node_node
    nn_edges(i,1)={'d_ij'};
    nn_edges(i,2)={edges_node_node(i,:)};
end

for j=1:n_edges_node_anchor
    na_edges(j,1)={'r_ik'};
    na_edges(j,2)={edges_node_anchor(j,:)};
end

all_edges=[nn_edges;na_edges];

%Creates cell with all edges over time
M=[];
for k=1:T_0
    
    for p=1:length(all_edges)
        aux_m(p,:)=[all_edges(p,:) k];
    end
    
    M=[M;aux_m];
    
end
end

function [ missing_index ] = get_missing_indexes( total_points,number_missing_points,n_edges_node_node,n_edges_node_anchor )


missing_index=[];
for i=1:number_missing_points
    while 1
        miss_index_aux=randi([n_edges_node_node+n_edges_node_anchor total_points],1);
        
        if ismember(miss_index_aux+12,missing_index)==1 || ismember(miss_index_aux-12,missing_index)==1 || ismember(miss_index_aux,missing_index)==1
        
        else
            break
        end
    end
    
    missing_index=[missing_index miss_index_aux];
end
missing_index=sort(missing_index);

end

