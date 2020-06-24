%F_S_K.m
%频率选择性移动信道模型，构造方法如图8.9所示。
function [y_t,T,t_0]= F_S_K (x_t,speed,m_s,t_0,N_1,AREA,PLOT)

c=3*10^8;fc=900*10^6;%光速和载波频率
Speed=speed*1000/3600;
f_max=Speed*fc/c;
[C1,F1,TH1,C2,F2,TH2,F01,F02,RHO,F_RHO,q_l,T]=F_S_K_p(N_1,AREA,f_max);                             

%初始化
T_s=0.2e-6;%符号间隔时间
mu_l=zeros(size(q_l));
y_t=zeros(size(x_t));

for n=0:length(x_t)-1
	if rem(n/m_s,m_s)-fix(rem(n/m_s,m_s))==0
		mu_l=sum((C1.*cos(2*pi*F1*f_max*(n*T_s+t_0)+TH1)).').*...
			exp(-j*2*pi*F01*f_max*(n*T_s+t_0))+j*...
			(sum((C2.*cos(2*pi*F2*f_max*(n*T_s+t_0)+TH2)).').*...
			exp(-j*2*pi*F02*f_max*(n*T_s+t_0)))+...
			RHO.*exp(j*2*pi*F_RHO*f_max*(n*T_s+t_0));
    end
	T(1)=x_t(n+1);
	y_t(n+1)=sum(mu_l.*T(q_l));
	T(2:length(T))=T(1:length(T)-1);
end

t_0=length(x_t)*T_s+t_0;

if PLOT= =1
    figure
	plot((0:length(y_t)-1)*T_s,20*log10(abs(y_t)),'-');
    xlabel('t/s')
    ylabel('接收信号/dB')
end
