function cplx=get_complexityN2(c1,c2,train,label)
    tintra=0;
    tinter=0;
    [data1,data2]=get_data1A2(c1,c2,train,label);
    [label1,label2]=get_label1A2(c1,c2,train,label);
    data=[data1;data2];
    label=[label1;label2];
 
    % % %����ÿ���������������������ھ���
    for i=1:size(data,1)
        dis1=get_dis(data(i,:),data1,data);%�����������
        dis2=get_dis(data(i,:),data2,data);%�����������
        
        l=label(i);
        if(isempty(find(c1==l))~=1)%��group1������ 
           tintra=tintra+dis1;
           tinter=tinter+dis2;         
        elseif(isempty(find(c2==l))~=1)%��group2������
           tintra=tintra+dis2;
           tinter=tinter+dis1;
        else
           error('Exit:not found label');
        end
    end        
       
    % % %���㸴�Ӷ�
    cplx=tintra/tinter;  
    %����Ӧ�ò�����ӷ�ĸΪ0�����
    if cplx == inf
        pause(1000);
    end
end

function dis=get_dis(point,data,train)
    dis=1.7977e+308;
    for i=1:size(data,1)
        if(isequal(data(i,:),point)) %�غϵ�
            continue;
        end
        pdis=0;
        for p=1:size(train,2)
            pdis=pdis+(data(i,p)-point(p))^2;
        end
        if(sqrt(pdis)<dis)
            dis=sqrt(pdis);
        end
    end    
end