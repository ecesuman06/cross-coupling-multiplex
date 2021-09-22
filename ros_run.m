clear all; clc; close all; tic
% % %---------------non-local regular network---------------------
N=50;
a=0.2; c=4.8; e1=1; e2=1; k=-1;  
par = [ a,c,e1,e2,k,N];
tf = 500 ; ts = [ 0:0.01:tf ] ; y0 = rand(6*N,1) ;
rand('seed',42);
b = 0.2*ones(1,2*N) ;
b(1:N/2)=sort(random('uniform',0.4,0.8,1,N/2));
b(N/2+1:N)=sort(random('uniform',0.4,.8,1,N/2),'descend');
for trans=1:5
    [t,data] = ode45(@(t1,x1)ros(t1,x1,par,b),ts,y0) ;
    y0 = data(end,:) ;
end
xx =  data(:,1:3:6*N); yy = data(:,2:3:6*N) ; zz = data(:,3:3:6*N) ;

figure(1)
set(gcf,'units','inches','position',[4 2 5.5 5])

subplot 221
plot(xx(end-900,:),'or','markersize',3,'markerfacecolor','r')
set(gca,'xlim',[1,100],'ylim',[min(xx(end-900,:))-0.5,max(xx(end-900,:))+0.5],'fontsize',14,'linew',1.5,'xtick',[1 25 50 75 100]) %
set(gca,'units','inches','position',[0.6 3.2 1.7 1.7])
text(-30,1,'(a)','fontsize',14)
xlabel('index','fontsize',16)
ylabel('$x$','fontsize',22,'interpreter','latex')

subplot 222
imagesc(xx(end-10000:end,:));colormap('jet')
xlabel('index','fontsize',16)
ylabel('time','fontsize',16)
set(gca,'xlim',[1,100],'fontsize',14,'linew',1.5, 'ydir','normal','xtick',[1 25 50 75 100])
set(gca, 'YTick', [1,5000,10000], 'YTickLabel', [100,150,200])
cl=colorbar; set(cl,'units','inches','position',[5 3.2 0.1 1.7])
set(gca,'units','inches','position',[3.1 3.2 1.7 1.7])
text(-45,9999,'(b)','fontsize',14)

subplot 223
plot(zz(10000,:),'or','markersize',3,'markerfacecolor','r')
set(gca,'xlim',[1,100],'ylim',[0,2.3],'fontsize',14,'linew',1.5,'xtick',[1 25 50 75 100])%
set(gca,'units','inches','position',[0.6 0.67 1.7 1.7])
text(-30,4.3,'(c)','fontsize',14)
xlabel('index','fontsize',16)
ylabel('$z$','fontsize',22,'interpreter','latex')

subplot 224
imagesc(zz(1:20000,:));colormap('jet')
xlabel('index','fontsize',16)
ylabel('time','fontsize',16)
set(gca, 'YTick', [1,9000,18000], 'YTickLabel', [100,150,200])
cl=colorbar;
set(cl,'units','inches','position',[5 0.67 0.1 1.7])
set(gca,'xlim',[1,100],'fontsize',14,'linew',1.5, 'ydir','normal','xtick',[1 25 50 75 100])
set(gca,'units','inches','position',[3.1 0.67 1.7 1.78])
text(-45,17999,'(d)','fontsize',14)
% %%------------------------------------------------
figure(2)
set(gcf,'units','inches','position',[4 2 5.5 2.5])
subplot 121
plot(t,zz(:,1:50)); hold on;
plot(t,zz(:,51),'r','linew',1.2) 
set(gca,'fontsize',14,'units','inches','position',[0.78 0.75 2.2 1.6])
set(gca,'xlim',[92,110])%,'xtick',[200 215]
set(gca,'fontsize',14)
xlabel('time','fontsize',16)
ylabel('$z^{(1,2)}_{i}$','fontsize',22,'interpreter','latex')
text(90,30,'(a)','fontsize',14)

