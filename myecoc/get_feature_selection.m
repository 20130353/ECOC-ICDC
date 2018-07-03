function [reduced_traindata,reduced_testdata] = get_feature_selection(traindata,testdata,fs_option)
%���������ѵ�����ݣ��������ݣ�����ѡ�񷽷����������������ǻ���
 
    addpath(genpath('E:\����\ecoc\ecoc-2.26\ICDC-ECOC\feature_select'));   
    tdlen = size(traindata,1);
    data = [traindata;testdata];%�ϲ�ѵ�����ݺͲ�������
    
    switch 'fs_option'        
        case 'Relief'
            [important_data, important_order,  reduced_data, reduced_data_order] = Relief ( data );
            
        case 'Laplacian'
            % ���Ʊ���ά��
            no_dims = round(intrinsic_dim(data, 'MLE'));
            disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);
            
            %����ѡ��
            [reduced_data,tdmapping] = compute_mapping(data,'Laplacian',no_dims);        
            
        case 'Isomap'
            % ���Ʊ���ά��
            no_dims = round(intrinsic_dim(data, 'MLE'));
            disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);
            
            %����ѡ��
            [reduced_data,tdmapping] = compute_mapping(data,'Isomap',no_dims);            
    end
    
    reduced_traindata = reduced_data(1:tdlen,:);
    reduced_testdata = reduced_data(tdlen+1,:);   
    
end
