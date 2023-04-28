% main_boundvsperf.m
%
% Deniz Ustebay
% McGill University
% deniz.ustebay@mail.mcgill.ca
% Last edited: September 1, 2009

clear all; close all; clc;
% load('C:\Users\dusteb\Documents\MATLAB\GGE journal\AG\m
% files\RGG\boundvs.mat')

n=200;
Kmax=20000;
alpha=0.05; tol=0.0051;
topology='RGG';
st=25*n;
disp(['number of nodes: ' num2str(n)]);
disp(['']);
A = boundAG(n,alpha,3,st,tol,Kmax,topology);

bound=max(A);
for i=1:Kmax
    z(i)=sqrt(bound^i);
end

% perf;
load('performance.mat')
plots3