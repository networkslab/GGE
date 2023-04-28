function [errRG,errGGE,errGeo,RGcount,GGEcount] = gossip(n,Kmax,x0,G)

% gossip.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

% Simulates Greedy Gossip with Eavesdropping (GGE) as well as Randomized
% Gossip (RG), and Geographic Gossip (Geo). The
% input to the simulation is the number of nodes, number of gossip
% iterations, initial node values, graph topology matrix and node position
% matrix. The output is relative error which is defined as
% ||x(t)-x_ave||/||x(0)||, at every wireless transmission t for these three
% gossip algorithms (errGGE, errRG, errGeo).

% For initialization of GGE, nodes perform RG updates until they overhear 
% the values of all neighbor nodes. At each iteration the node that wakes up 
% chooses one of its neighbors at random from the set of neighbors whose 
% values are unknown. 

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
xgossip = x0;
xmax = x0;
xgeo = x0;
% Error in the average estimation
errRG = zeros(Kmax,1);
errRG(1) = norm(x0 - xbar)/norm(x0-xbar);

errGGE = zeros(Kmax,1);
errGGE(1) = norm(xmax - xbar)/norm(x0-xbar);

errGeo = zeros(Kmax,1);
errGeo(1) = norm(xgeo - xbar)/norm(x0-xbar);

% Number of transmissions
trgossip=1;
trmax=1;
trgeo=1;

% The sequence of random nodes that will wake up
source=ceil(n*rand(1,Kmax));
RGcount=0;
GGEcount=0;

% For geographic gossip
UG=sparse(G);
dist = graphallshortestpaths(UG,'directed',false);

% Algorithm for Regular gossip, Greedy gossip with eavesdropping,
% Geographic gossip
for k=2:Kmax
    s = source(k); %% the node that wakes up for this iteration

    % Regular gossip
    if (trgossip<Kmax)
        ti = ceil(nneighbors(s)*rand);
        t = neighbors{s}(ti);
        avg = (xgossip(s) + xgossip(t))/2;
        xgossip(s) = avg;
        xgossip(t) = avg;
        trgossip=trgossip+2;
        errRG(trgossip-1) = errRG(trgossip-2);
        errRG(trgossip) = norm(xgossip - xbar)/norm(x0-xbar);
    end

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

    if (trgeo<Kmax)
        t = ceil(n*rand(1,1));
        while (t==s)
            t = ceil(n*rand(1,1));
        end
        avg = (xgeo(s) + xgeo(t))/2;
        xgeo(s) = avg;
        xgeo(t) = avg;
        %distance=sqrt((pos(s,1)-pos(t,1))^2+(pos(s,2)-pos(t,2))^2);
        %dd=2*ceil(distance/thresh);
        distt=dist(s,t);
        dd=distt*2;
        for q=1:dd
            errGeo(trgeo+q) = errGeo(trgeo);
        end
        trgeo=trgeo+dd;
        errGeo(trgeo) = norm(xgeo - xbar)/norm(x0-xbar);

    end
end