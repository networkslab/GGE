% main.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

% Simulates Greedy Gossip with Eavesdropping (GGE) as well as Randomized
% Gossip (RG), and Geographic Gossip (Geo). The simultaion is repeated
% "rep" times and the result is the average of repetitions. This simulation
% also outputs a plot of relative error vs number of wireless transmissions
% for a comparison of these algorithms

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
clear all;close all;clc

rep = 2; % number of repetitions of the simulation
n = 200; % number of nodes in the network
Kmax = 20000; % number of gossip iterations
type='GB'; % type of initial field
topology = 'RGG'; % type of graph topology

if (strcmp(topology,'grid')&& round(sqrt(n))~=sqrt(n))
    disp('For grid topology, the number of nodes has to be a square number! Choose a new n.');
    break;
end

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
        [errRG1,errGGE2,errGeo2,RGcount,GGEcount] = gossip(n,Kmax,x0,G);
        errRGf=errRG1+errRGf;
        
        for w = 1: size(errRG1,1)-1
            errGeo1(w,1)= errGeo2(w);
            errGGE1(w,1)= errGGE2(w);
        end
        errGeof=errGeo1+errGeof;
        errGGEf=errGGE1+errGGEf;
    end
    errRGf=errRGf/rep;
    errGGEf=errGGEf/rep;
    errGeof=errGeof/rep;
    
    errGeo=errGeof+errGeo;
    errRG=errRGf+errRG;
    errGGE=errGGEf+errGGE;
end
%Average error over a number of iterations
errRG=errRG/rep;
errGGE=errGGE/rep;
errGeo=errGeo/rep;

plots