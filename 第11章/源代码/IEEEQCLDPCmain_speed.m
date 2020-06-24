 %QC-LDPC主程序
clear all
clc

%矩阵初始化
disp('请输入QC-LDPC矩阵的相关参数：');
disp('IEEE802.16e中QC-LDPC码的码长有如下19个：');
disp('576、672、768、864、960、1056、1152、1248、1344');
disp('1440、1536、1632、1728、1824、1920、2016、2112、2208、2304');
CodeLength=input('QC-LDPC码字的长度(默认576)：');
if isempty(CodeLength)
   CodeLength=576; 
end

CodeRate=input('QC-LDPC码的码率(默认值：0.5)：');
if isempty(CodeRate)
   CodeRate=1/2; 
end

[qcH,Hb]=QCLDPCBaseH(CodeLength,CodeRate);
[row,col]=size(qcH);
[rowb,colb]=size(Hb);
block=CodeLength/colb;

NewsLength=CodeRate*CodeLength;%待编码信息的长度
fprintf(' 单位信息长度为:%d\n', NewsLength);

%待编码数据
InputDataNum=input('输入单位信息的数量(默认值：100):');
if isempty(InputDataNum)
   InputData=randi((0:1),1,100*NewsLength); 
   InputDataNum=100;
else
   InputData=randi((0:1),1,InputDataNum*NewsLength);
end

CodeNum=InputDataNum;

%信道选择
disp('信道选择(默认AWGN信道)');
disp('高斯白噪声信道模型输入：0');
disp('莱斯衰落信道模型输入：1');
disp('瑞利衰落信道模型输入：2');
disp('基于Jackes信道模型的高速移动环境下的信道模型输入：3');
channel = input('请输入相应的数值：');
if isempty(channel)
   channel=0; %AWGN case
end
disp('程序运行中，请稍候')

SNRMAX=7;%调试信噪比的最大值
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
for snri=1:SNRLength    %SNR为信噪比
    snr=SNRdb(snri);
    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %编码
        PerCode=QCEncode(PerData,qcH,Hb);
        %经过信道
        SNR=10^(snr/10);
        sigma=sqrt(1/(2*CodeRate*SNR));
        Noise=randn(size(PerCode))*sigma;
        ErrDecode=zeros(1,lengthspeed);
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for k=1:lengthspeed
            vi=Speed(k);%移动速度
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            c=3*10^8;fc=900*10^6;%光速和载波频率
            speed=vi*1000/3600;
            f_max=speed*fc/c;
            %T_s=1/(20*f_max);%抽样时间间隔
            T_s=1/(2*rate);
            if channel==1
                AIQ=cost207Fading(vi,path,colb*block);%vi表示km/h
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
            
            %BP译码
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
legend('误比特率(v=4km/h)','误比特率(v=30km/h)','误比特率(v=70km/h)')
xlabel('信噪比(dB)')
ylabel('BER')
title('QC-LDPC码不同移动速度下的BER性能')
grid on




