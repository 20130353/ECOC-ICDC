%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ��F1-F3���ɵľ���ľ����ں�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function em_cds=get_emsemble(cds1,cds2,cds3)
    em_cds = (unique([cds1,cds2,cds3]','rows'))';
end


