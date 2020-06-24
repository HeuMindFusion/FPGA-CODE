%后rows-1列的度的分布
function RandomT=RandomTriangleSeqence(rows,Degree,step)
%随机从Rows中选取的行数等于上一步中选取的节点度数
%将随机位置控制在下三角矩阵T对角线以下和整个矩阵E的部分
RandomRow0=randperm(rows-step)+step;
RandomRow=RandomRow0(1:Degree-1);
%将下三角对角线的位置加入已选好的随机位置中
N=length(RandomRow);
RandomRow(N+1)=step;
%将已选取的随机位置从小到大排列
for k=1:N+1
    for m=(k+1):N+1
        if RandomRow(k)>RandomRow(m)
            Mid=RandomRow(k);
            RandomRow(k)=RandomRow(m);
            RandomRow(m)=Mid;
        end
    end
end
RandomRow(Degree+1)=0;
RandomT=RandomRow;
