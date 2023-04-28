% plots3.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

% Generate plot for initializeGGE.m

figure(1), clf;
% Generate "fake" variables for markers on the plot
f=1;
err1_fake=zeros(1,Kmax); %"fake" variables are for markers on the plot
err2_fake=zeros(1,Kmax);
err3_fake=zeros(1,Kmax);
err4_fake=zeros(1,Kmax);
for i=1:Kmax
    if (mod(i,2500)==0 || i==1000)
        err1_fake(i)=err(1,i);
        err2_fake(i)=err(2,i);
        err3_fake(i)=err(3,i);
        err4_fake(i)=err(4,i);
        fake(f)=i;
        f=f+1;
    end
end
semilogy(z,'g','LineWidth',1.8);
hold on;
semilogy([1:Kmax]',err2_fake,'m-+','LineWidth',1.8,'MarkerSize',10);
semilogy([1:Kmax]',err1_fake,'k-^','LineWidth',1.8);
semilogy([1:Kmax]',err3_fake,'b-d','LineWidth',1.8,'MarkerSize',7);
semilogy([1:Kmax]',err4_fake,'c-o','LineWidth',1.8,'MarkerSize',7);

semilogy(err(1,:),'k','LineWidth',1.8);
semilogy(err(2,:),'m','LineWidth',1.8);
semilogy(err(3,:),'b','LineWidth',1.8);
semilogy(err(4,:),'c','LineWidth',1.8);
% 
title(['n=',num2str(n),', ',topology,' topology'],'fontsize',12);
xlabel('Number of transmissions','fontsize',16);  ylabel('Relative error','fontsize',16);
h = legend('Bound','Linearly varying','Gaussian bumps', 'Uniform random','Spike',1);
set(h,'Interpreter','none','fontsize',12)
axis([-500 Kmax-2000 10^-4 10^0.1]);
set(gca,'fontsize',12);