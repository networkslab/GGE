% main_AGvsnodes.m
%
% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

clear all;close all;clc;

N=[25 50 100 200];

Kmax=2;
alpha=[0.01 0.01 0.01 0.05];
topology='RGG';
tol=[0.01 0.05 0.05 0.1];

for i=1:size(N,2)
    st=25*N(i);
    disp(['number of nodes: ' num2str(N(i))]);
    disp(['']);
    A=boundAG(N(i),alpha(i),2,st,tol(i),Kmax,topology);
    save(strcat('An',num2str(N(i))),'A')
    clear A;
end

plots4;