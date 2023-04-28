% main.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% November 28, 2008

% Simulates Greedy Gossip with Eavesdropping (GGE) with and without stale
% information. Probablities of link failures are input to GGEstale.m
%%
clear all;close all;clc

rep =1;
n =200;
Kmax =20000; %number of gossip iterations
type='GB';
topology ='RGG';

%% Gossip iterations
errRG=0; %%Randomized gossip
errGGE=0;    %%GGE
errGeo=0;    %%Geographic gossip
for i=1:rep
    disp(['Repetition number: ' num2str(i)]);
    thresh = sqrt(2*log(n)/n); % transmission radius (connectivity threshold)
    [G,pos] = topolog(topology,n,1);
    x0 = initialize(type,n,pos);
    errRGf=0;
    errGGEf=0;
    errGeof=0;
    for ii=1:rep
        [errRG1] = gossip(n,Kmax,x0,G);
        errRGf=errRG1+errRGf;
    end
    errRGf=errRGf/rep;
    errRG=errRGf+errRG;
 end
%Average error over a number of iterations
errRG=errRG/rep;

%% Gossip iterations
errGGEa=0; %%Randomized gossip
errGGEsta=0;    %%GGE
errGGEb=0; %%Randomized gossip
errGGEstb=0;    %%GGE
errGGEc=0; %%Randomized gossip
errGGEstc=0;    %%GGE

for i=1:rep
    disp(['Repetition number: ' num2str(i)]);
    thresh = sqrt(2*log(n)/n); % transmission radius (connectivity threshold)
    [G,pos] = topolog(topology,n,1);
    x0 = initialize(type,n,pos);
    errGGEfa=0;
    errGGEstfa=0;
    errGGEfb=0;
    errGGEstfb=0;
    errGGEfc=0;
    errGGEstfc=0;

    for ii=1:rep
        [errGGE2a,errGGEst2a] = GGEstale(n,Kmax,x0,G,0.5); %probability of link failure: 0.5
        [errGGE2b,errGGEst2b] = GGEstale(n,Kmax,x0,G,0.25); %probability of link failure: 0.25
        [errGGE2c,errGGEst2c] = GGEstale(n,Kmax,x0,G,0.1); %probability of link failure: 0.1

        for w = 1: Kmax
            errGGE1a(w,1)= errGGE2a(w);
            errGGEst1a(w,1)= errGGEst2a(w);
        end
        errGGEstfa=errGGEst1a+errGGEstfa;
        errGGEfa=errGGE1a+errGGEfa;

        for w = 1: Kmax
            errGGE1b(w,1)= errGGE2b(w);
            errGGEst1b(w,1)= errGGEst2b(w);
        end
        errGGEstfb=errGGEst1b+errGGEstfb;
        errGGEfb=errGGE1b+errGGEfb;

        for w = 1: Kmax
            errGGE1c(w,1)= errGGE2c(w);
            errGGEst1c(w,1)= errGGEst2c(w);
        end
        errGGEstfc=errGGEst1c+errGGEstfc;
        errGGEfc=errGGE1c+errGGEfc;
    end
    errGGEfa=errGGEfa/rep;
    errGGEstfa=errGGEstfa/rep;
    errGGEsta=errGGEstfa+errGGEsta;
    errGGEa=errGGEfa+errGGEa;
    
    errGGEfb=errGGEfb/rep;
    errGGEstfb=errGGEstfb/rep;
    errGGEstb=errGGEstfb+errGGEstb;
    errGGEb=errGGEfb+errGGEb;
    
    errGGEfc=errGGEfc/rep;
    errGGEstfc=errGGEstfc/rep;
    errGGEstc=errGGEstfc+errGGEstc;
    errGGEc=errGGEfc+errGGEc;
end

errGGEa=errGGEa/rep;
errGGEsta=errGGEsta/rep;
errGGEb=errGGEb/rep;
errGGEstb=errGGEstb/rep;
errGGEc=errGGEc/rep;
errGGEstc=errGGEstc/rep;

plots;