%----------------------------------------
%pCOST207.m
%
%生成在COST207中定义的多普勒功率谱密度的信道参数
%
%------------------------------------------------------
%[f1,f2,c1,c2,th1,th2,rho,f_rho,f01,f02]=pCOST207(D_S_T,N_i)
%------------------------------------------------------
%输入参数：
%
%D_S_T：典型的多普勒功率谱密度函数
%		Jakes:		D_S_T='JA'
%		Rice:	 		D_S_T='RI'
%		Gauss  Ⅰ:		D_S_T='G1'
%		Gauss  Ⅱ:		D_S_T='G2'
%N_i：谐波函数的个数

function [f1,f2,c1,c2,th1,th2,rho,f_rho,f01,f02]=pCOST207(D_S_T,N_i)

if	all(lower(D_S_T)=='ri')	%RICE
	n=(1:N_i);
	f1=sin(pi/(2*N_i)*(n-1/2));
	c1=0.41*sqrt(1/N_i)*ones(1,N_i);
	th1=rand(1,N_i)*2*pi;
	n=(1:N_i+1);
	f2=sin(pi/(2*(N_i+1))*(n-1/2));
	c2=0.41*sqrt(1/(N_i+1))*ones(1,N_i+1);
	th2=rand(1,N_i+1)*2*pi;
	f01=0;f02=0;
	rho=0.91;f_rho=0.7;
elseif	 all(lower(D_S_T)=='ja')	%JAKES
	n=(1:N_i);
	f1=sin(pi/(2*N_i)*(n-1/2));
	c1=sqrt(1/N_i)*ones(1,N_i);
	th1=rand(1,N_i)*2*pi;
	n=(1:N_i+1);
	f2=sin(pi/(2*(N_i+1))*(n-1/2));
	c2=sqrt(1/(N_i+1))*ones(1,N_i+1);
	th2=rand(1,N_i+1)*2*pi;
	f01=0;f02=0;
	rho=0;f_rho=0;
elseif	 all(lower(D_S_T)=='g1')	%GAUSS I
	n=(1:N_i);
	sgm_0_2=5/6;
	c1=sqrt(sgm_0_2*2/N_i)*ones(1,N_i);
	f1=sqrt(2)*0.05*erfinv((2*n-1)/(2*N_i));
	th1=rand(1,N_i)*2*pi;
	sgm_0_2=1/6;
	c2=[sqrt(sgm_0_2*2/N_i)*ones(1,N_i),0]/j;
	f2=[sqrt(2)*0.1*erfinv((2*n-1)/(2*N_i)),0];
	th2=[rand(1,N_i)*2*pi,0];
	f01=0.8;f02=-0.4;
	rho=0;f_rho=0;
elseif	 all(lower(D_S_T)=='g2')	%GAUSS II
	n=(1:N_i);
	sgm_0_2=10^0.5/(sqrt(10)+0.15);
	c1=sqrt(sgm_0_2*2/N_i)*ones(1,N_i);
	f1=sqrt(2)*0.1*erfinv((2*n-1)/(2*N_i));
	th1=rand(1,N_i)*2*pi;
	sgm_0_2=0.15/(sqrt(10)+0.15);
	c2=[sqrt(sgm_0_2*2/N_i)*ones(1,N_i),0]/j;
	f2=[sqrt(2)*0.1*erfinv((2*n-1)/(2*N_i)),0];
	th2=[rand(1,N_i)*2*pi,0];
	f01=-0.7;f02=0.4;
	rho=0;f_rho=0;
end
