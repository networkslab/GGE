% plots2.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

% Generate plot for initializeGGE.m

figure(1), clf;
% Generate "fake" variables for markers on the plot
f=1;
errGGE_fake=zeros(1,Kmax); 
errGGEinit1_fake=zeros(1,Kmax);
errGGEinit2_fake=zeros(1,Kmax);
for i=1:Kmax
    if (mod(i,1000)==0 || i==500)
        errGGE_fake(i)=errGGE(i);
        errGGEinit1_fake(i)=errGGEinit1(i);
        errGGEinit2_fake(i)=errGGEinit2(i);
        fake(f)=i;
        f=f+1;
    end
end
semilogy([1:Kmax]',errGGEinit2_fake,'m-','LineWidth',1.8,'MarkerSize',7);
hold on;
semilogy([1:Kmax]',errGGEinit1_fake,'k-^','LineWidth',1.8);
semilogy([1:Kmax]',errGGE_fake,'b-o','LineWidth',1.8,'MarkerSize',7);
semilogy(errGGEinit1,'k-','LineWidth',1.8);
semilogy(errGGEinit2,'m-','LineWidth',1.8);
semilogy(errGGE,'b','LineWidth',1.8);

title(['n=',num2str(n),', ',topology,' topology'],'fontsize',12);
xlabel('Number of transmissions','fontsize',16);  ylabel('Relative error','fontsize',16);
h = legend('GGE with broadcast','GGE with initialization','GGE ideal',1);
set(h,'Interpreter','none','fontsize',12)
axis([-100 5200 10^-2*2 10^0.1]);
set(gca,'fontsize',12);


% figure(2)
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
