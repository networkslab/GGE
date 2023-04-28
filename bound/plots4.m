N=[25 50 100 200];
topology='RGG';
q=size(N,2);

for ii=1:q
    load(strcat('An',num2str(N(ii))));
    disp(['  ' num2str(N(ii))])
    meanA(ii,:) = mean(A);
    minA(ii,:) =min(A);
    maxA(ii,:) =max(A);
end

figure(1), clf;
subplot(2,1,1); 
errorbar(N(1:q),1-meanA,(-minA+meanA),(maxA-meanA),'-o','LineWidth',1.8)
errorbarlogy; 
%   axis([0 525 10^-5 10^-1]);
% set(gca,'fontsize',12,'YTick',[10^-5 10^-3 10^-1]);
%  semilogy(N(1:ii),(1-meanA),'-o','LineWidth',1.8)
%    ylim([0.0001 0.07 ]);
% hold on;
%  plot(N(1:ii),minA,'m-o','LineWidth',1.8)
xlabel('Number of nodes (n)','fontsize',14);  ylabel('[1-A(G)]','fontsize',14);
% set(gca,'fontsize',12);

 xlim([0 525]);

meanTave=mean(kk)./N;
maxTave=max(kk)./N;
minTave=min(kk)./N;

meanTavebound=zeros(q,1);
minTavebound=zeros(q,1);
maxTavebound=zeros(q,1);    
for i=1:q
    meanTavebound(i) =3*log(1/0.01)/(N(i)*log(1/meanA(i)));
    minTavebound(i) =3*log(1/0.01)/(N(i)*log(1/minA(i)));
    maxTavebound(i) =3*log(1/0.01)/(N(i)*log(1/maxA(i)));
end

zg=1.5*N./log(N);
zg2=6*sqrt(N);
% title([topology,' topology'],'fontsize',12);
subplot(2,1,2)
errorbar(N,meanTavebound,meanTavebound-minTavebound,maxTavebound-meanTavebound,'b-','LineWidth',1.8)
hold on;
plot(N,zg,'k--','LineWidth',1.8)
errorbar(N,meanTave,meanTave-minTave,maxTave-meanTave,'m-o','LineWidth',1.8)

 xlabel('Number of nodes (n)','fontsize',14);  ylabel('T_{ave}(0.01)/n','fontsize',14);
set(gca,'fontsize',12);
  axis([0 525 10 max(meanTave)+65]);
h = legend('Tave/n (bound)','1.5*n/log(n)','Tave/n (actual)',2);
 set(h,'Interpreter','none','fontsize',12)