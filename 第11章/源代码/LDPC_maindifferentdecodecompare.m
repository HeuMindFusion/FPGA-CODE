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
disp('多普勒频移下瑞利衰落信道模型输入：1');
disp('基于Jackes信道模型的高速移动环境下的信道模型输入：2');
channel = input('请输入相应的数值：');
if isempty(channel)
   channel=0; %AWGN case
end
disp('程序运行中，请稍候')

SNRMAX=3;%调试信噪比的最大值
SNRdb=[1:0.5:SNRMAX];
SNRLength=length(SNRdb);
DecodeBitErrNum=zeros(2,SNRLength);
iter=15;

for snri=1:SNRLength    %SNR为信噪比
    snr=SNRdb(snri);

    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %编码
        PerCode=LDPCEncode(PerData,rows,cols,block,H);
        SNR=10^(snr/10);
        sigma=sqrt(1/(2*CodeRate*SNR));
        Noise=randn(size(PerCode))*sigma;
        ChannelNoise=(-(2*PerCode-1))+Noise;
        
        %BP译码
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
xlabel('信噪比(dB)')
ylabel('BER')
title('不同译码算法下的BER性能比较')
grid on



