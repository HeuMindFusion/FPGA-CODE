function RandomM=RandomSeqence(rows,Degree,RowCount)
%rows：当前列的位置
%Degree：当前列的度数
%RowCount：校验节点的度数累积和
RandomRow0=zeros(1,rows);
RandomRow=zeros(1,rows);
%将度数为6以上的校验的位置赋值0，即屏蔽掉该位置的选取
for i=1:rows
    if RowCount(1,i)>6
        RandomRow0(1,i)=0;
    else
        RandomRow0(1,i)=i;
    end
end
%将能用的校验节点的位置随机排列
RandomRow0=RandomRow0(randperm(length(RandomRow0)));
%选取前Degree个不为0的数值，作为本次选取的随机位置
DegreeMid=1;
for i=1:rows
    if DegreeMid<Degree+1
        if RandomRow0(i)~=0
            RandomRow(DegreeMid)=RandomRow0(i);
            DegreeMid=DegreeMid+1;
        end
    end
end      
%将选取的随机位置从小到大排序并输出
N=length(RandomRow);
for i=1:N
    for j=(i+1):N
        if RandomRow(i)>RandomRow(j)
            Mid=RandomRow(i);
            RandomRow(i)=RandomRow(j);
            RandomRow(j)=Mid;
        end
    end
end
RandomRow(Degree+1)=0;
RandomM=RandomRow;
