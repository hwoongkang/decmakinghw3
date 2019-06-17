%% The first script to be executed
% as always
close all; 
clear all;
% add all subfolders to the path
addpath(genpath(pwd))

%% Main executes the wrappers only
%%
% problem1
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
tf = 2.5;

% control gain
K = 10;

% collision avoidance
distLimit = 2;

% collision avoidance gain
flockGain = 300;
% current time as a filename
filename = dateParser();
%% problme 2 main
prob2ans = problem2(N, boxSize, meanV, vel, K, dt, tf,distLimit,flockGain,filename);
plotTrajectory(prob2ans.trajC,dt,filename)
toc
%%
problem3