clear all;clc;close all;tic
% % non-local regular network
tic
N=50;

I=0.4; b=0.1;   e1=0.1; v=2; lambda=10; theta=-0.25; e2=-1; e3=0.1;

par = [ I b e1 v lambda theta N e2 e3];
tf = 300 ;
ts = [ 0:0.01:tf ] ; 
rand('seed',42);
y0=rand(4*N,1);
r=ones(1,2*N); 
p1=sort(normrnd(3,0.5,[1,N/2]));
p2=sort(normrnd(3,0.5,[1,N/2]),'descend');
r(1:N/2)=abs(p1);
r(N/2+1:N)=abs(p2);
% r(99)=4;
% r(11)=4;
% r(2:N)=abs(sort(random('uniform',1,2,1,N-1)));
for trans=1:4
    [t,data]=ode45(@(t1,x1,par1,r1)fhn_multi_reg_dis(t1,x1,par,r),ts,y0);
    y0=data(end,:);
end
xx=data(:,1:2:4*N); yy=data(:,2:2:4*N);

%%%% --------------------------------------%%%%%
figure(1)
set(gcf,'units','inches','position',[4 2 5.5 5])

subplot 221
plot(xx(end,:),'or','markersize',3,'markerfacecolor','r')
xlabel('index','fontsize',16)
ylabel('x','fontsize',16)
set(gca,'xlim',[1,100],'ylim',[0,1],'fontsize',14,'linew',1.5,'xtick',[1 25 50 75 100])
set(gca,'units','inches','position',[0.6 3.2 1.7 1.7])
text(-20,1,'(a)','fontsize',14)

subplot 222
imagesc(xx(end-10000:end,:));colormap('jet')
xlabel('index','fontsize',16)
ylabel('time','fontsize',16)
set(gca,'xlim',[1,100],'fontsize',14,'linew',1.5, 'ydir','normal','xtick',[1 25 50 75 100])
set(gca, 'YTick', [1,5000,10000], 'YTickLabel', [100,150,200])
cl=colorbar;
set(cl,'units','inches','position',[5 3.2 0.1 1.7])
set(gca,'units','inches','position',[3.1 3.2 1.7 1.7])
text(-35,9999,'(c)','fontsize',14)

subplot 223
plot(yy(end,:),'or','markersize',3,'markerfacecolor','r')
xlabel('index','fontsize',16)
ylabel('y','fontsize',16)
set(gca,'xlim',[1,100],'ylim',[0,12],'fontsize',14,'linew',1.5,'xtick',[1 25 50 75 100])
set(gca,'units','inches','position',[0.6 0.67 1.7 1.7])
text(-27,11.9,'(b)','fontsize',14)

subplot 224
imagesc(yy(end-10000:end,:));colormap('jet')
xlabel('index','fontsize',16)
ylabel('time','fontsize',16)
set(gca, 'YTick', [1,5000,10000], 'YTickLabel', [100,150,200])
cl=colorbar;
set(cl,'units','inches','position',[5 0.67 0.1 1.7])
set(gca,'xlim',[1,100],'fontsize',14,'linew',1.5, 'ydir','normal','xtick',[1 25 50 75 100])
set(gca,'units','inches','position',[3.1 0.67 1.7 1.7])
text(-35,9999,'(d)','fontsize',14)
% %%------------------------------------------------

figure(2)
set(gcf,'units','inches','position',[4 2 5.3 2.5])
subplot 121
plot(t(end-28000:end),yy(end-28000:end,1:50)); hold on;
plot(t(end-28000:end),yy(end-28000:end,51),'r','linew',1.2) 
xlabel('time','fontsize',16)

set(gca,'xlim',[280,300],'fontsize',14,'xtick',[280 290 300],'ylim',[-5,11.5],'ytick',[-5,0,5,10])
set(gca,'fontsize',14,'units','inches','position',[0.78 0.75 2.2 1.6])
text(275,11.9,'(e)','fontsize',14)
ylabel('$y^{(1,2)}_{i}$','interpreter','latex','fontsize',20)

% subplot 122
% plot(yy(end-20000:end,51),yy(end-20000:end,1:51)); hold on
% plot(yy(end-2000:end,51),yy(end-2000:end,51),'r','linew',1.2); hold on
% axis([-1,3,-5,26])
% xlabel('y^{(1)}_{i}','fontsize',16)
% ylabel('y^{(2)}_{i}','fontsize',16)
% set(gca,'xlim',[-1,3],'ylim',[-5,12],'fontsize',14,'linew',1.5,'xtick',[-1 1 3])
% set(gca,'units','inches','position',[3.7 0.75 1.6 1.6])
% text(-2,10,'(f)','fontsize',14)


% figure(2)
% plot(xx(:,51),xx(:,52:100))
% xlabel('x^{(2)}_1','fontsize',16)
% ylabel('x^{(2)}_i','fontsize',16)
% set(gcf,'units','inches','position',[2 2 4 2.5])
% set(gca,'units','inches','position',[0.5 0.6 3.3 1.8])
% set(gca,'xlim',[-1.5,1.5],'ylim',[-1.5,1.5],'fontsize',14,'linew',1.5)
% 
% figure(3)
% plot(xx(:,1),xx(:,51))
% xlabel('x^{(1)}_1','fontsize',16)
% ylabel('x^{(2)}_1','fontsize',16)
% set(gcf,'units','inches','position',[2 2 4 2.5])
% set(gca,'units','inches','position',[0.5 0.6 3.3 1.8])
% set(gca,'xlim',[-1.5,1.5],'ylim',[-1.5,1.5],'fontsize',14,'linew',1.5)
% 
% 
% figure
%  plot(yy(end-20000:end,51),yy(end-20000:end,1:51)); hold on
%   plot(yy(end-2000:end,51),yy(end-2000:end,51),'k','linew',2); hold on
%  axis([-1,3,-5,26])
%%%---------------------------------------------------------------
N=50;
I=0.4; b=0.1;   e1=0.1; v=2; lambda=10; theta=-0.25; e2=-1; e3=0.1;
par = [ I b e1 v lambda theta N e2 e3];
tf = 300 ;
ts = [ 0:0.01:tf ] ; 
rand('seed',42);
y0=rand(4*N,1);
r=ones(1,2*N); 
p1=sort(normrnd(3,0.5,[1,N/2]));
p2=sort(normrnd(3,0.5,[1,N/2]),'descend');
r(1:N/2)=abs(p1);
r(N/2+1:N)=abs(p2);

for trans=1:4
    [t,data]=ode45(@(t1,x1,par1,r1)fhn_multi_reg_dis(t1,x1,par,r),ts,y0);
    y0=data(end,:);
end
xx=data(:,1:2:4*N); yy=data(:,2:2:4*N);
isi2=[];
for i=1:2*N
[peaks, time]=findpeaks(yy(:,i));
%time(peaks<0)=[];
time=round(time*0.01)/0.01;
isi=(time(2:end)-time(1:end-1))*0.01;
isi2=[isi2,mean(isi)];

end

subplot 122
plot(isi2,'or','markersize',3,'markerfacecolor','r')
xlabel('index','fontsize',16)
ylabel('$\Omega_{j}$','fontsize',16, 'interpreter','latex')
%  set(gcf,'units','inches','position',[2 2 2.5 2.5])
% set(gca,'units','inches','position',[0.6 0.67 1.7 1.7])
set(gca,'xlim',[1,100],'ylim',[9,10.1],'fontsize',14,'xtick',[1 25 50 75 100])
set(gca,'units','inches','position',[3.7 0.75 1.6 1.6])
text(-3,9.65,'(f)','fontsize',14)
