function clpx=get_complexityN3(c1,c2,train,label) 
   % % %����train data & label
   [data1,data2]=get_data1A2(c1,c2,train,label);
   traindata=[data1;data2];
   trainlabel=zeros([size(data1,1)+size(data2,1),1]);
   trainlabel(1:size(data1,1))=1;
   trainlabel(size(data1,1)+1:size(data2,1))=2;  
  
%    % % %��һ��ѵ�� & ���飨MATALB�Դ���
%    count=0;
%    N=size(traindata,1);
%    for i=1:size(traindata,1)
%       [tnindex,ttindex] = crossvalind('LeaveMOut',N,1);
%       
%       % % �ҵ�train��Ӧ��label
%       td=traindata(tnindex',:);
%       tl=trainlabel(tnindex');      
%       ttd=traindata(ttindex',:);
%       ttl=trainlabel(ttindex',:);
%       
%       knn_model =ClassificationKNN.fit(td,tl,'NumNeighbors',1);
%       predict_label = predict(knn_model,ttd);
%       if(predict_label~=ttl)
%            count=count+1;
%       end
%    end
% 
%   % % %��һ��ѵ�� & ���飨�Լ�д�ģ�
   count=0;
   N=size(traindata,1);
   for i=1:size(traindata,1)      
     
      %���Լ�
      ttd=traindata(i,:);
      ttl=trainlabel(i);    
      
      %ѵ����
      td=traindata;
      td(i,:)=[];
      tl=trainlabel;
      tl(i)=[];
      
      knn_model =ClassificationKNN.fit(td,tl,'NumNeighbors',1);
      predict_label = predict(knn_model,ttd);
      if(predict_label~=ttl)
           count=count+1;
      end
   end
   
   clpx=count/size(traindata,1);
  
end  