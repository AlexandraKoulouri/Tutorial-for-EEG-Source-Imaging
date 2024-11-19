close all;clear;clc
%Tutorial: Forward and Inverse EEG
%Alexandra Koulouri - 29.11.2016
%Task 2
%Part II. Solve the forward problem 
%Add all the paths and necessery data
path1 = cd ("...");
addpath(genpath(path1))
%Load MRI data 
load ([path1 '\Geometry\MriSlice18.mat'])

%load Geometry which is the numerical discretization of the head with the corresponging compratments
load ([path1 '\Geometry\MRI_Geometry_final'])

%load lead field matrix
load ([path1 '\LeadField\LeadField']) %Returns L and L_el

%TASK 2 - Superposition
%Consider three dipole sources with the following characteristics
Loc = [4 153 71];    %three locations
theta = [0 100 50];  %three Orientations in degrees
magnitude = [1 1 1]; %magnitudes
%plot dipole sources
figure
PlotDipoleSource 
%Estimate separately each potential pattern and after that estimate the total potential distribution
u_i = zeros(size(L_el,1),3);
for i = 1:3
    mi = fun_SingleDipoleSource(Geometry,Loc(i),theta(i),magnitude(i));
    u_i(:,i) = L_el*mi; %COMPLETE THE CODE!!!
end 
u1 = sum(u_i,2); 
 
%Now Estimate the total dipole source and subsequently the pattern that this complex source creates
m = zeros(size(L_el,2),1); %set a zero vector
for i = 1:3
    m = m + fun_SingleDipoleSource(Geometry,Loc(i),theta(i),magnitude(i));
end
u2 = L_el*m;%COMPLETE THE CODE!!!

%Is this potential pattern equal to the one estimated as the sum of the individual patterns? 
%to do so compare the u_el1 with the u_el2 using norm().
er = 1/length(u2)*norm(u2-u1) %mean square error

