function [ d_vec_missing, r_ik_missing,missing_index,edge_type ] = measurements_with_missing_data( d_vec, r_ik, edges_node_node, edges_node_anchor, T_0,stop, n_nodes, n_anchors)
%UNTITLED21 Summary of this function goes here
%   Detailed explanation goes here
d_vec_missing=d_vec;
r_ik_missing=r_ik;

missing_index = get_missing_points( T_0,stop );

type_1='node-node';
type_2='node-anchor';

for k=1:T_0
    
    for pp=1:stop
        
        if missing_index(pp)==k
            [ edge_type, edge_missing, n_edge  ] = get_missing_variable( edges_node_node, edges_node_anchor );
            if strcmp(edge_type,type_1)
                d_vec_missing(n_edge,k)=NaN;
         
            elseif strcmp(edge_type,type_2)
                
                for aa=1:n_nodes
                    for bb=1:n_anchors
                        if aa==edge_missing(1) && bb==edge_missing(2)
                            r_ik_missing(aa,bb,k)=NaN;
                        end
                    end
                end
            end
            
        end
        
    end
    
end

end

function [ missing_index ] = get_missing_points( T_0,stop )
%UNTITLED18 Summary of this function goes here
%   Generates the indexes of the missing data 
%   There are no 2 consecutive missing points in time
while 1 
    missing_index=randperm(T_0,stop);
    missing_index=sort(missing_index);
    if missing_index(1)~=1
        break
    end
end

for jj=2:stop
    if abs(missing_index(jj)-missing_index(jj-1))==1
        b=randi([2 T_0]);
        
        if ismember(b,missing_index)==1 || abs(b-missing_index(jj-1))~=1
            while 1
                b=randi([2 T_0]);
                for tt=1:stop
                    aux(tt)=abs(missing_index(tt)-b);
                end
                if ismember(b,missing_index)==0 && ismember(1,aux)==0
                    missing_index(jj)=b;
                    break
                end
            end
        end
    end
end
missing_index=sort(missing_index);

end



function [ edge_type, edge_missing, n_edge  ] = get_missing_variable( edges_node_node, edges_node_anchor )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here
%   Type 1: node_node measurement
%   Type 2: node-anchor measurement

type=randi([1 2]);

n_edge=0;
edge_missing=zeros(1,2);

if type==1
    n_edge=randi([1 length(edges_node_node(:,1))]);
    edge_missing=edges_node_node(n_edge,:);
elseif type==2
    n_edge=randi([1 length(edges_node_anchor(:,1))]);
    edge_missing=edges_node_anchor(n_edge,:);
end

if type==1
    edge_type='node-node';
elseif type==2
    edge_type='node-anchor';
end
end


