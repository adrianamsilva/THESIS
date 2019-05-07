function [y_proj]=proj_vector(len_y,dim,d,y_point)
% proj_vector projects vector y, with constraints defined by vector d.
%   Input : 
%   - y : concatenation of vectors of dimension dim
%   - dim :dimension
%   - d : concatenation of distances corresponding to each vector of y
%   Output
%   - y_proj : projection of vector y

y_proj = zeros(len_y,1);
for i=1:(len_y/dim) 
 
    p = y_point(2*dim-1:2*dim); % for each vector of dimension dim
    dist = d(i); % correspondent distance in d
    center = zeros(dim,1); % center is zero
    

if(norm(p-center)<=dist) % already fulfills condition, no need to project
    projected_point=p;
else
    projected_point =center+ dist*(p-center)/(norm(p-center));
end

    proj = projected_point; % projection of l2 norm ball
    y_proj((i-1)*dim+1: i*dim) = proj; % update projected vector

end

end


