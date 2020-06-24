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
disp('������Ƶ��������˥���ŵ�ģ�����룺1');
disp('����Jackes�ŵ�ģ�͵ĸ����ƶ������µ��ŵ�ģ�����룺2');
channel = input('��������Ӧ����ֵ��');
if isempty(channel)
   channel=0; %AWGN case
end
disp('���������У����Ժ�')

SNRMAX=3;%��������ȵ����ֵ
SNRdb=[1:0.5:SNRMAX];
SNRLength=length(SNRdb);
DecodeBitErrNum=zeros(2,SNRLength);
iter=15;

for snri=1:SNRLength    %SNRΪ�����
    snr=SNRdb(snri);

    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %����
        PerCode=LDPCEncode(PerData,rows,cols,block,H);
        SNR=10^(snr/10);
        sigma=sqrt(1/(2*CodeRate*SNR));
        Noise=randn(size(PerCode))*sigma;
        ChannelNoise=(-(2*PerCode-1))+Noise;
        
        %BP����
        ErrDecode=zeros(1,2);
        BPOutputdecode=UMPBPBased(ChannelNoise,...
                                            rows,cols,block,H,sigma,iter);
        UMPBPdecode=LDPCDecode(ChannelNoise,rows,cols,block,H,sigma,iter);
        ErrDecode(1,1)=sum(abs(BPOutputdecode-PerCode));
        ErrDecode(1,2)=sum(abs(UMPBPdecode-PerCode));
        DecodeBitErrNum(:,snri)=DecodeBitErrNum(:,snri)+ErrDecode';
    end
end


x=SNRdb;
yBit=DecodeBitErrNum/(InputDataNum*cols*block);
semilogy(x,yBit(1,:),'--o',x,yBit(2,:),'--*')
pic=legend('UMP BP Based','LLR BP')
set(pic,'Location','SouthWest');
xlabel('�����(dB)')
ylabel('BER')
title('��ͬ�����㷨�µ�BER���ܱȽ�')
grid on



