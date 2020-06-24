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
disp('瑞利衰落信道模型输入：1');
disp('基于Jackes的信道模型输入：2');
disp('基于COST207的信道模型输入：3');
channel = input('请输入相应的数值：');
if isempty(channel)
   channel=0; %AWGN case
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%COST207中典型传播环境的选择
disp('COST207中的四种典型传播环境：');
disp('远郊地区(RA,Rural Area):      1');
disp('典型城区(TU,Typical Urban):   2');
disp('恶劣城区(BU,Bad Urban):       3');
disp('丘陵地区(HT,Hilly Terrain):   4');
AREANum=input('输入测试环境对应的值：');
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
    
disp('程序运行中，请稍候')

SNRMAX=10;%调试信噪比的最大值
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
%%%%COST207参数设置%%%%%%%%

m_s=4;%抽样速率比
t_0=0;%时间偏移量
N_1=10;%最小离散多普勒频移数量值（默认值10）
PLOT=0;%是否画出COST207中的接收信号图


for snri=1:SNRLength    %SNR为信噪比
    snr=SNRdb(snri);
    j=1;
    for i=1:CodeNum
        PerData=zeros(1,NewsLength);
        PerData(1,:)=InputData((j-1)*NewsLength+1:j*NewsLength);
        j=j+1;
        
        %编码
        PerCode=LDPCEncode(PerData,rows,cols,block,H);
        
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
            T_s=1/(20*f_max);%抽样时间间隔
            
            if channel==1
                AIQ=cost207Fading(vi,Path,cols*block);%vi表示km/h
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
            
            %BP译码
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
pic=legend('误比特率(v=18km/h)','误比特率(v=100km/h)','误比特率(v=300km/h)')
%axis([ 1 4 0.01 1])
set(pic,'Location','SouthWest');
xlabel('信噪比(dB)')
ylabel('BER')
title('Block-LDPC码不同移动速度下的BER性能')
%title('Block-LDPC码的BER性能')
grid on


%%%%%%%%%%%%%%%%%%%%%


