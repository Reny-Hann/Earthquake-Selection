%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edited by Han Renjie 2023/07/28 at Tongji University
% code for selecting earthquakes that suit for design resonse spectrum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;clear;close all;
%% Parameters
Ts=0.82;% natural period of the considered structure
dT=0.01;
T=0.01:dT:6; % Periods of structures
% parameters of the response spectrum
a_max=0.16; 
r=0.9;
eta1=0.02;
eta2=1;
Tg=0.55;
%% Design response spectrum
t1=T(1):dT:0.1;
t2=0.1+dT:dT:Tg;
t3=Tg+dT:dT:5*Tg-dT;
t4=5*Tg:dT:T(end);
S_a=[0.45*a_max+(eta2-0.45)*a_max/0.1*t1,eta2*a_max*ones(1,length(t2)),(Tg./t3).^r*eta2*a_max,(eta2*0.2^r-eta1*(t4-5*Tg))*a_max];

k1=round(Ts/dT);% point of the structure period
%% real earthquake 
Filesname = dir(strcat('*.AT2'));
L = length(Filesname);  

Max_a=zeros(length(T),L);
S_a_selected=[];
Select_earthquakes = {};

for i = 1:L               
filename=Filesname(i).name;
[filepath, name, ext] = fileparts(filename);% get everyparts of the name
tex_name = strrep(name, '_', '\_');% transforme '_' to '\_' and make it looks properly
[ag,Dt,NPTS,errCode]=readAT2(filename);
% Adjusted amplitude
A_max=0.7;
r2=A_max/max(ag);
ag=r2*ag;

% Response Spectrum
Max_a(:,i)=response_spectrum(ag,Dt,T);
% Select
if Max_a(k1,i)>0.8*S_a(k1) && Max_a(k1,i)<1.2*S_a(k1) %% criteria
% copyfile(filename,"new_select\");% save the earthquake, need to creat
% folder "new_select" first
S_a_selected=[S_a_selected,Max_a(:,i)];
Select_earthquakes{end+1} = tex_name;
end
end
%% figure
L1=Ts;
y=1.2*a_max;

figure;
hold on; 
plot(T,S_a,'-','color',[252/255 041/255 030/255],'linewidth',2);
plot([L1,L1],[0,y],':','color',[144/255 190/255 224/255],'linewidth',3);
set(gca,'fontname','times new roman','fontsize',18);
xlabel('T (s)','fontsize',20);
ylabel('$$\alpha$$','fontsize',20,'interpreter','latex');
legend('Design response spectrum','$$T_s$$','fontsize',14,'fontname','times new roman','interpreter','latex');
title('Design response spectrum')
box off;

figure;
hold on; 
plot(T,S_a_selected,'linewidth',0.5);
plot(T,0.8*S_a,'--','color',[078/255 171/255 144/255],'linewidth',2);
plot(T,1.2*S_a,'--','color',[000/255 070/255 222/255],'linewidth',2);
plot(T,0.8*S_a,'--k','linewidth',2);
plot(T,1.2*S_a,'--k','linewidth',2);
plot([L1,L1],[0,y],':','color',[217/255 079/255 051/255],'linewidth',3);
set(gca,'fontname','times new roman','fontsize',18);
legend(['0.8*Sa','1.2*Sa',Select_earthquakes],'FontSize',12);
xlabel('T (s)','fontsize',20);
ylabel('$$\alpha$$','fontsize',20,'interpreter','latex');
title('Selected earthquakes')
box off;

figure;
hold on; 
plot(T,Max_a,'linewidth',0.5);
plot(T,0.8*S_a,'k--','linewidth',2);
plot(T,1.2*S_a,'k--','linewidth',2);
plot([L1,L1],[0,y],':','color',[217/255 079/255 051/255],'linewidth',3);
set(gca,'fontname','times new roman','fontsize',18);
xlabel('T (s)','fontsize',20,'interpreter','latex');
ylabel('$$\alpha$$','fontsize',20,'interpreter','latex');
title('All earthquakes')
box off;


