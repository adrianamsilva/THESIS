function [ x_est ] = get_positions( x,len_x,dim,n_nodes)
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here
x_est=[];
for i=1:dim*n_nodes:len_x
    
    x_est=[x_est x(i:i+dim*n_nodes-1)];
end


end

