 %Block-LDPC主程序
clear all
clc

%矩阵初始化
disp('请输入Block-LDPC矩阵的参数：');
block=input('矩阵中块矩阵大小(默认值：4)：');
if isempty(block)
   block=4; 
end
ColBlockNum=input('块矩阵列数(默认值：256)：');
if isempty(ColBlockNum)
   ColBlockNum=256; 
end
CodeLength=ColBlockNum*block;
CodeRate=input('码率(默认值：0.5)：');
if isempty(CodeRate)
   CodeRate=1/2; 
end
disp('矩阵构造中，请稍后');
rows=(1-CodeRate)*ColBlockNum;%块行数
cols=ColBlockNum;%块列数
H=GenHNew(rows,cols,block);%生成奇偶校验矩阵H
fprintf(' LDPC校验矩阵为：(%d,%d)矩阵\n',cols*block,rows*block);

NewsLength=CodeRate*CodeLength;%待编码信息的长度
fprintf(' 单位信息长度为:%d\n', NewsLength);

%待编码数据
InputDataNum=input('输入单位信息的数量(默认值：100):');
if isempty(InputDataNum)
   InputData=randint(1,100*NewsLength); 
   InputDataNum=100;
else
   InputData=randint(1,InputDataNum*NewsLength);
end

CodeNum=InputDataNum;


%信道选择
disp('信道选择(默认AWGN信道)')
disp('高斯白噪声信道模型输入：0');
disp('莱斯衰落信道模型输入：1');
disp('瑞利衰落信道模型输入：2');
disp('基于Jackes信道模型的高速移动环境下的信道模型输入：3');
channel = input('请输入相应的数值：');
if isempty(channel)
   channel=0; %AWGN case
end
disp('程序运行中，请稍候')

SNRMAX=5;%调试信噪比的最大值
SNRdb=[3:0.5:SNRMAX];
SNRLength=length(SNRdb);
ITERNum=[10 20];%译码的迭代次数
lengthiter=length(ITERNum);
%BPSKErrNum=zeros(1,SNRLength);
BPSKBitErrNum=zeros(1,SNRLength);
%DecodeErrNum=zeros(lengthiter,SNRLength);
DecodeBitErrNum=zeros(lengthiter,SNRLength);
OutputData=zeros(lengthiter,InputDataNum*NewsLength);
%%%%%%%%%%%%%%%%%
CODE=[];


Path=8;LFONum=32;TimeStep=1/2700;
t=cputime;
Speed=18;
for snri=1:SNRLength    %SNR为信噪比
    snr=SNRdb(snri);

    
    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %编码
        PerCode=LDPCEncode(PerData,rows,cols,block,H);
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
            AIQ=Rician_fading(snr,cols*block,1);
            ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
        elseif channel==2
            AIQ=Rician_fading(-inf,cols*block,1);
            ChannelNoise=AIQ.*(-(2*PerCode-1))+Noise;
        elseif channel==3
            AIQ=JakesFading(cols*block);
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
                BPOutputdecode=LDPCDecode(OutputChannel,rows,cols,block,H,sigma,iter);
            else
                BPOutputdecode=UMPBPBased(OutputChannel,rows,cols,block,H,sigma,iter);
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
yBPSKBit=BPSKBitErrNum/(InputDataNum*cols*block);
%yDec=DecodeErrNum/CodeNum;
yBit=DecodeBitErrNum/(InputDataNum*cols*block);
semilogy(x,yBPSKBit,'-s',x,yBit(1,:),'--o',x,yBit(2,:),'--*')
legend('未编码BPSK','误码率(迭代次数=10)','误码率(迭代次数=20)')
xlabel('信噪比(dB)')
ylabel('BER')
title('Block-LDPC码误码率')
grid on  
tend=cputime-t
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


