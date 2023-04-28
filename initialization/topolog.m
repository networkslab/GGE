function [G,pos] = topolog(string,n,z)

% topology.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% November 28, 2008

% Outputs the graph adjacency matrix "G" and matrix of node positions "pos"
% for the following topologies:
%       'RGG' Random geometric graph
%       'Kn' Complete graph
%       'Chain'
%       'Ring'
%       'Star'
%       'Grid'
%       'ChainStar' Chain of z nodes ending with a star of n-z+1 nodes

%  n = number of nodes
%  z = lenght of the chain in chainstar topology
disconnect=0;

%% RGG
if strcmp(string,'RGG')
    pos = rand(n,2); % position matrix (nodes are randomly distributed on unit square)
    dist = sqrt((repmat(pos(:,1),1,n)-repmat(pos(:,1)',n,1)).^2 + ...
        (repmat(pos(:,2),1,n) - repmat(pos(:,2)',n,1)).^2); % matrix of distance between each node
    thresh = sqrt(2*log(n)/n); % transmission radius ( connectivity threshold as in randomized gossip)
    G = double(dist <= thresh) - eye(n); % RGG connectivity matrix
    if size(nonzeros(sum(G))',2)~=size(sum(G),2)
        disconnect=1;
    end
    while (disconnect==1)
        pos = rand(n,2); % position matrix (nodes are randomly distributed on unit square)
        dist = sqrt((repmat(pos(:,1),1,n)-repmat(pos(:,1)',n,1)).^2 + ...
            (repmat(pos(:,2),1,n) - repmat(pos(:,2)',n,1)).^2); % matrix of distance between each node
        thresh = sqrt(2*log(n)/n); % transmission radius ( connectivity threshold as in randomized gossip)
        G = double(dist <= thresh) - eye(n); % RGG connectivity matrix
        if size(nonzeros(sum(G))',2)==size(sum(G),2)
            disconnect=0;
        end
    end
end
%% Kn: Complete Graph
if strcmp(string,'Kn')
    pos = rand(n,2);
    G = ones(n,n) - eye(n); % Complete Graph (K_n) connectivity matrix
end
%% Chain
if strcmp(string,'chain')
    G=zeros(n,n);
    G(1,2)=1;
    G(n,n-1)=1;
    for i=2:(n-1)
        G(i,i+1)=1;
        G(i,i-1)=1;
    end
    pos(:,1)=linspace(0,1,n);
    pos(:,2)=0.5*ones(1,n);
end
%% Ring
if strcmp(string,'ring')
    G=zeros(n,n);
    G(1,2)=1;
    G(n,n-1)=1;
    for i=2:(n-1)
        G(i,i+1)=1;
        G(i,i-1)=1;
    end
    pos(:,1)=linspace(0,1,n);
    pos(:,2)=0.5*ones(1,n);
end
%% Star
if strcmp(string,'star')
    pos = rand(n,2);
    G = zeros(n,n);
    for h=2:n
        G(1,h) = 1;
        G(h,1) = 1;
    end
end
%% Grid

if strcmp(string,'grid')
    m=sqrt(n);
for i=1:n
    if mod(i,m)==0
        pos(i,1)=1;
        pos(i,2)=(floor(i/m)-1)/(m-1);
    else
        pos(i,1)=(mod(i,m)-1)/(m-1);
        pos(i,2)=floor(i/m)/(m-1);
    end
end
    G=zeros(n,n);
    G(1,sqrt(n)+1)=1;
    for i=2:(sqrt(n)-1)
        G(i,i-1)=1;
        G(i-1,i)=1;
        G(i,i+1)=1;
        G(i+1,i)=1;
    end
    for i=(n-sqrt(n)+2):n-1
        G(i,i-1)=1;
        G(i-1,i)=1;
        G(i,i+1)=1;
        G(i+1,i)=1;
    end
    for i=sqrt(n)+1:n-sqrt(n)
        if( mod(i,sqrt(n))==0)
            G(i,i-sqrt(n))=1;
            G(i-sqrt(n),i)=1;
            G(i,i+sqrt(n))=1;
            G(i+sqrt(n),i)=1;
        end
        if( mod(i,sqrt(n))==1)
            G(i,i-sqrt(n))=1;
            G(i-sqrt(n),i)=1;
            G(i,i+sqrt(n))=1;
            G(i+sqrt(n),i)=1;
        end
    end
    for i=(sqrt(n)+2):(n-sqrt(n)-1)
        if( mod(i,sqrt(n))~=0 && mod(i,sqrt(n))~=1)
            G(i,i-1)=1;
            G(i-1,i)=1;
            G(i,i+1)=1;
            G(i+1,i)=1;
            G(i,i-sqrt(n))=1;
            G(i-sqrt(n),i)=1;
            G(i,i+sqrt(n))=1;
            G(i+sqrt(n),i)=1;
        end
    end
end
%% Chainstar
if strcmp(string,'chainstar')
    G=zeros(n,n);
    %     z = ceil(n*rand(1,1));
    %     while isempty(z)
    %         z = ceil(n*rand(1,1));
    %     end;
    G(1,2)=1;
    G(z,z-1)=1;
    for i=2:(z-1)
        G(i,i+1)=1;
        G(i,i-1)=1;
    end
    for h=z+1:n
        if(h~=z)
            G(z,h) = 1;
            G(h,z) = 1;
        end
    end
    pos = rand(n,2);
end