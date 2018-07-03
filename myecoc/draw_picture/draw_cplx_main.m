%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ���Ƹ��Ӷȵ�main����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
learners={'svm','NMC'};
fs_method = {'roc','ttest','wilcoxon'};
titles = {'Roc','T-test','Wilcoxon'};
datanames={'Cancers','DLBCL','GCM','Leukemia2','Leukemia3','Lung1','SRBCT'};
legend_names  = {'Cancers','DLBCL','GCM','Leukemia1','Leukemia2','Lung','SRBCT'};
genpath = 'E:\����\ecoc\ecoc-2.26\ICDC-ECOC\data';
ylabels = {'F1';'F2';'F3';'N2';'N3';'N4';'L3';'Cluster'};
fontsize =8;

clf;%���figure
figure
set(gca, 'Position', [9 145 955 399]);

for fs_option = 1:3
    clf;
    for dnum = 4:5
        subplot(2,1,dnum-3);
        title(ylabels{dnum},'FontSize',fontsize);
        
        picrespapth = ['E:\����\ecoc\ecoc-2.26\ICDC-ECOC\data\���Ľ������-����1\LineChart\'];
        mkdir(picrespapth);
        
        for fs_size = 150
            
            filepath = [genpath,'\data_fs_10--150\data_fs_',num2str(fs_size),'\',fs_method{fs_option},'\dcplx'];
            tdcplx = create_dtcplx(filepath,learners{1},datanames);
            draw_cplx(tdcplx,picrespapth,fs_size,dnum,fs_method{fs_option});            
        end
    end
    legend(legend_names,'location','best','FontSize',fontsize);
    
    saveas(gca ,[picrespapth,'\',ylabels{dnum},'_',fs_method{fs_option},'_',num2str(fs_size)],'fig');
    disp([picrespapth,'\',ylabels{dnum},'_',fs_method{fs_option},'_',num2str(fs_size)]);
    saveas(gca ,[picrespapth,'\',ylabels{dnum},'_',fs_method{fs_option},'_',num2str(fs_size)],'tiff');
    
end


%%%F1-F3 roc
matrespath = [genpath,'\mat\dcplx\',learners{1},'\',fs_method{fs_option}];
mkdir(matrespath);

picrespapth = [genpath,'\pic\�ڿ�\new_N3\cplx\Cluster'];  
mkdir(picrespapth);

for fs_option = 1:size(fs_method,2)
    for fs_size = 110:10:150
        clf;%���figure
        figure  
        for dnum = 8

            subplot(1,1,dnum-7);
            title(ylabels{dnum},'FontSize',fontsize);

            filepath = [genpath,'\data_fs_10--150_pair_newN3\data_fs_',num2str(fs_size),'\',fs_method{fs_option},'\dcplx'];
            tdcplx = create_dtcplx(filepath,learners{1},datanames);
            draw_cplx(tdcplx,picrespapth,fs_size,dnum,fs_method{fs_option});      
            legend(datanames,'location','best','FontSize',fontsize);
            
        end      
        
        saveas(gca ,[picrespapth,'\',fs_method{fs_option},'_',ylabels{dnum},'_',num2str(fs_size)],'fig');  
        saveas(gca ,[picrespapth,'\',fs_method{fs_option},'_',ylabels{dnum},'_',num2str(fs_size)],'tiff');  
    end
end




