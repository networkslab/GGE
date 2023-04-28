% perf.m
%
% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

rep = 2; % number of repetitions of the simulation
types={'GB' 'Slope' 'IID'  'Spike' };
for j=1:4
    type=types(j);
    errGGE=0;
for i=1:rep
%     disp(['Repetition number: ' num2str(i)]);
    thresh = sqrt(2*log(n)/n); % transmission radius (connectivity threshold)
    [G,pos] = topolog(topology,n,1);
    x0 = initialize(type,n,pos);
    errGGEf=0;
    for ii=1:rep
        [errGGE1,GGEcount] = gossipGGE(n,Kmax,x0,G);
        errGGE2=errGGE1(1:Kmax);
        errGGEf=errGGE2+errGGEf;
    end
    errGGEf=errGGEf/rep;
    errGGE=errGGEf+errGGE;
end
%Average error over a number of iterations
errGGE=errGGE/rep;
err(j,1:size(errGGE,1))=errGGE(:)';
end

save('performance.mat')
