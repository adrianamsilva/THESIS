function [ z,k,f_c_iter ] = nesterov( L,z,M,b,S,J,K,N,len_x,len_y,len_w,len_omega,len_upsilon,dim,d,r,prior_position_dev,prior_dist_dev )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

m=(length(nonzeros(J))/dim)*1/(prior_position_dev*prior_position_dev)+...
    length(nonzeros(K))*1/(prior_dist_dev*prior_dist_dev)+length(nonzeros(N))*1/(prior_dist_dev*prior_dist_dev);

flag=1;
k=1;

z_k_1=z;
z_k_2=z;
thresh=0.001;

while flag
    
    z = z_k_1+(1-sqrt(m/L))/(1+sqrt(m/L))*(z_k_1-z_k_2);
    
    grad = M*z-b; %gradient
    
    point = z-(1/L)*grad; 
    
    x_point=point(1:len_x);
    y_point=point(len_x+1:len_x+len_y);
    w_point=point(len_x+len_y+1:len_x+len_y+len_w);
    omega_point=point(len_x+len_y+len_w+1:len_x+len_y+len_w+len_omega);
    upsilon_point=point(len_x+len_y+len_w+len_omega+1:len_x+len_y+len_w+len_omega+len_upsilon);
        
    y_proj=proj_vector(len_y,dim,d,y_point); % project y component
    w_proj=proj_vector(len_w,dim,r,w_point); % project w component
    x_proj = x_point; % x does not have projection
    omega_proj = omega_point;
    upsilon_proj = upsilon_point;
    
    projected_point=[x_proj;y_proj;w_proj;omega_proj;upsilon_proj];
    z_k=projected_point;

    % check stop criteria
    %norma=norm(z_k-z_k_1)
    if(norm(z_k-z_k_1)<thresh)
        flag=0;
    end
    
    % update for next iteration
    k=k+1;
    z_k_1=z_k;
    z_k_2=z_k_1;
    
end

end



