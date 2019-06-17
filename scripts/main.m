%% The first script to be executed
% as always
close all; 
clear all;
% add all subfolders to the path
addpath(genpath(pwd))

%% Main executes the wrappers only
rng shuffle
r = rng(1225734035);
r.Seed
% 1225561811
% 1225734035
% 1225746304 best!
% 1227369215
%%
tic
problem1
fprintf("Problem 1 takes %.2f seconds\n",toc)
%% problem 2 settings
tic
% number of agents
N=30;

% region to generate agents
boxSize = 30;

% mean of the initial velocity
meanV = [10;10];

% velocity circle
vel = 30;

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
prob2ans = problem2(N, boxSize, meanV, vel, K, dt, tf,distLimit,flockGain,filename);
prob2check(prob2ans.trajA)
prob2check(prob2ans.trajB)
prob2check(prob2ans.trajC)
% plotTrajectory(prob2ans.trajC,dt,3,filename)
fprintf("Problem 2 takes %.2f seconds\n",toc)
%%
tic
history = problem3(0);
title("Optimal Policy: Deterministic")
history{end}.draw(0);
title("Utilities: Deterministic")
history2 = problem3(0.1);
title("Optimal Policy: With Faulty Moves")
history2{end}.draw(0);
title("Utilities: With Faulty Moves")
fprintf("Problem 3 takes %.2f seconds\n",toc)