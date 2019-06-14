%% The first script to be executed
% as always
close all; 
clear all;
% add all subfolders to the path
addpath(genpath(pwd))

%% Main executes the wrappers only
%%
% problem1
%%
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
dt = 0.01;
% t_f
tf = 2.5;
% control gain
K = 10;
% current time as a filename
filename = dateParser();
prob2ans = problem2(N, boxSize, meanV, vel, K, dt, tf, filename);
plotTrajectory(prob2ans.trajC,vel*tf/5,filename)
toc
%%
% problem3