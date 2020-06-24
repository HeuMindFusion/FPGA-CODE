%随机产生一个右循环的单位矩阵
%g为单位矩阵的维数
function RI=RandomIdentityMatrix(block)
RI0=eye(block);
array=randperm(block);
i=array(1,1);
RI=circshift(RI0,[0,i]);