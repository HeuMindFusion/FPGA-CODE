%F_S_K_p.m
%
%���������������F_S_K.m�ļ�
%
%�õ����ӳ���pCOST207.m
%--------------------------------------------------------------
%[C1,F1,TH1,C2,F2,TH2,F01,F02,RHO,F_RHO,q_l,T]=
%						F_S_K_p(N_1,AREA,f_max)
%--------------------------------------------------------------
%���������
%N_1����ɢ������Ƶ���õ�����Сг������ֵ
%AREA��COST 207 ��4�ֵ��ʹ����ŵ�ģ��
%		1��Զ������(Rural Area)��     'ra'
%		2�����ͳ���(Typical Urban)��	'tu'
%		3�����ӳ���(Bad Urban)��		'bu'
%		4���������(Hilly Terrain)��  'ht'
%f_max����������Ƶ��
function [C1,F1,TH1,C2,F2,TH2,F01,F02,RHO,F_RHO,q_l,T]=...
                            F_S_K_p(N_1,AREA,f_max)

%�ŵ�ģ�͹淶������ʱ�Ӻ�·������
%����������ʱ��T_s��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_s=0.2e-6;

if   all(lower(AREA)=='ra')
	a_l=[1,0.63,0.1,0.01];
	tau_l=[0,0.2,0.4,0.6]*1E-6;
	DOPP_KAT=['RI';'JA';'JA';'JA'];
elseif   all(lower(AREA)=='tu')
	a_l=[0.5,1,0.63,0.25,0.16,0.1];
	tau_l=[0,0.2,0.6,1.6,2.4,5]*1E-6;
	DOPP_KAT=['JA';'JA';'G1';'G1';'G2';'G2'];
elseif   all(lower(AREA)=='bu')
	a_l=[0.5,1,0.5,0.32,0.64,0.4];
	tau_l=[0,0.4,1.0,1.6,5.0,6.6]*1E-6;
	DOPP_KAT=['JA';'JA';'G1';'G1';'G2';'G2'];
elseif   all(lower(AREA)=='ht')
	a_l=[1,0.63,0.4,0.2,0.25,0.06];
	tau_l=[0,0.2,0.4,0.6,15,17.2]*1E-6;
	DOPP_KAT=['JA';'JA';'JA';'JA';'G2';'G2'];
end

%���²����ĸ�ֵ
num_of_taps=length(DOPP_KAT);
F1=zeros(num_of_taps,N_1+2*num_of_taps-1);
F2=F1;C1=F1;C2=F1;TH1=F1;TH2=F1;
F01=zeros(1,num_of_taps);
F02=F01;
RHO=zeros(1,num_of_taps);
F_RHO=RHO;
NN1=N_1+2*(num_of_taps-1):-2:N_1;
for k=1:num_of_taps
	[f1,f2,c1,c2,th1,th2,rho,f_rho,f01,f02]=...
	pCOST207(DOPP_KAT(k,:),NN1(k));
	F1(k,1:NN1(k))=f1;
	C1(k,1:NN1(k))=c1*sqrt(a_l(k));
	TH1(k,1:NN1(k))=th1;
	F2(k,1:NN1(k)+1)=f2;
	C2(k,1:NN1(k)+1)=c2*sqrt(a_l(k));
	TH2(k,1:NN1(k)+1)=th2;
	F01(k)=f01;F02(k)=f02;
	RHO(k)=rho;F_RHO(k)=f_rho;
end

%FIR�˲�������ʱ�����е�ȷ����ָ��
q_l=tau_l/T_s+1;

%FIR�˲����ӳٲ����ĳ�ʼ��
T=zeros(1,max(q_l));


