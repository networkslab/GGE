function [errGGE,RGcount,GGEcount] = gossipGGE(n,Kmax,x0,G)

% gossip.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

% Simulates Greedy Gossip with Eavesdropping (GGE). The
% input to the simulation is the number of nodes, number of gossip
% iterations, initial node values, graph topology matrix and node position
% matrix. The output is relative error which is defined as
% ||x(t)-x_ave||/||x(0)||, at every wireless transmission t. 

% n: number of nodes
% Kmax: number of gossip iterations
% x0: initial node values (nx1)
% G: RGG matrix (nxn)
% pos: position matrix (nx2)

% Identify neighborhoods
neighbors = cell(n,1);
nneighbors = zeros(n,1);

known = zeros(n,n);

for i=1:n
    neighbors{i} = find(G(i,:));
    nneighbors(i) = numel(neighbors{i});
end

% Original average
xbar = mean(x0)*ones(n,1);

% Initialization
xmax = x0;

% Error in the average estimation
errGGE = zeros(Kmax,1);
errGGE(1) = norm(xmax - xbar)/norm(x0-xbar);

% Number of transmissions
trmax=1;

% The sequence of random nodes that will wake up
source=ceil(n*rand(1,Kmax));
GGEcount=0;
RGcount=0;

% Algorithm for Regular gossip, Greedy gossip with eavesdropping,
% Geographic gossip
for k=2:Kmax
    s = source(k); %% the node that wakes up for this iteration

    % Greedy gossip with eavesdropping
    if (trmax<Kmax)
        yet = find((G(s,:)-known(s,:)));
        if (~isempty(yet))
            %display(['RG'])
            RGcount=RGcount+1;
            t = yet(ceil(rand*(length(yet))));
            avg = (xmax(s) + xmax(t))/2;
            xmax(s) = avg;
            xmax(t) = avg;
            trmax=trmax+2;
            errGGE(trmax-1) = errGGE(trmax-2);
            errGGE(trmax) = norm(xmax- xbar)/norm(x0-xbar);

            known(:,s) = ones(n,1).*G(:,s);
            known(:,t) = ones(n,1).*G(:,t);
        else
            %display(['GGE'])
            GGEcount=GGEcount+1;
            [val,mi] = max((xmax(s)-xmax(neighbors{s})).^2);
            m = neighbors{s}(mi);
            avg = (xmax(s) + xmax(m))/2;
            xmax(s) = avg;
            xmax(m) = avg;
            trmax=trmax+3;
            errGGE(trmax-2) = errGGE(trmax-3);
            errGGE(trmax-1) = errGGE(trmax-3);
            errGGE(trmax) = norm(xmax - xbar)/norm(x0-xbar);

            known(:,s) = ones(n,1).*G(:,s);
            known(:,m) = ones(n,1).*G(:,m);
        end
    end
end