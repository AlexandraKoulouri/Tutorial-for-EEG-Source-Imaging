close all;clear;clc
%Tutorial: Forward and Inverse EEG
%Alexandra Koulouri - 29.11.2016
%Solutions
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

%%Solve the inverse problem using Minimun Norm Estimate
m_hat = inv(L_el'*L_el)*L_el'*v; % a warning sign will appear in the command window
%
%
%%Estimate the condition number of  (L_el'*L_el)
ConNum = cond(L_el'*L_el) %Estimate the condition number (a well-condition number should have condition number close to 1)
%%it has poor conditioning so the solution cannot be accurate. Also, due to bad conditioning this system  is vulnerable to measurement noise.
%


%Estimate the Tikhonov regularization problem
%solve the problem for different lambda parameters and check the reconstructions
lambda = %insert a value 0.001
I = eye(size(L_el,2)); %Identity matrix
%Write the inverse solution(the transpose of a matrix is written with L_el')
m_hat = inv(L_el'*L_el+lambda*I)*L_el'*v;


%plot the true dipole and estimated location with the highest estimated magnitudes (at least 90% of the maximum value)
figure
PlotFrwInvSol

%
%figure
%plot(m,'r.');
%hold on
%plot(m_hat)


%Add noise and estimate the dipole location (uncomment the following line )
v_n = v+0.01*norm(v)*randn(length(v),1);
m_hat = inv(L_el'*L_el+lambda*I)*L_el'*v_n;

figure
PlotFrwInvSol