function h = draw_bar_3D(x,y,z)
figure,
hold on
dat = [y,x];
hist3(dat);

%��չ2D
n = hist3(dat); % default is to 10x10 bins
n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;

%��2DͶӰ
xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);%xֵ
yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);%yֵ

%��ɫ
h = pcolor(xb,yb,n1);

%��z��
h.ZData = ones(size(n1)) * -max(max(n));
colormap(hot) % heat map
colorbar('location','East');
xlabel('x-error'); %x��
ylabel('y-complexity'); %y��
zlabel('z-frequence');
grid on
view(3);

hold off;


