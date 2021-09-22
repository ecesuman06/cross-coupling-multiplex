clear all;clc;close all;tic
% % non-local regular network of FHN system
N=50; % number of nodes in individual layer, so total nodes are 2N
I=0.4; b=0.1;   e1=0.1; v=2; lambda=10; theta=-0.25; kappa=-1; epsilon_2=0.1; 
par = [ I b e1 v lambda theta N kappa epsilon_2];  % parameter set
tf = 100 ; % final time
ts = 0:0.01:tf ; % time span
y0=rand(4*N,1);  % initial condition
r=ones(1,2*N); % all nodea are kept similar, r=1
r(2)=2;   % detune node=> node-2 of layer-1 is detuned
AF = 2/1 ;    % the amplification factor r2/r
% r(2)=4.5; % detune node=> node-2 of layer-1 is detuned, 
% AF = 4.5/1 ;    % the amplification factor r2/r
% % % ----------------------solve integration----------------
for trans=1:12
    [t,data]=ode45(@(t1,x1,par1,r1)fhn_50_multi(t1,x1,par,r),ts,y0);
    y0=data(end,:);
end
xx=data(:,1:2:4*N); yy=data(:,2:2:4*N);

%%%% -------------syncronization manifold-------------------------%%%%%
figure(1)
set(gcf,'units','inches','position',[4 2 5.5 2.5])
subplot 121
plot(yy(:,1),yy(:,2),'.r');hold on    % intra-layer synchrony manifold
plot(yy(:,1),yy(:,3:2*N),'.k')          % intra-layer synchrony manifold
xlabel('y^{(1)}_1','fontsize',16)
ylabel('y^{(2)}_i','fontsize',16)
set(gca,'units','inches','position',[0.78 0.75 1.6 1.6])
set(gca,'xlim',[-2,4],'ylim',[-2,4],'fontsize',14,'linew',1.5)

subplot 122
plot(yy(:,2),yy(:,52),'.r');hold on    % inter-layer synchrony manifold
plot(yy(:,3:N),yy(:,53:2*N),'.k')       % inter-layer synchrony manifold
xlabel('y^{(1)}_i','fontsize',16)
ylabel('y^{(2)}_i','fontsize',16)
set(gca,'units','inches','position',[3.7 0.75 1.6 1.6])
set(gca,'xlim',[-2,4],'ylim',[-2,4],'fontsize',14,'linew',1.5)

%%%% ---------anticipated syncronization manifold-------------------------%%%%%
figure()
set(gcf,'units','inches','position',[4 2 5.5 2.5])
subplot 121
plot(yy(:,2),AF*yy(:,3:4),'.r')  % intra-layer synchrony manifold after anticipation by the amplification factor (AF)
xlabel('$y^{(1)}_2$','interpreter','latex','fontsize',20)
ylabel('$y^{(1)}_i$','interpreter','latex','fontsize',20)
set(gca,'units','inches','position',[0.78 0.75 1.6 1.6])
set(gca,'xlim',[-2,4],'ylim',[-2,4],'fontsize',14,'linew',1.5)

subplot 122
plot(yy(:,2),AF*yy(:,52:55),'.r'); % inter-layer synchrony manifold after anticipation by the amplification factor (AF)
xlabel('$y^{(1)}_i$','interpreter','latex','fontsize',20)
ylabel('$y^{(2)}_i$','interpreter','latex','fontsize',20)
set(gca,'units','inches','position',[3.5 0.75 1.6 1.6])
set(gca,'xlim',[-2,4],'ylim',[-2,4],'fontsize',14,'linew',1.5)

%%%%---------intra and inter layer syncronization manifold----------%%%%%
 figure()
plot(xx(:,1:50),xx(:,51:end))  % interlayer synchrony manifold, in x-direction
xlabel('x^{(1)}_i','fontsize',16)
ylabel('x^{(2)}_i','fontsize',16)
set(gcf,'units','inches','position',[2 2 2.5 2.5])
set(gca,'units','inches','position',[0.5 0.6 1.8 1.8])
set(gca,'xlim',[-1.5,1.5],'ylim',[-1.5,1.5],'fontsize',14,'linew',1.5)

%%%% -------------time series-------------------------%%%%%
figure
 subplot 221
plot(t, xx,'b')  % time series of all the oscillators
xlabel 'time'
ylabel 'x_i^{1,2}'
 subplot 222
plot(t, yy(:,3:100),'k') % time series of all the oscillators except detuned one
hold on
plot(t, yy(:,2),'r') % time series of the detuned oscillator
xlabel 'time'
ylabel 'y_i^{1,2}'
 subplot 223
plot(xx(:,3:100),yy(:,3:100),'k');  % phase portrait of all the oscillators except detuned one
hold on
plot(xx(:,2),yy(:,2),'r');  % phase portrait of the detuned oscillator
xlabel('x_i^{1,2}')
ylabel('y_i^{1,2}')