%�������һ����ѭ���ĵ�λ����
%gΪ��λ�����ά��
function RI=RandomIdentityMatrix(block)
RI0=eye(block);
array=randperm(block);
i=array(1,1);
RI=circshift(RI0,[0,i]);