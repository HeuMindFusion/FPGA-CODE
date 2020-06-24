 %Block-LDPC������
clear all
clc

%�����ʼ��
disp('������Block-LDPC����Ĳ�����');
block=input('�����п�����С(Ĭ��ֵ��4)��');
if isempty(block)
   block=4; 
end
ColBlockNum=input('���������(Ĭ��ֵ��256)��');
if isempty(ColBlockNum)
   ColBlockNum=256; 
end
CodeLength=ColBlockNum*block;
CodeRate=input('����(Ĭ��ֵ��0.5)��');
if isempty(CodeRate)
   CodeRate=1/2; 
end
disp('�������У����Ժ�');
rows=(1-CodeRate)*ColBlockNum;%������
cols=ColBlockNum;%������
H=GenHNew(rows,cols,block);%������żУ�����H
fprintf(' LDPCУ�����Ϊ��(%d,%d)����\n',cols*block,rows*block);

NewsLength=CodeRate*CodeLength;%��������Ϣ�ĳ���
fprintf(' ��λ��Ϣ����Ϊ:%d\n', NewsLength);

%����������
InputDataNum=input('���뵥λ��Ϣ������(Ĭ��ֵ��100):');
if isempty(InputDataNum)
   InputData=randint(1,100*NewsLength); 
   InputDataNum=100;
else
   InputData=randint(1,InputDataNum*NewsLength);
end

CodeNum=InputDataNum;


%�ŵ�ѡ��
disp('�ŵ�ѡ��(Ĭ��AWGN�ŵ�)')
disp('��˹�������ŵ�ģ�����룺0');
disp('����˥���ŵ�ģ�����룺1');
disp('����Jackes���ŵ�ģ�����룺2');
disp('����COST207���ŵ�ģ�����룺3');
channel = input('��������Ӧ����ֵ��');
if isempty(channel)
   channel=0; %AWGN case
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%COST207�е��ʹ���������ѡ��
disp('COST207�е����ֵ��ʹ���������');
disp('Զ������(RA,Rural Area):      1');
disp('���ͳ���(TU,Typical Urban):   2');
disp('���ӳ���(BU,Bad Urban):       3');
disp('�������(HT,Hilly Terrain):   4');
AREANum=input('������Ի�����Ӧ��ֵ��');
if AREANum==1
    %if all(lower(AREA)=='ri')
    AREA='ra';
elseif AREANum==2
    AREA='tu';
elseif AREANum==3
    AREA='bu';
elseif AREANum==4
    AREA='ht';
else
    AREA='ra';
end
    
disp('���������У����Ժ�')

SNRMAX=10;%��������ȵ����ֵ
SNRdb=[3:1:SNRMAX];
SNRLength=length(SNRdb);
%BPSKBitErrNum=zeros(1,SNRLength);


CODE=[];
%LFONum=32;TimeStep=1/2700;
Path=6;
Speed=[18 100 300];
lengthspeed=length(Speed);
iter=20;
DecodeBitErrNum=zeros(lengthspeed,SNRLength);
OutputData=zeros(lengthspeed,InputDataNum*NewsLength);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%COST207��������%%%%%%%%

m_s=4;%�������ʱ�
t_0=0;%ʱ��ƫ����
N_1=10;%��С��ɢ������Ƶ������ֵ��Ĭ��ֵ10��
PLOT=0;%�Ƿ񻭳�COST207�еĽ����ź�ͼ


for snri=1:SNRLength    %SNRΪ�����
    snr=SNRdb(snri);
    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %����
        PerCode=LDPCEncode(PerData,rows,cols,block,H);
        
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
            T_s=1/(20*f_max);%����ʱ����
            
            if channel==1
                AIQ=cost207Fading(vi,Path,cols*block);%vi��ʾkm/h
                ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
            elseif channel==2
                AIQ=JakesFading(cols*block);
                ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
            elseif channel==3
                [y_t,T,t_0]=COST207(PerCode,vi,m_s,t_0,N_1,AREA,PLOT);
                ChannelNoise=y_t.*(-(2*PerCode-1))+Noise;
            else
                ChannelNoise=(-(2*PerCode-1))+Noise;
            end
            
            OutputChannel=ChannelNoise;
            %OutputCode=AWGN(OutputChannel);
            %BPSKBitErrNum(1,snri)=BPSKBitErrNum(1,snri)+sum(abs(OutputCode-PerCode));
            
            %BP����
            BPOutputdecode=UMPBPBased(OutputChannel,rows,cols,block,H,sigma,iter);
            ErrDecode(1,k)=sum(abs(BPOutputdecode-PerCode));
        end
        DecodeBitErrNum(:,snri)=DecodeBitErrNum(:,snri)+ErrDecode';
    end
end


x=SNRdb;
%yBPSKBit=BPSKBitErrNum/(InputDataNum*cols*block);
yBit=DecodeBitErrNum/(InputDataNum*cols*block);
semilogy(x,yBit(1,:),'--o',x,yBit(2,:),'--+',x,yBit(3,:),'--*')
pic=legend('�������(v=18km/h)','�������(v=100km/h)','�������(v=300km/h)')
%axis([ 1 4 0.01 1])
set(pic,'Location','SouthWest');
xlabel('�����(dB)')
ylabel('BER')
title('Block-LDPC�벻ͬ�ƶ��ٶ��µ�BER����')
%title('Block-LDPC���BER����')
grid on


%%%%%%%%%%%%%%%%%%%%%


