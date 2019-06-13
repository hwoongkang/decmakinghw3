%% The first script to be executed
% as always
close all; clear all;
% add all subfolders to the path
addpath(genpath(pwd))

%% Main executes the wrappers only
%%
% problem1
%%
tic
problem2
toc
plotTrajectory(mySys.trajectory.x,15)
%%
% problem3