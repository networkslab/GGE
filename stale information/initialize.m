function [x0] = initialize(string,n,pos)

% initialize.m

% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% November 28, 2008

% Outputs the vector of node values when one of the following four initial
% field distributions is chosen:
% 
%       1) GB (i.e. there are several Gaussian bumps in the field and
%          nodes sample this field)
%       2) Spike (i.e. all nodes have value zero except a random one with
%          value 1)
%       3) IID (i.e. initial values of the nodes are drawn form a N(0,1) 
%          Gaussian distribution)
%       4) Slope (i.e. the field is linearly varying and nodes sample this
%          field)

% string = type of initialization
% n = number of nodes
% pos = position matrix of nodes [nx2]

m = 100; %grid size
% figure(7); clf;
[x,y] = meshgrid(0:(1/(m-1)):1, 0:(1/(m-1)):1);
% 1) Gaussian Bumps
Z1 = 18*exp(-(8*(x-0.3)).^2 - (8*(y-0.4)).^2) ...
    + 7*exp(-(6.035*(x-0.65)).^2 - (6.035*(y-0.3)).^2) ...
    + 8*exp(-(10.065*(x-0.19)).^2 - (10.065*(y-0.19)).^2) ...
    + 25*exp(-(6.025*(x-0.5)).^2 - (6.025*(y-0.75)).^2);

% 2) Spike
Z2 = 1.13*exp(-(50*(x-0.5)).^2 - (50*(y-0.5)).^2);

% 3) IID
for i=1:m
    for j=1:m
        Z3(i,j)=abs(randn(1));
    end
end

% 4) Slope
for i=1:m
    for j=1:m
        Z4(i,j)=((x(i,i))+(y(j,j)))/(2);
    end
end
%% Which initialization?
if strcmp(string,'GB')
    z=Z1;
%     surf(x,y,Z1);
else if strcmp(string,'Spike')
        z=Z2;
%         surf(x,y,Z2);
    else if strcmp(string,'IID')
            z=Z3;
%             surf(x,y,Z3);
        else if strcmp(string,'Slope')
                z=Z4;
%           surf(x,y,Z4);
            end
        end
    end
end
%% Initial values
for j=1:n
    [hvalue,hmin] = min(abs(x(1,:)-ones(1,m)*pos(j,1)));
    [gvalue,gmin] = min(abs(y(:,1)-ones(m,1)*pos(j,2)));
    x0(j) = z(hmin,gmin);
end
x0=x0';