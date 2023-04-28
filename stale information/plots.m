figure(1), clf;
f=1;
errGGEa_fake=zeros(1,Kmax); %"fake" variables are for markers on the plot
errRG_fake=zeros(1,Kmax); %"fake" variables are for markers on the plot
errGGEsta_fake=zeros(1,Kmax);
errGGEb_fake=zeros(1,Kmax); %"fake" variables are for markers on the plot
errGGEstb_fake=zeros(1,Kmax);
errGGEc_fake=zeros(1,Kmax); %"fake" variables are for markers on the plot
errGGEstc_fake=zeros(1,Kmax);
for i=1:Kmax
    if (mod(i,2000)==0 || i==1000)
        errRG_fake(i)=errRG(i);
        errGGEa_fake(i)=errGGEa(i);
        errGGEsta_fake(i)=errGGEsta(i);
                errGGEb_fake(i)=errGGEb(i);
        errGGEstb_fake(i)=errGGEstb(i);
                errGGEc_fake(i)=errGGEc(i);
        errGGEstc_fake(i)=errGGEstc(i);
        fake(f)=i;
        f=f+1;
    end
end
semilogy([1:Kmax]',errRG_fake,'k-s','LineWidth',1.8,'MarkerSize',7);
hold on;
semilogy([1:Kmax]',errGGEsta_fake,'g-^','LineWidth',1.8);
semilogy([1:Kmax]',errGGEstb_fake,'r-d','LineWidth',1.8);
semilogy([1:Kmax]',errGGEstc_fake,'m-+','LineWidth',1.8);
semilogy([1:Kmax]',errGGEa_fake,'b-o','LineWidth',1.8,'MarkerSize',7);

semilogy(errGGEsta,'g','LineWidth',1.8);
semilogy(errGGEstb,'r','LineWidth',1.8);
semilogy(errGGEstc,'m','LineWidth',1.8);
semilogy(errGGEa,'b','LineWidth',1.8);
semilogy(errRG,'k','LineWidth',1.8);

title(['n=',num2str(n),', ',topology,' topology'],'fontsize',12);
xlabel('Number of transmissions','fontsize',16);  ylabel('Relative error','fontsize',16);
h = legend('RG','p=0.5','p=0.25','p=0.1','p=0',1);
set(h,'Interpreter','none','fontsize',12)
axis([-500 Kmax+300 10^-4 10^0.1]);
set(gca,'fontsize',12);

hold on;
