% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% ica ecoc test
function [data_test_label,all_labels,accratio,elapsed,tcplx,tcds,confmat,binary_y,classifier_error,classifier_right,ECOC_cplx]=ica_ecoc(td,dl,testdata,data_test_label,option,classifier)

% % % init
tcds={};
tcplx=[];
all_labels={};
accratio={};
elapsed=[];
confmat = {};
binary_y = {};
classifier_error = {};
classifier_right = {};
ECOC_cplx = {};

%      option='data_cplx';
% % %�Ƿ����cplx
if(strcmp(option,'data_cplx')==1)
    global tcds;
    data_train_lu=unique(dl);
    [tcds,tcplx]=get_all_cds(size(data_train_lu,1),td,dl,'ALL');
    tcds{size(tcds,2)+1}=get_emsemble(tcds{1},tcds{2},tcds{3});%�ϲ�F1-F3
elseif(size(option,2) > 1 && strcmp(option,'ica')~=1 )
    tcds = option;
    option = 'data_cplx';
end

if(strcmp(classifier,'ADA')~=1 && strcmp(classifier,'NMC')~=1)
    [elapsed,accratio,all_labels,tcds,confmat,binary_y,classifier_error,classifier_right,ECOC_cplx]=get_learners(tcds,td,dl,testdata,data_test_label,option,classifier,elapsed,accratio,all_labels,confmat,binary_y,classifier_error,classifier_right,ECOC_cplx);
else
    [elapsed,accratio,all_labels,tcds,confmat]=get_AANlearner(tcds,td,dl,testdata,data_test_label,option,classifier,elapsed,accratio,all_labels,confmat);
end
end

%%SVM,discriminant,NB,tree
function [elapsed,accratio,all_labels,tcds,confmat,binary_y,classifier_error,classifier_right,ECOC_cplx]=get_learners(tcds,td,dl,testdata,data_test_label,option,classifier,elapsed,accratio,all_labels,confmat,binary_y,classifier_error,classifier_right,ECOC_cplx)
%   �µ�ecoc train
global cds;
global decoding;
disp(['������ѵ��:',classifier]);
if(strcmp(option,'ica')==1)
    %%OVA,OVO,DR,SR--MATLAB2015
%     codings={'OneVsOne','OneVsAll','Random'};
%         codings = {'OneVsOne','Random','OneVsAll'};
%     for i = 1:size(codings,2)
%         cds=[];
%         tstart = tic;
%         ecocmodel=fitcecoc(td,dl,'Coding',codings{i},'learners',classifier);
%         cds = ecocmodel.CodingMatrix;
%                 Labels=predict(ecocmodel,testdata);
%                 tcds{size(tcds,2)+1} = cds;
%         
%                 [confusion,~]=confusionmat(data_test_label,Labels);
%                 elapsed = [elapsed toc(tstart)];%ѵ����Ԥ��ʱ��
%                 confmat= [confmat confusion];%��������
%                 accratio = [accratio  Fscore(data_test_label,Labels)];%׼ȷ��
%                 all_labels= [all_labels  Labels];%testԤ��label
%                 end
%         clear Parameters;
%         Parameters.coding = codings{i};%����ECOC
%         Parameters.decoding = 'ED';%����
%         Parameters.base = 'MySVM';%������
%         Parameters.base_test = 'MySVM_Test';%������
%         [Classifiers,Parameters] = ECOCTrain(td,dl,Parameters,[]);%ѵ������
%         [Labels,~,confusion] = ECOCTest(testdata,Classifiers,Parameters,data_test_label);
%         confmat{size(confmat,2)+1} = confusion;%���������׼ȷ�ʾ���
%         ����׼ȷ��
%         accratio = [accratio Fscore(data_test_label,Labels)];%׼ȷ�Ȳ�ȸ���
%         all_labels = [all_labels Labels];        
%     end
    %% DECOC��ECOCOne��FroestECOC--ECOC library
    codings={'OneVsOne','OneVsAll','Random','DECOC','ECOCONE','Forest'};
    for i=1:size(codings,2)
        tstart = tic;
        
        clear Parameters;
        Parameters.coding = codings{i};%����ECOC
        Parameters.decoding = 'ED';%����
        Parameters.base = 'MySVM';%������
        Parameters.base_test = 'MySVM_Test';%������
        [Classifiers,Parameters] = ECOCTrain(td,dl,Parameters,[]);%ѵ������
        [Labels,~,confusion] = ECOCTest(testdata,Classifiers,Parameters,data_test_label);
        cds = Parameters.ECOC;%%%%%%��ȡECOC matrix
        
        tcds{size(tcds,2)+1} = cds;
        [confusion,~] = confusionmat(data_test_label,Labels);
        elapsed = [elapsed toc(tstart)];%ѵ����Ԥ��ʱ��
        confmat= [confmat confusion];%��������
        accratio = [accratio  Fscore(data_test_label,Labels)];%׼ȷ��
        all_labels= [all_labels  Labels];%testԤ��label
        
    end
