 %QC-LDPC������
clear all
clc

%�����ʼ��
disp('������QC-LDPC�������ز�����');
disp('IEEE802.16e��QC-LDPC����볤������19����');
disp('576��672��768��864��960��1056��1152��1248��1344');
disp('1440��1536��1632��1728��1824��1920��2016��2112��2208��2304');
CodeLength=input('QC-LDPC���ֵĳ���(Ĭ��576)��');
if isempty(CodeLength)
   CodeLength=576; 
end

CodeRate=input('QC-LDPC�������(Ĭ��ֵ��0.5)��');
if isempty(CodeRate)
   CodeRate=1/2; 
end

[qcH,Hb]=QCLDPCBaseH(CodeLength,CodeRate);
[row,col]=size(qcH);
[rowb,colb]=size(Hb);
block=CodeLength/colb;

NewsLength=CodeRate*CodeLength;%��������Ϣ�ĳ���
fprintf(' ��λ��Ϣ����Ϊ:%d\n', NewsLength);

%����������
InputDataNum=input('���뵥λ��Ϣ������(Ĭ��ֵ��100):');
if isempty(InputDataNum)
   InputData=randi((0:1),1,100*NewsLength); 
   InputDataNum=100;
else
   InputData=randi((0:1),1,InputDataNum*NewsLength);
end

CodeNum=InputDataNum;

%�ŵ�ѡ��
disp('�ŵ�ѡ��(Ĭ��AWGN�ŵ�)');
disp('��˹�������ŵ�ģ�����룺0');
disp('��˹˥���ŵ�ģ�����룺1');
disp('����˥���ŵ�ģ�����룺2');
disp('����Jackes�ŵ�ģ�͵ĸ����ƶ������µ��ŵ�ģ�����룺3');
channel = input('��������Ӧ����ֵ��');
if isempty(channel)
   channel=0; %AWGN case
end
disp('���������У����Ժ�')

SNRMAX=7;%��������ȵ����ֵ
SNRdb=[4:1:SNRMAX];
SNRLength=length(SNRdb);

rate=9.6*10^3;
path=8;
Speed=[4 30 70];
lengthspeed=length(Speed);
iter=20;
DecodeBitErrNum=zeros(lengthspeed,SNRLength);
OutputData=zeros(lengthspeed,InputDataNum*NewsLength);

t=cputime;
for snri=1:SNRLength    %SNRΪ�����
    snr=SNRdb(snri);
    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %����
        PerCode=QCEncode(PerData,qcH,Hb);
        %�����ŵ�
        SNR=10^(snr/10);
        sigma=sqrt(1/(2*CodeRate*SNR));
        Noise=randn(size(PerCode))*sigma;
        ErrDecode=zeros(1,lengthspeed);
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for k=1:lengthspeed
            vi=Speed(k);%�ƶ��ٶ�
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            c=3*10^8;fc=900*10^6;%���ٺ��ز�Ƶ��
            speed=vi*1000/3600;
            f_max=speed*fc/c;
            %T_s=1/(20*f_max);%����ʱ����
            T_s=1/(2*rate);
            if channel==1
                AIQ=cost207Fading(vi,path,colb*block);%vi��ʾkm/h
                ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
            elseif channel==2
                AIQ=JakesFading(colb*block);
                ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
            elseif channel==3
                AIQ=DopplerFading(vi,path,colb*block);
                ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
            else
                ChannelNoise=(-(2*PerCode-1))+Noise;
            end
            
            OutputChannel=ChannelNoise;
            %OutputCode=AWGN(OutputChannel);
            %BPSKBitErrNum(1,snri)=BPSKBitErrNum(1,snri)+sum(abs(OutputCode-PerCode));
            
            %BP����
            if channel==0
                BPOutputdecode=LDPCDecode(OutputChannel,rowb,colb,block,qcH,sigma,iter);
            else
                BPOutputdecode=QCUMPBPBased(OutputChannel,row,col,qcH,sigma,iter);
            end
            ErrDecode(1,k)=sum(abs(BPOutputdecode-PerCode));
        end
        DecodeBitErrNum(:,snri)=DecodeBitErrNum(:,snri)+ErrDecode';
    end
end

tend=cputime-t
x=SNRdb;
%yBPSKBit=BPSKBitErrNum/(InputDataNum*cols*block);
yBit=DecodeBitErrNum/(InputDataNum*colb*block);
semilogy(x,yBit(1,:),'--o',x,yBit(2,:),'--+',x,yBit(3,:),'--*')
legend('�������(v=4km/h)','�������(v=30km/h)','�������(v=70km/h)')
xlabel('�����(dB)')
ylabel('BER')
title('QC-LDPC�벻ͬ�ƶ��ٶ��µ�BER����')
grid on




