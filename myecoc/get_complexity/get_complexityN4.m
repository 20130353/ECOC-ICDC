
% group����֮����в�ֵ
% function [clpx,flag,ttlabel,predict_label]=get_complexityN4(c1,c2,train,label)
%     [data1,data2]=get_data1A2(c1,c2,train,label);
%     [label1,label2]=get_label1A2(c1,c2,train,label);
%     
%     % % %����test data & label & flag
%     [flag1,test1,label1]=get_test(c1,data1,label1,1);
%     [flag2,test2,label2]=get_test(c2,data2,label2,2);
% %     if(isempty(label1)==false && isempty(label2)==false && isempty(test1)==false && isempty(test2)==false && size(flag1,1)~=0 && size(flag2,1)~=0)
%         flag=[flag1 flag2];
%         testdata=[test1;test2];
%         ttlabel=[label1;label2];  
% %     end
%     
%     % % %����train label
%     label=zeros([size(c1,1)+size(c2,1),1]);
%     label(1:size(data1,1),:)=1;
%     label(size(data1,1)+1:size(data1,1)+size(data2,1),:)=2;
%     
%     % % %ѵ��&Ԥ��
%     knn_model =ClassificationKNN.fit([data1;data2],label,'NumNeighbors',1);
%     predict_label = predict(knn_model,testdata);
%     
%     clpx=1-calaccracy(predict_label,ttlabel');
%    
% end
% 
% function [flag,testdata,label]=get_test(c,cdata,clabel,option)
%     minvalue = 0.000001;
%     tranddata=[];
%     trandlabel=[];
%     for i=1:size(c,1)
%        cd=cdata(find(clabel==c(i)),:);
%        cl=clabel(find(clabel==c(i)),:);
%        n=floor((size(cd,1)/2));
%        if(n==1)
%            n=2;
%        end
%        index=randperm(size(cd,1));
%        randdata=cd(index(1:n),:);
%        randlabel=cl(index(1:n),:);
%        tranddata=[tranddata;randdata];%��group�����ѡ�����ɵ�      
%        trandlabel=[trandlabel;randlabel];
%     end
%         
%     n=size(tranddata,1);    
%     
%     testdata=zeros([(n*(n-1))/2,size(tranddata,2)]);
%     count=1;  
%     flag={};
%   
%     for i=1:size(tranddata,1)
%         for j=i+1:size(tranddata,1)             
%         	n=rand(1,1);   %û��  
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %             ԭ�Ȳ�ֵ�ķ���
% %             testdata(count,:)=interp1(tranddata(i,:),tranddata(j,:),(tranddata(i,:)*n),'linear');  
%             
% %             ��sampleΪ����в�ֵ
%             temp = [tranddata(i,:);tranddata(j,:)];
%             testdata(count,:)=interp1(temp,size(temp,1)*0.55,'linear');
%             
%              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             flag{count}=[trandlabel(i),trandlabel(j)];
%             count=count+1;
%         end
%     end 
%     
%     % % %��ȡlabel
%     label=zeros([size(testdata,1),1]);
%     label(:,1)=option;
%     
% end

%�������ݲ�ֵ
function [clpx,flag,ttlabel,predict_label]=get_complexityN4(c1,c2,train,label)
    [data1,data2]=get_data1A2(c1,c2,train,label);
    [label1,label2]=get_label1A2(c1,c2,train,label);
    
    
    % % %����test data & label & flag
    [flag1,test1,ttlabel1]=get_test(c1,data1,label1);
    [flag2,test2,ttlabel2]=get_test(c2,data2,label2);
    flag=[flag1 flag2];
    testdata=[test1;test2];
    ttlabel=[ttlabel1;ttlabel2];  

    % % %ѵ��&Ԥ��
    knn_model = ClassificationKNN.fit([data1;data2],[label1;label2],'NumNeighbors',1);
    predict_label = predict(knn_model,testdata);    
    clpx=1-calaccracy(predict_label,ttlabel');
   
end

% ͬ������֮����в�ֵ
function [flag,ttdata,ttlabel]=get_test(c,cdata,clabel)
    ttdata=[];
    ttlabel=[];
    flag = {};
    for i=1:size(c,1)
      %%�ҵ�����Ӧ������
       cd=cdata(find(clabel==c(i)),:);
       n=floor((size(cd,1)/2));
       if(n==1)
           n=2;
       end
       index=randperm(size(cd,1));
       randdata=cd(index(1:n),:);
       %%�����ȡһ�����ݲ�ֵ�õ���������
       [ittdata,ittflag] = get_interation(randdata);%�õ����ڲ�ֵ����
       ttdata = [ttdata;ittdata];
       ittlabel = zeros(n*(n-1)/2,1);
       ittlabel(:,1) = c(i);
       ttlabel = [ttlabel;ittlabel];
       flag = [flag ittflag];
       
    end
end

function [testdata,flag] = get_interation(data)
   length = size(data,1);
   testdata = [];
   flag = {};
   for i=1:length
        for j=i+1:length             
            temp = [data(i,:);data(j,:)];
            testdata = [ testdata;interp1(temp,size(temp,1)*0.55,'linear') ];
            flag{size(flag,2)+1} = [i,j];%��¼λ��            
        end
   end
end