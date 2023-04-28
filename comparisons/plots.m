% plots.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

% Generate plot for simulateGGE.m

figure(1), clf;
% Generate "fake" variables for markers on the plot
f=1;
errGGE_fake=zeros(1,Kmax); 
errRG_fake=zeros(1,Kmax);
errGeo_fake=zeros(1,Kmax);
for i=1:Kmax
    if (mod(i,round(Kmax/10))==0 || i==round(Kmax/20))
        errGGE_fake(i)=errGGE(i);
        errRG_fake(i)=errRG(i);
        errGeo_fake(i)=errGeo(i);
        fake(f)=i;
        f=f+1;
    end
end
semilogy([1:Kmax]',errRG_fake,'k-^','LineWidth',1.8);
hold on;
semilogy([1:Kmax]',errGeo_fake,'m-+','LineWidth',1.8,'MarkerSize',10);
semilogy([1:Kmax]',errGGE_fake,'b-o','LineWidth',1.8,'MarkerSize',7);
semilogy(errRG,'k','LineWidth',1.8);
semilogy(errGeo,'m-','LineWidth',1.8);
semilogy(errGGE,'b','LineWidth',1.8);

title([num2str(n),' nodes, ',topology,' topology, ',type,' field'],'fontsize',12);
xlabel('Number of transmissions','fontsize',16);  ylabel('Relative error','fontsize',16);
h = legend('Randomized Gossip','Geographic Gossip','GGE',1);
set(h,'Interpreter','none','fontsize',12)
axis([-500 Kmax-1000 10^-4 10^0.1]);
set(gca,'fontsize',12);

% % plot the topology:
% figure(3)
% plot(pos(:,1),pos(:,2),'o','MarkerFaceColor','b','MarkerSize',8.5)
% 
%     hold on
% for i=1:n
%     for j=1:n
%         if (G(i,j)==1)
%             xpos = linspace(pos(i,1),pos(j,1),100);
%             ypos = linspace(pos(i,2),pos(j,2),100);
%             plot(xpos,ypos,'-')
%         end
%     end
% end