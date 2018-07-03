%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ���Ƹ��Ӷȱ任������ͼ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function draw_cplx(cplx,respath,fs_size,data_complexity,fs_option)
    linestyle={'p-','*-','d-','s-','+-','o-','x-','<-','^-'};
    colors =[0,0,0; 0.8,0,0; 0,0,1; 0.3,0,0.5; 0,0.6,1; 0.6,0,0;0.84,0.6,0.6; 0.5,0.2,0.9;];
    ylabels = {'F1';'F2';'F3';'N2';'N3';'N4';'L3';'Cluster'};
    fontsize = 12;

    for dnum=data_complexity%���Ӷ�
        cp={};
 
        hold on
        for i=1:size(cplx,1)%���ݼ��ĸ���
           cp=cplx{i,2}{dnum};%���ݼ���Ӧ��ĳ�����ݸ��Ӷ�
           temp={};
           for k=1:size(cp,2)
                if(size(cp{k},2)>=2)%����оֲ�����
                   temp{size(temp,2)+1}=cp{k};%�����оֲ���ε����Ĺ���
                end
           end
           if(isempty(temp))
               Y=cp{size(cp,2)};
            %ѡȡ������ĵ�������--�����������
           else
                gaps=zeros([1,10]);
                for k=1:size(temp,2)
                    tt=temp{k};
                    gap=zeros([1,10]);
                    for l=1:size(tt,2)-1
                       gap(l)=abs(tt(l+1)-tt(l)); 
                    end
                    gaps(k)=max(gap);
                end
                Y=temp{find(gaps==max(gaps),1,'first')};
           end
            X=sort(randperm(size(Y,2)));
            plot(X,Y,linestyle{i},'Color',colors(i,:),'markersize',6);     
            
        end
       
        hold off
%        datanames={'Breast','Cancers','DLBCL','GCM','Leukemia2','Leukemia3','Lung1',}; 
%        legend(datanames,'location','best');
       xlabel('times','Fontsize',fontsize); %x��
       ylabel([ylabels{dnum},'-value'],'Fontsize',fontsize); %y��   
       set(gca,'XTick',0:1:5);
       grid on;
       
    end%end of dnum
    
end%end of function 