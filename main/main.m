function [] = main( data_path , save_path )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global GDS;
global GDS_Name;
global GLearners;
global GFS;
global GFS_Name;


GDS = {'Breast','Cancers','DLBCL','GCM','Leukemia2','Leukemia3','Lung1','SRBCT'};
GDS_Name = {'Breast','Cancers','DLBCL','GCM','Leukemia1','Leukemia2','Lung','SRBCT'};
GLearners={'discriminant','naivebayes','svm','tree','NMC','ADA'};  
GFS = {'bhattacharyya','entropy','LaplacianScore','roc','Su','ttest','wilcoxon'};
GFS_Name = {'BC','EN','LS','Roc','Su','T-test','Wilcoxon'};


%%ECOC����ʼ
addpath(genpath(pwd));
ica_main(data_path,save_path); 

end

