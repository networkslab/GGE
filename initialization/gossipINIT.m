function [errGGEinit,errGGEinit2,errGGE,RGcount,GGEcount,RGcount2,GGEcount2] = gossipINIT(n,Kmax,x0,G)

% resltin1.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% November 28, 2008

% Simulates Greedy Gossip with Eavesdropping (GGE) as well as Randomized
% Gossip (RG), and Geographic Gossip (Geo). The
% input to the simulation is the number of nodes, number of gossip
% iterations, initial node values, graph topology matrix and node position
% matrix. The output is relative error which is defined as
% ||x(t)-x_ave||/||x(0)||, at every wireless transmission t for these three
% gossip algorithms (errGGE, errRG, errGeo).

% Investigates the process of learning the values of neighboring nodes
% which is necesarry to perform GGE updates later on.

% Ideal: each node clairvoyantly knows its neighbors' values

% Initialization: nodes perform RG updates until they overhear the values
% of all neighbor nodes. At each iteration the node that wakes up chooses
% one of its neighbors at random from the set of neighbors whose values
% are unknown.

% Broadcast: each node broadcasts its value once to initialize the values
% at all neighbors


% n: number of nodes
% Kmax: number of gossip iterations
% x0: initial node values (nx1)
% G: RGG matrix (nxn)
% pos: position matrix (nx2)

% Identify neighborhoods
neighbors = cell(n,1);
nneighbors = zeros(n,1);

known = zeros(n,n);
known2 = zeros(n,n);
for i=1:n
    neighbors{i} = find(G(i,:));
    nneighbors(i) = numel(neighbors{i});
end

% Original average
xbar = mean(x0)*ones(n,1);

% Initialization
xGGEinit = x0;
xGGEinit2 = x0;
xmax = x0;

% Error in the average estimation
errGGEinit = zeros(Kmax,1);
errGGEinit(1) = norm(x0 - xbar)/norm(x0 - xbar);

errGGEinit2 = zeros(Kmax,1);
errGGEinit2(1) = norm(x0 - xbar)/norm(x0 - xbar);

errGGE = zeros(Kmax,1);
errGGE(1) = norm(xmax - xbar)/norm(x0 - xbar);
% Number of transmissions
trGGEinit=1;
trGGEinit2=1;
trmax=1;

% The sequence of random nodes that will wake up
source=ceil(n*rand(1,Kmax));
RGcount=0;
GGEcount=0;
RGcount2=0;
GGEcount2=0;
flag=1;

for k=2:Kmax
    s = source(k); %% the node that wakes up for this iteration
    %  Ideal
    if (trmax<Kmax)
        [val,mi] = max((xmax(s)-xmax(neighbors{s})).^2);
        m = neighbors{s}(mi);
        avg = (xmax(s) + xmax(m))/2;
        xmax(s) = avg;
        xmax(m) = avg;
        trmax=trmax+3;
        errGGE(trmax-2) = errGGE(trmax-3);
        errGGE(trmax-1) = errGGE(trmax-3);
        errGGE(trmax) = norm(xmax - xbar)/norm(x0 - xbar);
    end

    % Initialization
    if (trGGEinit<Kmax)
        yet = find((G(s,:)-known(s,:)));
        if (~isempty(yet))
            %display(['RG'])
            RGcount=RGcount+1;
            t = yet(ceil(rand*(length(yet))));
            avg = (xGGEinit(s) + xGGEinit(t))/2;
            xGGEinit(s) = avg;
            xGGEinit(t) = avg;
            trGGEinit=trGGEinit+2;
            errGGEinit(trGGEinit-1) = errGGEinit(trGGEinit-2);
            errGGEinit(trGGEinit) = norm(xGGEinit- xbar)/norm(x0 - xbar);

            known(:,s) = ones(n,1).*G(:,s);
            known(:,t) = ones(n,1).*G(:,t);
        else
            %display(['GGE'])
            GGEcount=GGEcount+1;
            [val,mi] = max((xGGEinit(s)-xGGEinit(neighbors{s})).^2);
            m = neighbors{s}(mi);
            avg = (xGGEinit(s) + xGGEinit(m))/2;
            xGGEinit(s) = avg;
            xGGEinit(m) = avg;
            trGGEinit=trGGEinit+3;
            errGGEinit(trGGEinit-2) = errGGEinit(trGGEinit-3);
            errGGEinit(trGGEinit-1) = errGGEinit(trGGEinit-3);
            errGGEinit(trGGEinit) = norm(xGGEinit - xbar)/norm(x0 - xbar);
            known(:,s) = ones(n,1).*G(:,s);
            known(:,m) = ones(n,1).*G(:,m);
        end
    end

    % Broadcast
    if (trGGEinit2<Kmax)
        if (flag==1)
            flag=0;
            trGGEinit2=trGGEinit2+n;
            errGGEinit2(2:trGGEinit2) = errGGEinit2(1);
        end
        if (flag==0)
            GGEcount2=GGEcount2+1;
            [val,mi] = max((xGGEinit2(s)-xGGEinit2(neighbors{s})).^2);
            m = neighbors{s}(mi);
            avg = (xGGEinit2(s) + xGGEinit2(m))/2;
            xGGEinit2(s) = avg;
            xGGEinit2(m) = avg;
            trGGEinit2=trGGEinit2+3;
            errGGEinit2(trGGEinit2-2) = errGGEinit2(trGGEinit2-3);
            errGGEinit2(trGGEinit2-1) = errGGEinit2(trGGEinit2-3);
            errGGEinit2(trGGEinit2) = norm(xGGEinit2 - xbar)/norm(x0 - xbar);

        end
    end
end