function [J, Q, d_prior, M ,r_prior, sigma_X, sigma_Omega, sigma_Upsilon, x_prior,B,C,len_omega,len_upsilon] = get_priors( missing_d_ij, missing_r_ik, dim, n_nodes, T_0,edges_node_node,n_edges_node_node,edges_node_anchor,n_edges_node_anchor,d,r,prior_position_dev,prior_dist_dev,len_y,len_x,len_w,x_nodes)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%matrix J: indicates which nodes need the prior position

P=zeros(n_nodes*T_0);

if missing_d_ij{1,3}~=0
    for j=1:length(missing_d_ij(:,3))
        node_1=missing_d_ij{j,2}(1);
        node_2=missing_d_ij{j,2}(2);
        time=missing_d_ij{j,3};
        
        i_1=time*n_nodes-n_nodes+node_1;
        i_2=time*n_nodes-n_nodes+node_2;
        
        P(i_1,i_1)=1;
        P(i_2,i_2)=1;
    end
end

if missing_r_ik{1,3}~=0
    for j=1:length(missing_r_ik(:,3))
        node=missing_r_ik{j,2}(1);
        time=missing_r_ik{j,3};
        
        i=time*n_nodes-n_nodes+node;
        
        P(i,i)=1;
    end
end

J=kron(P,eye(dim));
%------------------------------------------------------------
%Matrix K - indicates which d_ij's will be estimated
Q=zeros(n_edges_node_node*T_0);

if missing_d_ij{1,3}~=0
for j=1:length(missing_d_ij(:,3))    
    for h=1:n_edges_node_node
        if isequal(missing_d_ij{j,2},edges_node_node(h,:))
            edge=h;
        end
    end
    time=missing_d_ij{j,3};
    
    i=time*n_edges_node_node-n_edges_node_node+edge;
    
    Q(i,i)=1;
end
end
%K=kron(Q,eye(dim));
%-------------------------------------------------------------------
%Matrix N - indicates which r_ik's will be estimated
M=zeros(n_edges_node_anchor*T_0);

if missing_r_ik{1,3}~=0
for j=1:length(missing_r_ik(:,3))    
    for h=1:n_edges_node_anchor
        if isequal(missing_r_ik{j,2},edges_node_anchor(h,:))
            edge=h;
        end
    end
    time=missing_r_ik{j,3};
    
    i=time*n_edges_node_anchor-n_edges_node_anchor+edge;
    
    M(i,i)=1;
end
end
%N=kron(M,eye(dim));
%-------------------------------------------------------------------
d_prior=zeros(dim*n_edges_node_node,1);

for g=1:length(d)-n_edges_node_node
    d_prior(g+n_edges_node_node)=d(g);
end

%D=Q*d_prior;
%------------------------------------------------------------------
r_prior=zeros(dim*n_edges_node_anchor,1);

for g=1:length(r)-n_edges_node_anchor
    r_prior(g+n_edges_node_anchor)=r(g);
end

%R=M*r_prior;
%-------------------------------------------------------------------
len_omega=n_edges_node_node*T_0;
len_upsilon=n_edges_node_anchor*T_0;

sigma_X=zeros(len_x,len_x);
sigma_Omega=zeros(len_omega,len_omega);
sigma_Upsilon=zeros(len_upsilon,len_upsilon);

for i=1:len_omega
    for j=1:len_omega
        if i==j
            sigma_Omega(i,j)=prior_position_dev;
        end
    end
end

for i=1:len_x
    for j=1:len_x
        if i==j
            sigma_X(i,j)=prior_dist_dev;
        end
    end
end

for i=1:len_upsilon
    for j=1:len_upsilon
        if i==j
            sigma_Upsilon(i,j)=prior_dist_dev;
        end
    end
end

%----------------------------------------------------------------------
x_prior=zeros(dim*n_nodes*T_0,1);

x=[];
for k=1:T_0
        x=[x;x_nodes(:,k)];
end

for g=1:dim*n_nodes*(T_0-1)
    x_prior(g+n_nodes*dim)=x(g);
end


%---------------------------------------------------------------------
I_d=eye(n_edges_node_node*T_0);
I_r=eye(n_edges_node_anchor*T_0);
I_dim=eye(dim);

B1=I_d-Q;
B=kron(B1,I_dim);

C1=I_r-M;
C=kron(C1,I_dim);


end