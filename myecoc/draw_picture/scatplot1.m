function scatplot1(x,y)

[M N]=size(x);

maxx=max(x);
minx=min(x);
maxy=max(y);
miny=min(y);
tj=zeros(401,401);  %���������ҵ����ݷֳ�400�Ƚ����á�x,y������9�������ͼ��õ��ġ�
xfd=(maxx-minx)/400;
yfd=(maxy-miny)/400;
for i=1:M
    i_tmp=int32((x(i)-minx)/xfd)+1;
    j_tmp=int32((y(i)-miny)/yfd)+1;
    tj(i_tmp,j_tmp)=tj(i_tmp,j_tmp)+1;
end

tjmax=max(max(tj));  %�ҳ�����Ҫ�ҳ����ֵ
[i,j]=find(tj==tjmax);

i=mean(i) ;%��Ϊ���ֵ��ֻһ����ȡ��ƽ������Ϊ�Ҳ���Ҫ�Ǹ�ȷ�еĵ㡣
j=mean(j);

image(tj)

end