% main.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% November 28, 2008
%%
clear all;close all;clc;

rep =1;
n = 196;
Kmax = 71000; %number of gossip iterations
type='Slope';
topology = 'grid';

%% Gossip iterations
errRGf=0; %%Randomized gossip
errGGEf=0;    %%GGE
errGeof=0; 
errGGEMH1f=0;
errGGEMH2f=0;
for i=1:rep
    disp(['Repetition number: ' num2str(i)]);
    thresh = sqrt(2*log(n)/n); % transmission radius (connectivity threshold)
    [G,pos] = topolog(topology,n,1);
    x0 = initialize(type,n,pos);
 source=ceil(n*rand(1,Kmax));
        [errRG1,errGGE2,errGeo2,errGGEMH12,errGGEMH22] = gossipMH(n,Kmax,x0,G,source);
        errRGf=errRG1+errRGf;
        errGGE1(1: size(errRG1,1)-1,1)= errGGE2(1: size(errRG1,1)-1);     
        errGeo1(1: size(errRG1,1)-1,1)= errGeo2(1: size(errRG1,1)-1);    
        errGGEMH11(1: size(errRG1,1)-1,1)= errGGEMH12(1: size(errRG1,1)-1);
        errGGEMH21(1: size(errRG1,1)-1,1)= errGGEMH22(1: size(errRG1,1)-1);
        errGGEf=errGGE1+errGGEf;
        errGeof=errGeo1+errGeof;
        errGGEMH1f=errGGEMH11+errGGEMH1f;
        errGGEMH2f=errGGEMH21+errGGEMH2f;

end
%Average error over a number of iterations
errRG=errRGf/rep;
errGGE=errGGEf/rep;
errGeo=errGeof/rep;
errGGEMH1=errGGEMH1f/rep;
errGGEMH2=errGGEMH2f/rep;

plots