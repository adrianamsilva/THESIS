function [ z ] = cvx_cost_function(len_z,len_x,len_y,len_w,M,b,K,d,r,dim)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

cvx_begin quiet
    variables z(len_z,1) 
    
    minimize ( (1/2)*quad_form(z,M) - b'*z + K)
        
    subject to
    
        for j=1:dim:len_y-1
            norm(z(len_x+j:len_x+j+1)) <= d((j+1)/2);
        end

        for i=1:dim:len_w-1
            norm(z(i+len_x+len_y:len_x+len_y+i+1)) <= r((i+1)/2);
        end
    
cvx_end

end



