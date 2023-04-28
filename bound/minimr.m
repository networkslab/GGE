function [A] = minimr(neighbors,n,x0,alpha,st,tol,Kmax)
% Randomized Incremental Subgradient Algorithm Iterations

cost = zeros(Kmax*n,1);
shift = zeros(st,1);

x = x0;
f = 0;
for i=1:n
    f = f + max((x(i)-x(neighbors{i})).^2);
end
mincost = f;
stopcount = 0;

for k=1:Kmax*n
    % Choose a node at random
    i = ceil(rand*n);
    % Determine which neighbor is most different from this node
    diffs = (x(i) - x(neighbors{i})).^2;
    largest = find(diffs == max(diffs));
    j = neighbors{i}(largest(ceil(rand*numel(largest))));
    % Form the subgradient at this node
    h = zeros(n,1);
    h(i) = 2*(x(i) - x(j));
    h(j) = -2*(x(i) - x(j));
    % Take a step
    x = x - alpha*h;
    % Project onto the feasible set
    x = x - mean(x);
    x = x./norm(x);
    % Compute cost function value at this point
    fold = f;
    f = 0;
    for i=1:n
        f = f + max((x(i) - x(neighbors{i})).^2);
    end
    % Check stopping criterion
    cost(k) = f;
    if (f < mincost)
        mincost = f;
        stopcount = 0;
    else
        stopcount = stopcount + 1;
    end
    if (stopcount > st)
        disp(['stop'])
        break;
    end

    if(k>st)
        shift=cost(k-st:k);
        if(mean(shift)<mincost+tol)
            disp(['stop2'])
            break;
        end
    end
end

%% Rescale solution to get voracity
A = 1 - f/(2*n);
% f

% plot(cost)
% %
% figure(1);
% plot(cost(1:k)), title('Cost vs iter');