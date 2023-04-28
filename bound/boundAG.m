function [A] = boundAG(n,alpha,iterations,st,tol,Kmax,topology)

% Number of iterations
it=iterations;
A1=zeros(it,1);
A=zeros(it,1);

%% Topology
for kk=1:it
    disp(['Iteration number: ' num2str(kk)]);
    G=topolog(topology,n);
    neighbors = cell(n,1);
    nneighbors = zeros(n,1);
    for i=1:n
        neighbors{i} = find(G(i,:));
        nneighbors(i) = numel(neighbors{i});
    end

    %% Iterations for several initializations
    for j=1:it
%         disp(['Initialization number: ' num2str(j)]);
        x0 = randn(n,1);
        x0 = x0-mean(x0);
        x0 = x0./norm(x0);

        A1(j) = minimr(neighbors,n,x0,alpha,st,tol,Kmax);
    end
    A(kk)=max(A1);
end