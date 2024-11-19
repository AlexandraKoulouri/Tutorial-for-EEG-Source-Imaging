close all;clear;clc
%Tutorial: Forward and Inverse EEG
%Alexandra Koulouri - 29.11.2016
%Task 5 Noise
%Part III. Solve the Inverse Problem 
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

%Add noise and estimate the dipole location (uncomment the following line )
v_n = v+0.001*norm(v)*randn(length(v),1);

%Solve the minimization problem 
%Pick lambda parameter and see the estimated result

lambda = 0.01%insert (run the code for the same lambda parameters as previously)
m_hat = inv(L_el'*L_el+lambda*I)*L_el'*v;

figure
PlotFrwInvSol