elseif(strcmp(option,'data_cplx')==1)
    
    DC_OPTIONS = {'F1','F2','F3','N2','N3','N4','L3','Cluster','CF'};
    for i=1:size(tcds,2)%���Ӷȵĸ���
        
        %         cds=tcds{i};
        %         clear Parameters;
        %         Parameters.coding = 'OneVsOne';%����ECOC
        %         Parameters.decoding = decoding;%����
        %         Parameters.base = 'MySVM';%������
        %         Parameters.base_test = 'MySVM_Test';%������
        %         [Classifiers,Parameters] = ECOCTrain(td,dl,Parameters,cds);%ѵ������
        %         [Labels,~,confusion] = ECOCTest(testdata,Classifiers,Parameters,data_test_label);
        %         confmat{size(confmat,2)+1} = confusion;%���������׼ȷ�ʾ���
        %         %����׼ȷ��
        %         accratio = [accratio Fscore(data_test_label,Labels)];%׼ȷ�Ȳ�ȸ���
        %         all_labels = [all_labels Labels];
        %
        %         X = get_X(ecocmodel.BinaryLearners,testdata);
        %
        %         binary_y = [binary_y X];
        %         classifier_error = [classifier_error get_classifier_error(cds, X,data_test_label)];
        %         classifier_right = [classifier_right get_classifier_right(cds, X,data_test_label)];
        %         if strcmp(DC_OPTIONS{i},'CF') == 0
        %             ECOC_cplx = [ECOC_cplx get_ecoc_cplx(cds,DC_OPTIONS{i},testdata,data_test_label)];
        %         end
        
        cds=tcds{i};
        tstart = tic;
        ecocmodel=fitcecoc(td,dl,'learners',classifier);
        Labels = predict(ecocmodel,testdata);
        
        [confusion,~]=confusionmat(data_test_label,Labels);
        elapsed = [elapsed toc(tstart)];%ѵ����Ԥ��ʱ��
        confmat = [confmat confusion];%��������
        accratio = [accratio  Fscore(data_test_label,Labels)];%׼ȷ��
        all_labels= [all_labels  Labels];%testԤ��label
        
        X = get_X(ecocmodel.BinaryLearners,testdata);
        
        binary_y = [binary_y X];
        classifier_error = [classifier_error get_classifier_error(cds, X,data_test_label)];
        classifier_right = [classifier_right get_classifier_right(cds, X,data_test_label)];
        
        global TD;
        global TL;
        TD = td;
        TL = dl;
        if strcmp(DC_OPTIONS{i},'CF') == 0
            ECOC_cplx = [ECOC_cplx get_ecoc_cplx(cds,DC_OPTIONS{i},testdata,data_test_label)];
        end
    end
end
end


%NMC,ADA
function [elapsed,accratio,all_labels,tcds,confmat]=get_AANlearner(tcds,td,dl,testdata,data_test_label,option,lindex,elapsed,accratio,all_labels,confmat)
% % %ȷ��ADA or NMC learner

learners={'NMC','ADA'};
test={'NMCTest','ADAtest'};
disp(['������ѵ����',classifier]);

global cds;
% % %ȷ����ica or cplx
if(strcmp(option,'ica')==1)
    codings={'onevsone','denserandom','onevsall','ordinal','sparserandom'};
    for i=1:size(codings,2)
        cds=[];
        ecocmodel=fitcecoc(td,dl,'Coding',codings{i});
        cds=ecocmodel.CodingMatrix;
        tcds{size(tcds,2)+1}=cds;
        clear Parameters;
        Parameters.coding='OneVsOne';%����ECOC
        Parameters.decoding='ED';%����
        Parameters.base=learners{lindex};%������
        Parameters.base_params.iterations=50;%��������
        Parameters.base_test=test{lindex};%
        
        tstart = tic;
        [Classifiers,Parameters]=ECOCTrain(td,dl,Parameters,cds);%ѵ������
        [Labels,~,confusion]=ECOCTest(testdata,Classifiers,Parameters,data_test_label);%��������
        
        elapsed = [elapsed toc(tstart)];%ѵ����Ԥ��ʱ��
        confmat= [confmat confusion];%��������
        accratio = [accratio  Fscore(data_test_label,Labels)];%׼ȷ��
        all_labels= [all_labels  Labels];%testԤ��label
    end
    
    % ��ȡ DECOC��ECOCOne��FroestECOC
    codings={'DECOC','ECOCONE','Forest'};
    for i=1:size(codings,2)
        clear Parameters;
        Parameters.coding=codings{i};%����ECOC
        Parameters.decoding='ED';%����
        Parameters.base=learners{lindex};%������
        Parameters.base_params.iterations=50;%��������
        Parameters.base_test=test{lindex};%���Թ���
        
        tstart = tic;
        [Classifiers,Parameters]=ECOCTrain(td,dl,Parameters,[]);%ѵ������
        [Labels,~,confusion]=ECOCTest(testdata,Classifiers,Parameters,data_test_label);%��������
        len=size(elapsed,2);
        tcds{size(tcds,2)+1}=Parameters.ECOC;
        
        [confusion,~]=confusionmat(data_test_label,Labels);
        elapsed = [elapsed toc(tstart)];%ѵ����Ԥ��ʱ��
        confmat= [confmat confusion];%��������
        accratio = [accratio  Fscore(data_test_label,Labels)];%׼ȷ��
        all_labels= [all_labels  Labels];%testԤ��label
    end
