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

SNRMAX=3;%��������ȵ����ֵ
SNRdb=(1:0.5:SNRMAX);
SNRLength=length(SNRdb);
ITERNum=[10 20];%����ĵ�������
lengthiter=length(ITERNum);
%BPSKErrNum=zeros(1,SNRLength);%δ�������������
BPSKBitErrNum=zeros(1,SNRLength);%δ������������
%DecodeErrNum=zeros(lengthiter,SNRLength);%�������������
DecodeBitErrNum=zeros(lengthiter,SNRLength);%������������
OutputData=zeros(lengthiter,InputDataNum*NewsLength);
%%%%%%%%%%%%%%%%%
CODE=[];


Path=8;LFONum=32;TimeStep=1/2700;

Speed=18;
for snri=1:SNRLength    %SNRΪ�����
    snr=SNRdb(snri);

    
    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %����
        PerCode=QCEncode(PerData,qcH,Hb);
        %%%%%%%%%%%%%%%%%%%%%%%%%%5
        %if snr==3
        %    CODE(i,:)=PerCode;
        %end
        %�����ŵ�
        SNR=10^(snr/10);
        sigma=sqrt(1/(2*CodeRate*SNR));
        Noise=randn(size(PerCode))*sigma;
        if channel==1
            %AIQ=MultiUncorRayleighFading(Speed,Path,LFONum,TimeStep,cols*block);
            %AIQ=Dopplertest(Speed,Path,cols*block);
            AIQ=Rician_fading(snr,colb*block,1);
            ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
        elseif channel==2
            AIQ=Rician_fading(-inf,colb*block,1);
            ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
        elseif channel==3
            AIQ=JakesFading(colb*block);
            ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
        else
            ChannelNoise=(-(2*PerCode-1))+Noise;
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        OutputChannel=ChannelNoise;
        %OutputChannel=ChannelNoise*LC;
        OutputCode=AWGN(OutputChannel);
        %BPSKErrNum(1,snri)=BPSKErrNum(1,snri)+ErrCode;
        BPSKBitErrNum(1,snri)=BPSKBitErrNum(1,snri)+sum(abs(OutputCode-PerCode));
        
        %BP����
        ErrDecode=zeros(1,lengthiter);
        for iternum=1:lengthiter
            iter=ITERNum(iternum);%��������
            %%%%%%%%%%%%%%%%%%%%%%5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if channel==0
                BPOutputdecode=LDPCDecode(OutputChannel,rowb,colb,block,qcH,sigma,iter);
            else
                BPOutputdecode=QCUMPBPBased(OutputChannel,row,col,qcH,sigma,iter);
            end
            ErrDecode(1,iternum)=sum(abs(BPOutputdecode-PerCode));
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
            %if snr==3&&iternum==4
            %    CODE(i,:)=decode;
            %end
        end
        DecodeBitErrNum(:,snri)=DecodeBitErrNum(:,snri)+ErrDecode';
        %ErrDecode
        %%%%%%%%%%%%%%%%%%%%%%
        %if sum(ErrDecode)>100
        %    PerCode
        %    break
       % end
        %��ȡ��Ϣ
        %OutputSign=[OutputSign decode(1,NewsLength)];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % if sum(ErrDecode)>100
   %     break
   % end
    %OutputData(snri,:)=OutputSign;
end


x=SNRdb;
%yOut=BPSKErrNum/CodeNum;
yBPSKBit=BPSKBitErrNum/(InputDataNum*col);
%yDec=DecodeErrNum/CodeNum;
yBit=DecodeBitErrNum/(InputDataNum*col);
semilogy(x,yBPSKBit,'-s',x,yBit(1,:),'--o',x,yBit(2,:),'--*')
legend('δ����BPSK','������(��������=10)','������(��������=20)')
xlabel('�����(dB)')
ylabel('BER')
title('IEEE802.16e��׼��QC-LDPC��������')
grid on  

%figure
%semilogy(x,yBPSKBit,'-s',x,yBit(1,:),'--o',x,yBit(2,:),'--*')
%pic=legend('δ����BPSK','�������(��������=5)','�������(��������=10)')
%set(pic,'Location','SouthWest');
%xlabel('�����(dB)')
%ylabel('BER')
%title('Block-LDPC���ڶ�����Ƶ����˥���ŵ���BER����(v=18km/h)')
%title('Block-LDPC���BER����')
%grid on


%%%%%%%%%%%%%%%%%%%%%


