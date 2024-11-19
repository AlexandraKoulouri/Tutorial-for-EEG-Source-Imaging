close all;clear;clc
%Tutorial: Forward and Inverse EEG
%Alexandra Koulouri - 29.11.2016
%Task 4
%Part III. Solve the Inverse Problem using Tikhonov Regularization
%Add all the paths and necessery data
path1 = cd ("...");
addpath(genpath(path1))
%Load MRI data 
load ([path1 '\Geometry\MriSlice18.mat'])

%load Geometry which is the numerical discretization of the head with the corresponging compratments
load ([path1 '\Geometry\MRI_Geometry_final'])

%load lead field matrix
load ([path1 '\LeadField\LeadField']) %Returns L and L_el

%Simulate a dipole source and estimate the data
Loc = 154; magnitude = 1; theta = 0;
m = fun_SingleDipoleSource(Geometry,Loc,theta,magnitude);

%Potentials-Observations (Forward Result)
v = L_el*m;

%Estimate the Tikhonov regularization problem
%solve the problem for different lambda parameters and check the reconstructions
lambda = 0.01; %insert a value e.g. 0.0001
I = eye(size(L_el,2)); %Identity matrix


%Write the inverse solution(the transpose of a matrix is written with L_el')
m_hat = inv(L_el'*L_el+lambda*I)*L_el'*v;%insert the missing code


%plot the true dipole and estimated location with the highest estimated magnitudes (at least 90% of the maximum value)
figure
PlotFrwInvSol

