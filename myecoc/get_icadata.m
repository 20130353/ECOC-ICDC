function [td,dl,testdata,data_test_label]=get_icadata(data_train,data_train_label,data_test,data_test_label)

    traindata=data_train;
    ZTN=data_train_label;
    
    testdata=data_test;
    ZTT=data_test_label;    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % trainԤ���� 
    tndata=remmean(traindata');%ȥ��ֵ����
    stdvtn=std(tndata',1);%�����׼ƫ��
    X=tndata./repmat(stdvtn',1,size(tndata,2));   %%%% mean=0
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % testԤ���� 
    ttdata=remmean(testdata');
    stdvtt=std(ttdata',1);
    XT=ttdata./repmat(stdvtt',1,size(ttdata,2));   %%%% variance=1  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %ICA�任
    theta=[-1,1]';
    size_of_microarry=size(ZTN,1);%label�ĸ���
%     size_of_microarry=80;
    srcnb=size_of_microarry;%������������
    red=size_of_microarry;   %����ֵ�ĸ���
    app='symm';%���й������гɷ�
    NL='tanh';%�̶����㷨��ʹ�õķ����Ժ���
    stab='off';%�Ƿ�����ȶ���
% % % verbose%�Ƿ����ı�����㷨��չ
% % % displayMode�Ƿ񻭳��㷨��չ���
    nbsimul=1;%��������
    eigenarray={};
    A={};
    W={};
    for i=1:nbsimul
        [eigenarray{i},A{i}, W{i}] =fastica(X,'firstEig',1,'lastEig', red, 'numOfIC', srcnb, 'g', NL, 'approach', app, 'stabilization',...
            stab, 'verbose', 'off','displayMode','off');
    end       
    eigenarray=eigenarray{1};  
    testdata=XT/eigenarray;     
    
    % % % ��ȡ����
    td=A{1};
    dl=data_train_label;  
    

end