figure(1), clf;
f=1;
errGGE_fake=zeros(1,Kmax); %"fake" variables are for markers on the plot
errGeo_fake=zeros(1,Kmax);
errRG_fake=zeros(1,Kmax);
errGGEMH1_fake=zeros(1,Kmax);
errGGEMH2_fake=zeros(1,Kmax);
for i=1:Kmax
    if (mod(i,10000)==0 || i==5000)
        errGGE_fake(i)=errGGE(i);
        errGeo_fake(i)=errGeo(i);
        errRG_fake(i)=errRG(i);
        errGGEMH1_fake(i)=errGGEMH1(i);
        errGGEMH2_fake(i)=errGGEMH2(i);
        fake(f)=i;
        f=f+1;
    end
end
semilogy([1:Kmax]',errRG_fake,'k-^','LineWidth',1.8);
hold on;
semilogy([1:Kmax]',errGeo_fake,'m-+','LineWidth',1.8,'MarkerSize',7);
semilogy([1:Kmax]',errGGE_fake,'b-o','LineWidth',1.8,'MarkerSize',7);
semilogy([1:Kmax]',errGGEMH1_fake,'r-s','LineWidth',1.8,'MarkerSize',7);
semilogy([1:Kmax]',errGGEMH2_fake,'g-d','LineWidth',1.8,'MarkerSize',7);


semilogy(errRG,'k','LineWidth',1.8);
hold on;
semilogy(errGGEMH1,'r','LineWidth',1.8);
semilogy(errGGEMH2,'g','LineWidth',1.8);
semilogy(errGGE,'b','LineWidth',1.8);
semilogy(errGeo,'m','LineWidth',1.8);

title([num2str(n),' nodes, ',topology,' topology, ',type,' field'],'fontsize',12);
xlabel('Number of transmissions','fontsize',16);  ylabel('Relative error','fontsize',16);
h = legend('Randomized Gossip','Geographic Gossip','GGE (1 hop)','GGE (2 hops )','GGE (3 hops)',3);
set(h,'Interpreter','none','fontsize',12)
 axis([-500 Kmax 10^-4.4 10^0.1]);
set(gca,'fontsize',12);