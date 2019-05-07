function [ nodes,anchors,T_0] = generate_trajectory(type)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Trajectory Types
switch type
    
    case 'linear'
%% Position of the anchors

init_pos_1=[40;20];
init_pos_2=[5;5];
init_pos_3=[5;35];

x_max=100;
n=50;

a1(1,:)=linspace(init_pos_1(1),x_max+init_pos_1(1),n);
a1(2,1:n)=init_pos_1(2);

a2(1,:)=linspace(init_pos_2(1),x_max+init_pos_2(1),n);
a2(2,1:n)=init_pos_2(2);

a3(1,:)=linspace(init_pos_3(1),x_max+init_pos_3(1),n);
a3(2,1:n)=init_pos_3(2);




%% Position of the nodes

x_hull=[init_pos_1(1);init_pos_2(1);init_pos_3(1)];
y_hull=[init_pos_1(2);init_pos_2(2);init_pos_3(2)];
k_hull=convhull(x_hull,y_hull);

% while 1
%     random_x1 = min(x_hull) + (max(x_hull)-min(x_hull)).*rand(1);
%     random_y1 = 10;
%     in_1 = inpolygon(random_x1,random_y1,x_hull(k_hull),y_hull(k_hull));
%     node_1=[random_x1;random_y1];
%     
%     random_x2 = min(x_hull) + (max(x_hull)-min(x_hull)).*rand(1);
%     random_y2 = 15;
%     in_2 = inpolygon(random_x2,random_y2,x_hull(k_hull),y_hull(k_hull));
%     node_2=[random_x2;random_y2];
%     
%     random_x3 = min(x_hull) + (max(x_hull)-min(x_hull)).*rand(1);
%     random_y3 = 27.5;
%     in_3 = inpolygon(random_x3,random_y3,x_hull(k_hull),y_hull(k_hull));
%     node_3=[random_x3;random_y3];
%     
%     if in_1 == 1 && in_2 == 1 && in_3 == 1
%         break
%     end
% end

node_1=[11.5;10];
node_2=[12;15];
node_3=[12;27.5];

x1(1,:)=linspace(node_1(1),x_max+node_1(1),n);
x1(2,1:n)=node_1(2);

x2(1,:)=linspace(node_2(1),x_max+node_2(1),n);
x2(2,1:n)=node_2(2);

x3(1,:)=linspace(node_3(1),x_max+node_3(1),n);
x3(2,1:n)=node_3(2);

T_0=n;

nodes=[x1;x2;x3];
anchors=[a1;a2;a3];

case 'spiral'
    theta=0:0.1:2.8*pi;
theta1=0:0.1:4.5*pi;
b=8;
%------------------------------
a(1)=10;
r(1,:)=a(1)+b*theta;
x(1,:)=r(1,:).*cos(theta);
y(1,:)=r(1,:).*sin(theta);
%-------------------------------
a(2)=15;
r(2,:)=a(2)+b*theta;
x(2,:)=r(2,:).*cos(theta);
y(2,:)=r(2,:).*sin(theta);
%-------------------------------
a(3)=25;
r(3,:)=a(3)+b*theta;
x(3,:)=r(3,:).*cos(theta);
y(3,:)=r(3,:).*sin(theta);
%------------------------------
a(4)=24;
r(4,:)=a(4)+b*theta;
x(4,:)=r(4,:).*cos(theta);
y(4,:)=r(4,:).*sin(theta);
%-------------------------------
a(5)=35;
r(5,:)=a(5)+b*theta;
x(5,:)=r(5,:).*cos(theta);
y(5,:)=r(5,:).*sin(theta);
%-------------------------------
a(6)=40;
r(6,:)=a(6)+b*theta;
x(6,:)=r(6,:).*cos(theta);
y(6,:)=r(6,:).*sin(theta);


%---------Anchors-----------------
a1(1,:)=x(1,:);
a1(2,:)=y(1,:);
a2(1,:)=x(4,5:length(theta));
a2(2,:)=y(4,5:length(theta));
a3(1,:)=x(6,:);
a3(2,:)=y(6,:);

%-----Nodes----------------------
x_a=[a1(1,1);a2(1,1);a3(1,1)];
y_a=[a1(2,1);a2(2,1);a3(2,1)];
k=convhull(x_a,y_a);

% in_1=0;in_2=0;in_3=0;
% while 1
%     random_index_1 =randi(9);
%     in_1 = inpolygon(x(2,random_index_1),y(2,random_index_1),x_a(k),y_a(k));
%     node_1=[x(2,random_index_1);y(2,random_index_1)];
%     
%     random_index_2 =randi(9);
%     in_2 = inpolygon(x(3,random_index_2),y(3,random_index_2),x_a(k),y_a(k));
%     node_2=[x(3,random_index_2);y(3,random_index_2)];
%     
%     random_index_3 =randi(9);
%     in_3 = inpolygon(x(5,random_index_3),y(5,random_index_3),x_a(k),y_a(k));
%     node_3=[x(5,random_index_1);y(5,random_index_1)];
%     
%     if in_1 == 1 && in_2 == 1 && in_3 == 1
%         break
%     end
% end

random_index_1=3;
random_index_2=3;
random_index_3=1;

x1=[x(2,random_index_1:end);y(2,random_index_1:end)];
x2=[x(3,random_index_2:end);y(3,random_index_2:end)];
x3=[x(5,random_index_3:end);y(5,random_index_3:end)];

T_0=length(a2(1,:));
nodes=[x1(:,1:T_0);x2(:,1:T_0);x3(:,1:T_0)];
anchors=[a1(:,1:T_0);a2;a3(:,1:T_0)];


end

