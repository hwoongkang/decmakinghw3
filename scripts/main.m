%% The first script to be executed
% as always
close all; 
clear all;
% add all subfolders to the path
addpath(genpath(pwd))

%% Main executes the wrappers only
% rng shuffle
rng(1232123070)
r = rng;
r.Seed
% 1225561811
% 1232123070 %b가 좋음
% 1232110727 %C가 좋음
%%
tic
% problem1
fprintf("Problem 1 takes %.2f seconds\n",toc)
%% problem 2 settings
tic
% number of agents
N=30;

% region to generate agents
boxSize = 14;

% mean of the initial velocity
meanV = [10;10];

% velocity circle
vel = 20;

% simulation rate
dt = 0.005;

% t_f
tf = 7;

% control gain
K = 5;
% K=-3;

% collision avoidance
distLimit = 2;

% collision avoidance gain
flockGain = 300;
% current time as a filename
filename = dateParser();
%% problme 2 main
% prob2ans = problem2(N, boxSize, meanV, vel, K, dt, tf,distLimit,flockGain,filename);

% prob2plotter(prob2ans)
% plotTrajectory(prob2ans.trajC,dt,3,filename)
fprintf("Problem 2 takes %.2f seconds\n",toc)
%%
tic
prob3main
fprintf("Problem 3 takes %.2f seconds\n",toc)