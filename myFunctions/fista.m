function [ z,k ] = fista( L,z,M,b,len_x,len_y,len_w,dim,d,r)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

flag=1;
k=1;

z_k_1=z;
z_k_2=z;
thresh=0.001;

while flag
    
    z = z_k_1 + ((k-2)/(k+1))*(z_k_1-z_k_2);
    
    grad = M*z-b; %gradient
    
    point = z-(1/L)*grad; 
    
    x_point=point(1:len_x);
    y_point=point(len_x+1:len_x+len_y);
    w_point=point(len_x+len_y+1:len_x+len_y+len_w);
        
    y_proj=proj_vector(len_y,dim,d,y_point); % project y component
    w_proj=proj_vector(len_w,dim,r,w_point); % project w component
    x_proj = x_point; % x does not have projection
    
    projected_point=[x_proj;y_proj;w_proj];
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





