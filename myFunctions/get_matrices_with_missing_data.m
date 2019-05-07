function [ d_missing,r_missing,missing_d_ij,missing_r_ik,u_missing,q_missing] = get_matrices_with_missing_data( M, missing_index,number_missing_points,total_points,n_edges_node_node,n_edges_node_anchor ,d,r,u,q,T_0,edges_node_anchor,edges_node_node,dim)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
missing_d_ij={};
missing_r_ik={};

for i=1:total_points
    for j=1:number_missing_points
        if i==missing_index(j)
            if strcmp(M{i,1},'d_ij')
                aux_d={M{i,1} M{i,2} M{i,3}};
                missing_d_ij=[missing_d_ij; aux_d];
            elseif strcmp(M{i,1},'r_ik')
                aux_r={M{i,1} M{i,2} M{i,3}};
                missing_r_ik=[missing_r_ik; aux_r];
            end
            
        end    
    end
end

if isempty(missing_d_ij)
    missing_d_ij(1,1)={'d_ij'};
    missing_d_ij(1,2)={0};
    missing_d_ij(1,3)={0};
end

if isempty(missing_r_ik)
    missing_r_ik(1,1)={'r_ik'};
    missing_r_ik(1,2)={0};
    missing_r_ik(1,3)={0};
end
% 
 d_missing=d;

for k=1:T_0
    for tt=1:length(missing_d_ij(:,3))
        if k==missing_d_ij{tt,3}
            for h=1:n_edges_node_node
                if isequal(missing_d_ij{tt,2},edges_node_node(h,:))
                    d_missing(k*n_edges_node_node-n_edges_node_node+h,1)=NaN;
                end
            end
        end
    end
end

 u_missing=u;

for k=1:T_0
    for tt=1:length(missing_d_ij(:,3))
        if k==missing_d_ij{tt,3}
            for h=1:n_edges_node_node
                if isequal(missing_d_ij{tt,2},edges_node_node(h,:))
                    u_missing(k*n_edges_node_node*dim-n_edges_node_node*dim+h*dim-1:k*n_edges_node_node*dim-n_edges_node_node*dim+h*dim,1)=NaN;
                end
            end
        end
    end
end


%ATE AQUI
% for k=1:T_0
%     for tt=1:length(missing_d_ij)
%         if k==missing_d_ij{tt,3}
%             
%             if isequal(missing_d_ij{tt,2},edge_12)
%                 d_missing(k*n_edges_node_node-2,1)=NaN;
%                 
%             elseif isequal(missing_d_ij{tt,2},edge_13)
%                 d_missing(k*n_edges_node_node-1,1)=NaN;
%                 
%             elseif isequal(missing_d_ij{tt,2},edge_23)
%                 d_missing(k*n_edges_node_node,1)=NaN;
%             end
%         end
%         
%     end
% end


% ik_11=[1 1];
% ik_12=[1 2];
% ik_13=[1 3];
% ik_21=[2 1];
% ik_22=[2 2];
% ik_23=[2 3];
% ik_31=[3 1];
% ik_32=[3 2];
% ik_33=[3 3];

%A PARTIR DAQUI
r_missing=r;

for k=1:T_0
    for tt=1:length(missing_r_ik(:,3))
        if k==missing_r_ik{tt,3}
            for h=1:n_edges_node_anchor
               
                if isequal(missing_r_ik{tt,2},edges_node_anchor(h,:))
                    r_missing(k*n_edges_node_anchor-n_edges_node_anchor+h,1)=NaN;
                end
            end
        end
    end
end

q_missing=q;

for k=1:T_0
    for tt=1:length(missing_r_ik(:,3))
        if k==missing_r_ik{tt,3}
            for h=1:n_edges_node_anchor
               
                if isequal(missing_r_ik{tt,2},edges_node_anchor(h,:))
                    q_missing(k*n_edges_node_anchor*dim-n_edges_node_anchor*dim+h*dim-1:k*n_edges_node_anchor*dim-n_edges_node_anchor*dim+h*dim,1)=NaN;
                end
            end
        end
    end
end
%ATE AQUI OUTRA VEZ
% for k=1:T_0
%     for tt=1:length(missing_r_ik)
%         if k==missing_r_ik{tt,3}
%             
%             if isequal(missing_r_ik{tt,2},ik_11)
%                 r_missing(k*n_edges_node_anchor-8,1)=NaN;
%                 
%             elseif isequal(missing_r_ik{tt,2},ik_12)
%                 r_missing(k*n_edges_node_anchor-7,1)=NaN;
%                 
%             elseif isequal(missing_r_ik{tt,2},ik_13)
%                 r_missing(k*n_edges_node_anchor-6,1)=NaN;
%                 
%             elseif isequal(missing_r_ik{tt,2},ik_21)
%                 r_missing(k*n_edges_node_anchor-5,1)=NaN;
%                 
%             elseif isequal(missing_r_ik{tt,2},ik_22)
%                 r_missing(k*n_edges_node_anchor-4,1)=NaN;
%                 
%             elseif isequal(missing_r_ik{tt,2},ik_23)
%                 r_missing(k*n_edges_node_anchor-3,1)=NaN;
%                 
%              elseif isequal(missing_r_ik{tt,2},ik_31)
%                 r_missing(k*n_edges_node_anchor-2,1)=NaN;
%                 
%             elseif isequal(missing_r_ik{tt,2},ik_32)
%                 r_missing(k*n_edges_node_anchor-1,1)=NaN;
%                 
%             elseif isequal(missing_r_ik{tt,2},ik_33)
%                 r_missing(k*n_edges_node_anchor,1)=NaN;
%             end
%         end
%         
%     end
% end

end

