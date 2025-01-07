close all;clear;clc
%Tutorial: Forward and Inverse EEG
%Alexandra Koulouri - 29.11.2016
%Task 3 ->estimate the condition number of the inverse problem
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
%%Estimate the condition number 
ConNum = cond( L_el'*L_el ) %Insert code here!!! 