subplot 122
% plot(zz(end-20000:end,51),zz(end-20000:end,1:51)); hold on
% plot(zz(end-2000:end,51),zz(end-2000:end,51),'r','linew',1.2); hold on
plot3(xx(:,1:50),yy(:,1:50),zz(:,1:50)); hold on
plot3(xx(:,51),yy(:,51),zz(:,51),'k');
% set(gca,'xlim',[0,17],'ylim',[0,70],'fontsize',14,'linew',1.2,'xtick',[0,5,10,15])
xlabel('$z^{(1)}_{i}$','fontsize',20,'interpreter','latex')
ylabel('$z^{(2)}_{i}$','fontsize',20,'interpreter','latex')
set(gca,'units','inches','position',[3.8 0.75 1.6 1.6])
text(-10,70,'(b)','fontsize',14)
% % % % % % %==========================================================
% subplot 241
%     plot(t, xx(:,1:50)),   title x-upper
% subplot 242
%     plot(t, zz(:,1:50)),   title y-upper
% subplot 243
%     plot(t, xx(:,51:100)),   title x-lower
%  subplot 244
%     plot(t, zz(:,51:100)),   title y-lower
% subplot 245
%     plot(xx(:,1:50),xx(:,51:100));    title intra
% subplot 246
%     plot(t,xx(:,1:10),t,xx(:,51:60));    title x-inter
% subplot 247
%     plot(t,zz(:,1:50),t,zz(:,51));   title y-inter
% subplot 248
%     plot(zz(:,1:50),zz(:,51:100));   title inter
% figure
% plot3(zz(:,51),xx(:,51),zz(:,1:50));hold on
% plot3(zz(:,51),xx(:,51),zz(:,51),'k')
% view(-15,17)
% figure
% plot(t,zz(:,1:50),t,zz(:,51))
% figure
% plot3(xx(:,1:50),yy(:,1:50),zz(:,1:50)); hold on
% plot3(xx(:,51),yy(:,51),zz(:,51),'k');
% figure
% subplot 121
% plot(zz(end,:),'o')
% subplot 122
% imagesc(zz);colormap jet;colorbar
% % plot3(xx(:,1),yy(:,1),zz(:,1));
% % round(mean(std(xx)),3)
% % %%-------------order parameter polar fom
% % % phs=atan(yy./xx);
% % % rxy=sqrt(xx.^2+yy.^2);
% % % figure
% % % polar(phs(end,:),rxy(end,:),'ok');
% % R=mean(abs(mean(exp(1i*phs),2)))
% xb=mean(xx,2);  yb=mean(yy,2);
% xbl1=mean(xx(:,1:1:50),2);  xb22=mean(xx(:,51:1:100),2);
% ybl1=mean(yy(:,1:1:50),2);  yb22=mean(yy(:,51:1:100),2);
% xb=repmat(xb,1,2*N);    xbl1=repmat(xbl1,1,N);  xbl2=repmat(xb22,1,N);
% yb=repmat(yb,1,2*N);    ybl1=repmat(ybl1,1,N);  ybl2=repmat(yb22,1,N);
% % %%---------------------
% sigma=mean(sqrt((1/(4*N))*sum((xb-xx).^2+(yb-yy).^2,2)))
% sigmaL12=mean(sqrt((1/(2*N))*sum((xx(:,1:50)-xx(:,51:100)).^2,2)))
% sigmaL1=mean(sqrt((1/(2*N))*sum((xbl1-xx(:,1:50)).^2+(ybl1-yy(:,1:50)).^2,2)));
% sigmaL2=mean(sqrt((1/(2*N))*sum((xbl2-xx(:,51:100)).^2+(ybl2-yy(:,51:100)).^2,2)));
% fprintf('all = %s , inter = %s , intra = %s , %s\n',num2str(sigma),num2str(sigmaL12),num2str(sigmaL1),num2str(sigmaL2))