%Jakes信道仿真模型
function r = Jakes_fading(fm, M, dt, N) 
%%%%%%%%%%%%%%%
% clear
% clc
% speed=100;%单位km/h
% M=10;
% rate=9600;
% N=100000;
% SPEED=speed*1000/3600; 
% %光速
% C=3*10^8;
% %载波频率，默认值900MHz
% FC=9*10^8;
% fm=SPEED*FC/C;
% dt=1/(2*rate);
%%%%%%%%%%%%%%%%%%%%%%%%
T = N*dt-dt; t = 0:dt:T;
c = sqrt(2/M);w = 2*pi*fm; x = 0; y = 0;
for n = 1:M 
  	alpha = (2*pi*n-pi+(2*pi*rand-pi))/(4*M);
  	ph1 = 2*pi*rand - pi; 
  	ph2 = 2*pi*rand - pi; 
x = x + c*cos(w*t*cos(alpha) + ph1);
y = y + c*cos(w*t*sin(alpha) + ph2);
end 
r = sqrt(x.^2 + y.^2)/sqrt(2); 




% tt=1:1:N;
% figure
% z=20*log10(r);
% plot(tt,z,'-');
% xlabel('t/s')
% ylabel('接收信号/dB')
% title('移动通信中的接收信号(v=100km/h)')
% 
% step = 0.1; range = 0:step:3; 
% h = hist(r, range); 
% fr_approx = h/(step*sum(h)); 
% fr = (range/0.5).*exp(-range.^2);
% figure
% plot(range, fr_approx,'ko', range, fr,'k');
% legend('仿真值','理论值')
% grid; 

