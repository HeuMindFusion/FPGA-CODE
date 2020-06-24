%��˹�ŵ�ģ��
%�����ŵ�ģ�ͣ�Kdb=-inf��

function r = Rician_fading(Kdb, N, Mi) 
%Kdb��K�ķֱ�ֵ��
%N���ź����г��ȡ�
%Mi��Rician˥���ŵ��Ĳ������ӣ�����ֵΪ1

%%%%%%%%%%
%clear
%clc
%Kdb=5;
%N=10000;
%Mi=1;
%%%%%%%%%%%5

K = 10^(Kdb/10); const = 1/(2*(K+1)); 
x = randn(1,N); y = randn(1,N);  
r = sqrt(const*((x + sqrt(2*K)).^2 + y.^2)); 
rt = zeros(1,Mi*length(r)); 
ki = 1;
for i=1:length(r)
    rt(ki:i*Mi) = r(i); ki = ki+Mi; 
end
r=rt;



% xx=1:1:10000;
% figure
% z=20*log10(r);
% plot(xx,z,'-');
% xlabel('t/s')
% ylabel('�����ź�/dB')
% title('˥���ŵ�')