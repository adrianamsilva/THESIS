function [ M,b,L,K] = get_quadratic_mle(A,B,D,E,u,q,alpha,sigma_N,sigma_A,len_x,len_y,len_w)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%M------------------------------------------------------------------------
M1_aux=[(sigma_N*A),-sigma_N,zeros(len_x,len_w)];
M1=(M1_aux.')*M1_aux;

M2_aux=[sigma_A*E,zeros(len_w,len_y),-sigma_A];
M2=(M2_aux.')*M2_aux;

M=M1+M2;

%b------------------------------------------------------------------------
b1=(M2_aux.')*sigma_A*alpha;

b2=[zeros(1,len_x),(B*u).',(D*q).'].';

b=b1+b2;

%K------------------------------------------------------------------------
K=(sigma_A*alpha).'*(sigma_A*alpha);


%Lipschitz constant
L=max(eig(M1))+max(eig(M2));

end


