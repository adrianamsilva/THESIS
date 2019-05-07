function [ M,b,L,K] = get_quadratic_map(A,B,D,E,J,K,N,u,q,alpha,x_prior,d_prior,r_prior,sigma_N,sigma_A,sigma_X,sigma_Omega,sigma_Upsilon,len_x,len_y,len_w,len_omega,len_upsilon)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%M------------------------------------------------------------------------
M1_aux=[(sigma_N*B*A),-sigma_N*B,zeros(len_x,len_w+len_omega+len_upsilon)];
M1=(M1_aux.')*M1_aux;

M2_aux=[sigma_A*D*E,zeros(len_w,len_y),-sigma_A*D,zeros(len_w,len_omega+len_upsilon)];
M2=(M2_aux.')*M2_aux;

M3_aux=[sigma_X*J,zeros(len_x,len_y+len_w+len_omega+len_upsilon)];
M3=(M3_aux.')*M3_aux;

M4_aux=[zeros(len_omega,len_y+len_w+len_x),sigma_Omega*K,zeros(len_omega,len_upsilon)];
M4=(M4_aux.')*M4_aux;

M5_aux=[zeros(len_upsilon,len_y+len_w+len_x+len_omega),sigma_Upsilon*N];
M5=(M5_aux.')*M5_aux;

M=M1+M2+M3+M4+M5;

%b------------------------------------------------------------------------
b1=(M2_aux.')*sigma_A*D*alpha;

b2=(M3_aux.')*sigma_X*J*x_prior;

b3=(M4_aux.')*sigma_Omega*K*d_prior;

b4=(M5_aux.')*sigma_Upsilon*N*r_prior;

b5=[zeros(1,len_x),(B*u).',(D*q).',zeros(1,len_omega+len_upsilon)].';

b=b1+b2+b3+b4+b5;

%K------------------------------------------------------------------------
K1=(sigma_A*D*alpha).'*(sigma_A*D*alpha);

K2=(sigma_X*J*x_prior).'*(sigma_X*J*x_prior);

K3=(sigma_Omega*K*d_prior).'*(sigma_Omega*K*d_prior);

K4=(sigma_Upsilon*N*r_prior).'*(sigma_Upsilon*N*r_prior);

K=K1+K2+K3+K4;

%Lipschitz constant
L=max(eig(M1))+max(eig(M2))+max(eig(M3))+max(eig(M4))+max(eig(M5));

end

