%多径非相关瑞利衰落信道
function Doppler=Dopplerfading(Speed,path,Length,N)
No=N/4;
c=3*10^8;fc=900*10^6;%光速和载波频率
Speed=Speed*1000/3600;%将速度换算成m/s
fmax=Speed*fc/c;%最大多普勒频移
startT=0;endT=1;TimeStep=1/(10^4);%仿真起始时间和抽样时间间隔
T=Length*TimeStep-TimeStep;
time=0:TimeStep:T;
const=sqrt(1/(2*No));
omega=2*pi*fmax;
x=0;y=0;Doppler=0;
for k=1:path
    xx=0;yy=0;
    for n=1:No
        alpha=(2*pi*n-pi+(2*pi*rand-pi))/N+...
            (2*pi*k-pi+(2*pi*rand-pi))/path;
        ph1=2*pi*rand-pi;
        ph2=2*pi*rand-pi;
        xx=xx+const*cos(omega*time*cos(alpha)+ph1);
        yy=yy+const*sin(omega*time*sin(alpha)+ph2);
    end
    x=x+xx;
    y=y+yy;
end
Doppler=abs(x+i*y);
