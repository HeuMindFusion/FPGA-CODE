function GaH=GallagerH(CodeLength,dv,dc)
%%%%%%%
%CodeLength=20,dv=3,dc=4;%���ڲ���
%%%%%%%
%ˮƽ�Ӿ������ٻ����Ӿ����к��еĴ�С����ͼ10.1�С�1����ʾ�Ӿ���
SubRow=CodeLengthdc;
SubCol=dc;
%��С�Ӿ���ĳ�ʼ��
SubH=zeros(SubRow,SubCol);
%����һ��ȫ����ֵΪ1
SubH(1,:)=ones(1,SubCol);
%������Ӿ���ֵ����һ��ˮƽ�Ӿ���������ƴ�Ӻ���ƴ��
SubOneH=SubH;
%��ˮƽ�Ӿ���ĵ�һ���Ӿ���ѭ�����Ƶõ������Ӿ���ѭ��һ�Σ�ƴ��һ��
for i=2:SubRow
    MidH=circshift(SubH,[i-1,0]);
    SubOneH=horzcat(SubOneH,MidH);
end
%��ƴ�ӵ��ĵ�һ��ˮƽ�Ӿ��󸳸�GallagerH
GallagerH=SubOneH;
% SubReHΪѭ�������й�������ˮƽ�Ӿ�����м��������
SubReH=zeros(SubRow,CodeLength);
%���ݹ��췽�������õ��ĵ�һ��ˮƽ�Ӿ����е��д��ҵõ�����ˮƽ�Ӿ���ͬ���ķ���ѭ��һ�Σ�ƴ��һ��
for j=2:dv
    randomV=randperm(CodeLength);
    for k=1:CodeLength
        SubReH(:,k)=SubOneH(:,randomV(1,k));
    end
    GallagerH=vertcat(GallagerH,SubReH);
end
GaH=GallagerH;
