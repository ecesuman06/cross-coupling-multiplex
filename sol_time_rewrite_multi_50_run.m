clear all;clc;close all;tic
 N=50;
I=0.4; b=0.1; e1=0.1;  v=2; lambda=10; theta=-0.25; e2=0; e3=0.1;
par = [ I b e1 v lambda theta N e2 e3];
tf = 600 ; ts = [ 0:0.01:tf ] ;
y0=randn(4*N,1); r=ones(1,2*N);

[t,data]=ode45(@(t,x1,par1,r1)sol_time_rewrite_multi_50(t,x1,par,r),ts,y0);
% [t,data]=ode45(@(t,x1,par1,r1)fhn_2(t,x1,par,r),ts,y0);

xx=data(:,1:2:4*N); yy=data(:,2:2:4*N);
xb=mean(xx,2);  yb=mean(yy,2);
xb=repmat(xb,1,2*N);  yb=repmat(yb,1,2*N);
sigma=round(sqrt((1/(2*N))*(sum((xb-xx).^2,2))),2);
plot(t,sigma)
hold on;
plot([200,200],[0,0.4],'k','linew',1.2)
plot([400,400],[0,0.4],'--r','linew',1.8)
%  axis([0,600,0,0.4])
xlabel('$t$','fontsize',16,'interpreter','latex')
ylabel('$e(t)$','fontsize',14,'interpreter','latex')
text(40,0.26,'$r^{(l)}_i = r$','fontsize',14,'interpreter','latex')
text(40,0.2,'$\kappa$ = 0','fontsize',14,'interpreter','latex')

text(240,0.26,'$r^{(1)}_2 \neq r$','fontsize',14,'interpreter','latex')
text(240,0.2,'$\kappa$ = 0','fontsize',14,'interpreter','latex')
text(440,0.26,'$r^{(1)}_2 \neq r$','fontsize',14,'interpreter','latex')
text(440,0.2,'$\kappa = -1$','fontsize',14,'interpreter','latex')
set(gcf,'units','inches','position',[2 2 4 2.5])
set(gca,'units','inches','position',[0.6 0.55 3.2 1.9])
set(gca,'ylim',[0,.4],'ytick',[0, 0.2,0.4],'fontsize',14,'linew',1.5)