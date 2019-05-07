function [ u_ij,q_ik ] = get_unit_vectors( nodes,anchors,n_nodes,n_anchors,T_0,edges, n_edges,angle_deviation,dim ) 
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here

for ii=1:n_nodes
    x(ii,:)=nodes(2*ii-1,:);
    y(ii,:)=nodes(2*ii,:);  
end

for ii=1:n_nodes
    x(ii,:)=nodes(2*ii-1,:);
    y(ii,:)=nodes(2*ii,:);  
end

u_ij=zeros(n_edges*dim,T_0);

for t=1:T_0
    bb=1;
    for n=1:n_nodes
        for m=1:n_nodes
            if edges(bb,1)==n && edges(bb,2)==m
                
                u_ij(bb*dim-1:bb*dim,t)=([x(n,t);y(n,t)]-[x(m,t);y(m,t)])/norm([x(n,t);y(n,t)]-[x(m,t);y(m,t)])+vmrand(0,angle_deviation);
                
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

q_ik=zeros(n_nodes*dim,n_anchors,T_0);

for t=1:T_0
    c=1;
    for i=1:n_nodes
        for k=1:n_anchors
            q_ik(c:c+1,k,t)=([x(i,t);y(i,t)]-[a_x(k,t);a_y(k,t)])/norm([x(i,t);y(i,t)]-[a_x(k,t);a_y(k,t)])+vmrand(0,angle_deviation);

        end
        c=c+dim;
    end
end







end

