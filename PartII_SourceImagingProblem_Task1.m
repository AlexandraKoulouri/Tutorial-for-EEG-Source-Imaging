close all;clear;clc
%Tutorial: Forward and Inverse EEG
%Alexandra Koulouri - 29.11.2016

%Part II. Solve the forward problem 
%Add all the paths and necessery data
path1 = cd ("...");
addpath(genpath(path1))
%Load MRI data 
load ([path1 '\Geometry\MriSlice18.mat'])

figure('position',[25 650 350 350]);
imshow(MriSlice,[]) 
hold on;

%load Geometry which is the numerical discretization of the head with the corresponging compratments
load ([path1 '\Geometry\MRI_Geometry_final'])

%load lead field matrix
load ([path1 '\LeadField\LeadField']) %Returns L and L_el


%% Part II: Greate a dipole source
 NumSourceLoc = length(Geometry.SourceInd);
 %total number of source locations
 %%To insert your own values for the dipole source please uncomment the following 5 lines
 %Loc = input(['Select the locations of the dipole source which is a number between 1 and ',num2str(NumSourceLoc), ' ']);
 %magnitude = input(['Select the magnitude of the dipole source (e.g. 1 or 2) ']);
 %theta  =input('Select the orientation of the source between 1 and 365 degrees ');
 %Source_vector = fun_SingleDipoleSource(Geometry,Loc,theta,magnitude);
  
%Here I have selected a dipole source for you
 Loc = 4; magnitude = 1; theta = 0;
 mi = fun_SingleDipoleSource(Geometry,Loc,theta,magnitude); %Estimate the dipole vector
 %To plot/draw the location and orientation of the simulated dipole (i.e. an active neural column) uncomment the following line
 figure('position',[25 290 350 350]);
 PlotDipoleSource 
 
%%Estimate the potential values for the previous dipole source (Solve the forward problem as following)
%estimate the potentials at the electrodes
u_el = L_el* mi;

%plot potential at the electrodes 
%(these are the observation which we will use to solve the inverse problem i.e.
% the reconstruction of the sources based on the potentials on the scalp)
figure('position',[800 290 550 350]);
PlotPotElectr
 
   
% Delete the previous figures  (uncomment it)
%close all   
  
%%TASK 1
%%Solve the forward problem for a dipole which changes orientation
%Estimate the potential distrubtion for t1,t2,t3,t4 time steps where the orienation of the dipole changes according to 
Loc = 4; magnitude = 1;
theta_r = [0 100 190 300]; %orientation in degrees

%please complete the code to estimate the different dipole vectors mi and the corresponding 
%potential values u_el 
%– remember that only the orientation of the dipole changes 
for i = 1:length(theta_r)
     theta = theta_r(i);
     mi = fun_SingleDipoleSource(Geometry,Loc,theta,magnitude);  %missing code estimate the dipole vector
     u_el = L_el* mi;%missing code estimate the potential values at the electrodes
     figure; PlotPotElectr
end


