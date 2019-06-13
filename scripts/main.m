%% The first script to be executed
% as always
% close all; 
clear all;
% add all subfolders to the path
addpath(genpath(pwd))

%% Main executes the wrappers only
%%
% problem1
%%
tic
N=30;
boxSize = 30;
vel = 150;
dt = 0.01;
tf = 2;
filename = "convergenceCheckB";
sys= problem2(N,boxSize, vel, dt,tf,filename);
toc
%%
% problem3