%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edited by Han Renjie 2023/07/28 at Tongji University
% Code of Newmark beta method 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [u,u1,u11]=Newmark(p,delta_t,omega,zeta,m)
gamma=0.5;
beta=1/4; 

num_sei=length(p);       
%********结构参数**********

p=-m*p;
c=2*zeta*omega*m;
k=omega^2*m;

%**********赋初值***********
u=zeros(num_sei,1); u(1)=0;
u1=zeros(num_sei,1); u1(1)=0;
u11=zeros(num_sei,1); u11(1)=(p(1)-c*u1(1)-k*u(1))/m;

%****计算参数********
k1=k+gamma*c/beta/delta_t+m/beta/delta_t/delta_t;
a=m/beta/delta_t+gamma*c/beta;
b=m/2/beta+delta_t*c*(gamma/2/beta-1);

%*****循环计算*****
for i=1:(num_sei-1)
    delta_p=p(i+1)-p(i)+a*u1(i)+b*u11(i);
    delta_u=delta_p/k1;
    delta_u1=gamma*delta_u/beta/delta_t-gamma/beta*u1(i)+delta_t*(1-gamma/2/beta)*u11(i);
    delta_u11=delta_u/beta/delta_t/delta_t-u1(i)/beta/delta_t-1/2/beta*u11(i);

    u(i+1)=u(i)+delta_u;
    u1(i+1)=u1(i)+delta_u1;
    u11(i+1)=u11(i)+delta_u11;    
end
  


