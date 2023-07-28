%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edited by Han Renjie 2023/07/28 at Tongji University
% Code for acceleration spectrum

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Max_a]=response_spectrum(ag,dt,T)
%% excitation parameters
m=1;
xi=0.05;
Omegan=2*pi./T;
n=length(Omegan);
L=length(ag);
u=zeros(L,n);u1=zeros(L,n);u11=zeros(L,n);
Max_x=zeros(n,1);Max_v=zeros(n,1);Max_a=zeros(n,1);

for i=1:n

%% Newmark
[u(:,i),u1(:,i),u11(:,i)]=Newmark(ag,dt,Omegan(i),xi,m);
Max_a(i)=max(abs(ag+u11(:,i)))/9.8;
end
end

