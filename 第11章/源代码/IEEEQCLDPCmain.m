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

SNRMAX=3;%调试信噪比的最大值
SNRdb=(1:0.5:SNRMAX);
SNRLength=length(SNRdb);
ITERNum=[10 20];%译码的迭代次数
lengthiter=length(ITERNum);
%BPSKErrNum=zeros(1,SNRLength);%未编码错误码字数
BPSKBitErrNum=zeros(1,SNRLength);%未编码错误比特数
%DecodeErrNum=zeros(lengthiter,SNRLength);%译码错误码字数
DecodeBitErrNum=zeros(lengthiter,SNRLength);%译码错误比特数
OutputData=zeros(lengthiter,InputDataNum*NewsLength);
%%%%%%%%%%%%%%%%%
CODE=[];


Path=8;LFONum=32;TimeStep=1/2700;

Speed=18;
for snri=1:SNRLength    %SNR为信噪比
    snr=SNRdb(snri);

    
    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %编码
        PerCode=QCEncode(PerData,qcH,Hb);
        %%%%%%%%%%%%%%%%%%%%%%%%%%5
        %if snr==3
        %    CODE(i,:)=PerCode;
        %end
        %经过信道
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
        
        %BP译码
        ErrDecode=zeros(1,lengthiter);
        for iternum=1:lengthiter
            iter=ITERNum(iternum);%迭代次数
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
        %提取信息
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
legend('未编码BPSK','误码率(迭代次数=10)','误码率(迭代次数=20)')
xlabel('信噪比(dB)')
ylabel('BER')
title('IEEE802.16e标准的QC-LDPC码误码率')
grid on  

%figure
%semilogy(x,yBPSKBit,'-s',x,yBit(1,:),'--o',x,yBit(2,:),'--*')
%pic=legend('未编码BPSK','误比特率(迭代次数=5)','误比特率(迭代次数=10)')
%set(pic,'Location','SouthWest');
%xlabel('信噪比(dB)')
%ylabel('BER')
%title('Block-LDPC码在多普勒频移下衰落信道的BER性能(v=18km/h)')
%title('Block-LDPC码的BER性能')
%grid on


%%%%%%%%%%%%%%%%%%%%%


