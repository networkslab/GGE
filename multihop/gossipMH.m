function [errRG,errGGE,errGeo,errMH1,errMH2] = gossipMH(n,Kmax,x0,G,source)

% resltin1.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% November 28, 2008

% n: number of nodes
% Kmax: number of gossip iterations
% x0: initial node values (nx1)
% G: RGG matrix (nxn)
% pos: position matrix (nx2)

% Identify neighborhoods
neighbors = cell(n,1);
nneighbors = zeros(n,1);

known = zeros(n,n);
knownMH1 = zeros(n,n);
knownMH2 = zeros(n,n);

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
xMH1= x0;
xMH2 = x0;
% Error in the average estimation
errRG = zeros(Kmax,1);
errRG(1) = norm(x0 - xbar)/norm(x0-xbar);

errGGE = zeros(Kmax,1);
errGGE(1) = norm(xmax - xbar)/norm(x0-xbar);

errGeo = zeros(Kmax,1);
errGeo(1) = norm(xmax - xbar)/norm(x0-xbar);

errMH1 = zeros(Kmax,1);
errMH1(1) = norm(xMH1 - xbar)/norm(x0-xbar);

errMH2 = zeros(Kmax,1);
errMH2(1) = norm(xMH2 - xbar)/norm(x0-xbar);

% Number of transmissions
trgossip=1;
trmax=1;
trgeo=1;
trMH1=1;
trMH2=1;

UG=sparse(G);
dist = graphallshortestpaths(UG,'directed',false);

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
    %Geographic gossip
    if (trgeo<Kmax)
        t = ceil(n*rand(1,1));
        while (t==s)
            t = ceil(n*rand(1,1));
        end
        avg = (xgeo(s) + xgeo(t))/2;
        xgeo(s) = avg;
        xgeo(t) = avg;
        distt=dist(s,t);
        dd=distt*2;
        for q=1:dd
            errGeo(trgeo+q) = errGeo(trgeo);
        end
        trgeo=trgeo+dd;
        errGeo(trgeo) = norm(xgeo - xbar)/norm(x0-xbar);
    end
    % Multihop GGE with 1 hop
    if( trMH1<Kmax)
        yet = find((G(s,:)-knownMH1(s,:)));
        if (~isempty(yet))
            t = yet(ceil(rand*(length(yet))));
            avg = (xMH1(s) + xMH1(t))/2;
            xMH1(s) = avg;
            xMH1(t) = avg;
            trMH1=trMH1+2;
            errMH1(trMH1-1) = errMH1(trMH1-2);
            errMH1(trMH1) = norm(xMH1- xbar)/norm(x0-xbar);

            knownMH1(:,s) = ones(n,1).*G(:,s);
            knownMH1(:,t) = ones(n,1).*G(:,t);
        else
            [val,mi] = max((xMH1(s)-xMH1(neighbors{s})).^2);
            m = neighbors{s}(mi);
            [val1,mi1] = max((xMH1(s)-xMH1(neighbors{m})).^2);
            m1 = neighbors{m}(mi1);
            if val1>val
                m = m1;
                avg = (xMH1(s) + xMH1(m))/2;
                xMH1(s) = avg;
                xMH1(m) = avg;
                trMH1=trMH1+4;
                errMH1(trMH1-3) = errMH1(trMH1-4);
                errMH1(trMH1-2) = errMH1(trMH1-4);
                errMH1(trMH1-1) = errMH1(trMH1-4);
                errMH1(trMH1) = norm(xMH1 - xbar)/norm(x0-xbar);
            else
                m = neighbors{s}(mi);
                avg = (xMH1(s) + xMH1(m))/2;
                xMH1(s) = avg;
                xMH1(m) = avg;
                trMH1=trMH1+3;
                errMH1(trMH1-2) = errMH1(trMH1-3);
                errMH1(trMH1-1) = errMH1(trMH1-3);
                errMH1(trMH1) = norm(xMH1 - xbar)/norm(x0-xbar);
            end
            knownMH1(:,s) = ones(n,1).*G(:,s);
            knownMH1(:,m) = ones(n,1).*G(:,m);

        end
    end
    %% Multihop GGE with 2 hops
    if(trMH2<Kmax)
        yet = find((G(s,:)-knownMH2(s,:)));
        if (~isempty(yet))
            t = yet(ceil(rand*(length(yet))));
            avg = (xMH2(s) + xMH2(t))/2;
            xMH2(s) = avg;
            xMH2(t) = avg;
            trMH2=trMH2+2;
            errMH2(trMH2-1) = errMH2(trMH2-2);
            errMH2(trMH2) = norm(xMH2- xbar)/norm(x0-xbar);

            knownMH2(:,s) = ones(n,1).*G(:,s);
            knownMH2(:,t) = ones(n,1).*G(:,t);
        else
            [val,mi] = max((xMH2(s)-xMH2(neighbors{s})).^2);
            m = neighbors{s}(mi);
            [val2,mi2] = max((xMH2(s)-xMH2(neighbors{m})).^2);
            m2 = neighbors{m}(mi2);
            [val3,mi3] = max((xMH2(s)-xMH2(neighbors{m2})).^2);
            m3 = neighbors{m2}(mi3);
            if val2>val && val3>val2
                m = m3;
                avg = (xMH2(s) + xMH2(m))/2;
                xMH2(s) = avg;
                xMH2(m) = avg;
                trMH2=trMH2+6;
                errMH2(trMH2-5) = errMH2(trMH2-6);
                errMH2(trMH2-4) = errMH2(trMH2-6);
                errMH2(trMH2-3) = errMH2(trMH2-6);
                errMH2(trMH2-2) = errMH2(trMH2-6);
                errMH2(trMH2-1) = errMH2(trMH2-6);
                errMH2(trMH2) = norm(xMH2 - xbar)/norm(x0-xbar);
            else if val2>val && val3<=val2
                    m = m2;
                    avg = (xMH2(s) + xMH2(m))/2;
                    xMH2(s) = avg;
                    xMH2(m) = avg;
                    trMH2=trMH2+4;
                    errMH2(trMH2-3) = errMH2(trMH2-4);
                    errMH2(trMH2-2) = errMH2(trMH2-4);
                    errMH2(trMH2-1) = errMH2(trMH2-4);
                    errMH2(trMH2) = norm(xMH2 - xbar)/norm(x0-xbar);

                else
                    m = neighbors{s}(mi);
                    avg = (xMH2(s) + xMH2(m))/2;
                    xMH2(s) = avg;
                    xMH2(m) = avg;
                    trMH2=trMH2+3;
                    errMH2(trMH2-2) = errMH2(trMH2-3);
                    errMH2(trMH2-1) = errMH2(trMH2-3);
                    errMH2(trMH2) = norm(xMH2 - xbar)/norm(x0-xbar);
                end
            end
            knownMH2(:,s) = ones(n,1).*G(:,s);
            knownMH2(:,m) = ones(n,1).*G(:,m);
        end
    end
end