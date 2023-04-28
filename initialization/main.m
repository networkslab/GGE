% main.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% November 28, 2008

% Simulates Greedy Gossip with Eavesdropping (GGE) with three different
% initialization schemes of the algorithm. Check gossipINIT.m for details.

% %%%%%%%%%%%%%%%%%%%%%%%%% Simulation variables:%%%%%%%%%%%%%%%%%%%%%%%%%%
%1. rep = number of repetitions
%        (the simulation is repeated 'rep' times and then averaged)
%2. n = number of nodes
%3. Kmax= number of gossip iterations
%4. type = Choose one of the four types of initial field distributions for
%          function initialize()
%       1) GB (i.e. there are several Gaussian bumps in the field and
%          nodes sample this field)
%       2) Spike (i.e. all nodes have value zero except a random one with
%          value 1)
%       3) IID (i.e. initial values of the nodes are drawn form a N(0,1)
%          Gaussian distribution)
%       4) Slope (i.e. the field is linearly varying and nodes sample this
%          field)
%5. topology = choose a graph topology
%       'RGG' Random geometric graph
%       'Kn' Complete graph
%       'chain'
%       'ring'
%       'star'
%       'grid'
%       'chainstar' Chain of z nodes ending with a star of n-z+1 nodes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear all
close all
clc

rep =1;
n =200;
Kmax =5500; %number of gossip iterations
type='GB';
topology ='RGG';

%% Gossip iterations
errGGEinit1=0;
errGGEinit2=0;
errGGE=0;    %%GGE

RGc1=0; %average number of RG updates in GGE algorithm
GGEc1=0; %average number of GGE updates in GGE algorithm
RGc2=0; %average number of RG updates in GGE algorithm
GGEc2=0; %average number of GGE updates in GGE algorithm
for i=1:rep
    disp(['Repetition number: ' num2str(i)]);
    %     thresh = sqrt(2*log(n)/n); % transmission radius (connectivity threshold)
    [G,pos] = topolog(topology,n,1);
    x0 = initialize(type,n,pos);
    errGGEf=0;
    errGGEinit1f=0;
    errGGEinit2f=0;

    for ii=1:rep
        [errGGEinit12,errGGEinit22,errGGE2,RGcount1,GGEcount1,RGcount2,GGEcount2] = gossipINIT(n,Kmax,x0,G);
        for w = 1: Kmax
            errGGE1(w,1)= errGGE2(w);
            errGGEinit11(w,1)= errGGEinit12(w);
            errGGEinit21(w,1)= errGGEinit22(w);
        end
        errGGEf=errGGE1+errGGEf;
        errGGEinit1f=errGGEinit11+errGGEinit1f;
        errGGEinit2f=errGGEinit21+errGGEinit2f;
    end
    
    errGGEinit1f=errGGEinit1f/rep;
    errGGEinit2f=errGGEinit2f/rep;
    errGGEf=errGGEf/rep;

    errGGE=errGGEf+errGGE;
    errGGEinit1=errGGEinit1f+errGGEinit1;
    errGGEinit2=errGGEinit2f+errGGEinit2;
end

%Average error over a number of iterations
errGGEinit1=errGGEinit1/rep;
errGGEinit2=errGGEinit2/rep;
errGGE=errGGE/rep;

plots2