elseif(strcmp(option,'data_cplx')==1)
    for i=1:size(tcds,2)%���ݸ��ӶȲ��
        Parameters.coding='OneVsOne';%����ECOC
        Parameters.decoding='ED';%����
        Parameters.base=learners{lindex};%������
        Parameters.base_params.iterations=50;%��������
        Parameters.base_test=test{lindex};%���Թ���
        
        tstart = tic;
        [Classifiers,Parameters]=ECOCTrain(td,dl,Parameters,tcds{i});%ѵ������
        [Labels,~,confusion]=ECOCTest(testdata,Classifiers,Parameters,data_test_label);%��������
        
        [confusion,~]=confusionmat(data_test_label,Labels);
        elapsed = [elapsed toc(tstart)];%ѵ����Ԥ��ʱ��
        confmat= [confmat confusion];%��������
        accratio = [accratio  Fscore(data_test_label,Labels)];%׼ȷ��
        all_labels= [all_labels  Labels];%testԤ��label
    end
end
end

function classifier_error = get_classifier_error(ECOC,predicted_Y,TTL)
%     classifier_right = zeros(1,size(ECOC,2));
%     for i = 1:size(TTL,1)
%        true_binary_y = ECOC(TTL(i),:);
%        predicted_y = predicted_Y(i,:);
%        classifier_right = classifier_right + (true_binary_y == predicted_y);
%     end
%     classifier_error = 1 - classifier_right/size(TTL,1);
classifier_error = [];
for column = 1:size(ECOC,2)
    samples_inx = [];
    true_label = [];
    classes = find(ECOC(:,column) == 1)';%positive classes
    for i = 1:size(classes,2)
        inx = find(TTL == classes(i));
        samples_inx = [samples_inx;inx];
    end
    
    true_label = ones(size(samples_inx,1),1);
    
    classes = find(ECOC(:,column) == -1)';%negative classes
    for i = 1:size(classes,2)
        inx = find(TTL == classes(i));
        samples_inx = [samples_inx;inx];
    end
    
    true_label =[true_label;-ones(size(samples_inx,1)-size(true_label,1),1)];
    
    predict = predicted_Y(samples_inx,column);
    error = sum(predict ~= true_label)/size(samples_inx,1);
    classifier_error = [classifier_error error];
end

end

function classifier_right = get_classifier_right(ECOC,predicted_Y,TTL)
classifier_right = [];
for column = 1:size(ECOC,2)
    samples_inx = [];
    true_label = [];
    classes = find(ECOC(:,column) == 1)';%positive classes
    for i = 1:size(classes,2)
        inx = find(TTL == classes(i));
        samples_inx = [samples_inx;inx];
    end
    
    true_label = ones(size(samples_inx,1),1);
    
    classes = find(ECOC(:,column) == -1)';%negative classes
    for i = 1:size(classes,2)
        inx = find(TTL == classes(i));
        samples_inx = [samples_inx;inx];
    end
    
    true_label =[true_label;-ones(size(samples_inx,1)-size(true_label,1),1)];
    
    predict = predicted_Y(samples_inx,column);
    right = sum(predict == true_label)/size(samples_inx,1);
    classifier_right = [classifier_right right];
end
end

function ECOC_cplx = get_ecoc_cplx(ECOC,DC_OPTION,TTD,TTL)
ECOC_cplx = [];
if strcmp(DC_OPTION,'N4') == 1 || strcmp(DC_OPTION,'L3') ==  1
    return;
end
for i = 1:size(ECOC,2)
    c1 = find(ECOC(:,i) == 1)
    c2 = find(ECOC(:,i) == -1)
    cplx = get_complexity_option(c1,c2,TTD,TTL,DC_OPTION);
    ECOC_cplx = [ECOC_cplx cplx];
end
end

function X = get_X(classifiers,data)
X = [];
for i=1:size(classifiers,1)
    x = predict(classifiers{i},data);
    X = [X x];
end

end
