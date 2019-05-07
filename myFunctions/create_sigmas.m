function [ sigma_N, sigma_A ] = create_sigmas( range_dev_node_node,range_dev_node_anchor,len_y,len_w )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

sigma_N=zeros(len_y,len_y);
sigma_A=zeros(len_w,len_w);

for i=1:len_y
    for j=1:len_y
        if i==j
        sigma_N(i,j)=range_dev_node_node;
        end
    end
end

for m=1:len_w
    for n=1:len_w
        if m==n
        sigma_A(m,n)=range_dev_node_anchor;
        end
    end
end


end