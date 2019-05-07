function [d_ij,dist_vec,r_ik] = get_distances( nodes,anchors,T_0,n_nodes,n_anchors,edges ,n_edges,range_dev_node_node, range_dev_node_anchor)
%UNTITLED6 Summary of this function goes here
%   Input: nodes - position of the nodes
%          anchors - position of the anchors 
%          T_0 - limit of the time window
%   Output: d_ij - euclidean distance matrix over time 
%           r_ik - matrix with the distances between node i and anchor k
%           over time



for ii=1:n_nodes
    x(ii,:)=nodes(2*ii-1,:);
    y(ii,:)=nodes(2*ii,:);  
end

for ii=1:n_nodes
    x(ii,:)=nodes(2*ii-1,:);
    y(ii,:)=nodes(2*ii,:);  
end

for t=1:T_0
    bb=1;
    for n=1:n_edges
        for m=1:n_edges
            if edges(bb,1)==n && edges(bb,2)==m
                dist_vec(bb,t)=sqrt((x(n,t)-x(m,t))^2+(y(n,t)-y(m,t))^2)+range_dev_node_node*randn();
                if bb<n_edges
                 bb=bb+1;
                else 
                   break
                end
            end
            
        end
        
    end
end


for jj=1:n_anchors
    a_x(jj,:)=anchors(2*jj-1,:);
    a_y(jj,:)=anchors(2*jj,:);  
end

%node-node
d_ij=zeros(n_nodes,n_nodes,T_0);


for t=1:T_0
    for i=1:n_nodes-1
        for j=i+1:n_nodes
            
            d_ij(i,j,t)=sqrt((x(i,t)-x(j,t))^2+(y(i,t)-y(j,t))^2);
            d_ij(j,i,t)=d_ij(i,j,t);
            
        end
      
    end
    

end

%anchor-node
for t=1:T_0
    for i=1:n_nodes
        for k=1:n_anchors
            r_ik(i,k,t)=sqrt((x(i,t)-a_x(k,t))^2+(y(i,t)-a_y(k,t))^2)+range_dev_node_anchor*randn();
        end
    end
end

