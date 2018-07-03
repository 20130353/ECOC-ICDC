% --------------------------------------------------- %  ����������̶ȱ�ǩ�Ӻ���  % ---------------------------------------------------
function MyTickLabel(ha,tag)
%   ������ʾ��Χ�Զ�����������̶ȱ�ǩ�ĺ���
%   ha   ����ϵ���ֵ
%   tag  ����������̶ȱ�ǩ�ı�ʶ�ַ���������ȡֵ���£�
%        'Auto' --- ��x��̶ȱ�ǩ��ת90�ȣ�y��̶ȱ�ǩ��������
%        'Tril' --- ��x��̶ȱ�ǩ��ת90�ȣ�������������y��̶ȱ�ǩ��������
%        'Triu' --- ��x��̶ȱ�ǩ��ת90�ȣ�y��̶ȱ�ǩ��������
%   Example:
%   MyTickLabel(gca,'Tril');
%  %   CopyRight��xiezhh��л�л���,2013.1��д
if ~ishandle(ha)
    warning('MATLAB:warning2','��һ���������ӦΪ����ϵ���');
    return;
end
if ~strcmpi(get(ha,'type'),'axes')
    warning('MATLAB:warning3','��һ���������ӦΪ����ϵ���');
    return;
end
axes(ha);
xstr = get(ha,'XTickLabel');
xtick = get(ha,'XTick');
xl = xlim(ha);
ystr = get(ha,'YTickLabel');
ytick = get(ha,'YTick');
yl = ylim(ha);
set(ha,'XTickLabel',[],'YTickLabel',[]);
x = zeros(size(ytick)) + xl(1) - range(xl)/30;
y = zeros(size(xtick)) + yl(1) - range(yl)/70;
nx = numel(xtick);
ny = numel(ytick);
if strncmpi(tag,'Tril',4)
    y = y + (1:nx) - 1;
elseif strncmpi(tag,'Triu',4)
    x = x + (1:ny) - 1;
end
text(xtick,y,xstr,...
    'rotation',90,...
    'Interpreter','none',...
    'color','r',...
    'HorizontalAlignment','left');
text(x,ytick,ystr,...
    'Interpreter','none',...
    'color','r',...
    'HorizontalAlignment','right');
end