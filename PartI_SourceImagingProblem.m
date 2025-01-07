close all;clear;clc
%Tutorial: Forward and Inverse EEG
%Alexandra Koulouri - 29.11.2016

%Part I. Build the leadfield matrix L
%1.1 Use an MRI geometry and the corresponding conductivites
%1.2 Define the source space (canditate source locations) which define also the
%size of vector m
%1.3 Electrode locations


%Add all the paths
path1 = cd ("...");
addpath(genpath(path1))

%STEP 1
%Load MRI data 
load ([path1 '\Geometry\MriSlice18.mat'])

%plot the MRI slice
figure('position',[25 650 350 350]);
imshow(MriSlice,[]) 
hold on;

%STEP 2
%load Geometry which is the numerical discretization of the head with the corresponging compratments
load ([path1 '\Geometry\MRI_Geometry'])

%Geometry is a structure array which contrains all the information for the discretized geometry
%to display in the command window the structure fields of Geometry write:
fieldnames (Geometry)

%plot the discretized geometry
triplot(Geometry.tri',Geometry.Pix.pnt(:,1),Geometry.Pix.pnt(:,2))
title('Discrete Geometry - Triangulation')


%STEP 3
%Define electrodes around the scalp 
Nel = 31 %Select the number of Electrodes 
%this function places (almost equally spaced) electrodes around the scalps
[Sensors_Coordinates,Geometry] = fun_ElectrodeLocations(Geometry,Nel); 

%plot the MRI slice
figure('position',[400 650 350 350]);
imshow(MriSlice,[]) 
hold on;
% and plot the locations of the sensors/electrodes around the MRI geometry
plot(Sensors_Coordinates(:,1),Sensors_Coordinates(:,2),'o','markerfacecolor',[0.8 0.1 .1])
title('Sensor Locations')


%STEP 4
%Define canditate source locations (only in the cortical area)
%Options
%Opt = 1 (superficial locations only)
%Opt = 2 (the whole Gray matter)
Opt = 1;
[Cand_Source_Coordinates,Geometry]= CandSourceLocations(Opt,Geometry);
figure('position',[750 650 350 350]);
imshow(MriSlice,[])
hold on
plot(Cand_Source_Coordinates(:,1),Cand_Source_Coordinates(:,2),'xr');
title('Canditate Source Locations - GM')
%close all


%STEP 5
%Lead field matrix Estimation
%This function returns the full lead field L matrix which relates every single candidate source location 
%with potential values everywhere inside the domain
%also it returns L_el (lead-field matrix of the electrodes) which relates every single candidate source location 
%with potential values at the electrodes (This L_el will be used in the inverse problem)
[L,L_el]= fun_LeadFieldMatrix(Geometry);


%Estimate the size of L_el
[M,N] = size(L_el)%M-> number of electrods, N->number of sources
%Is it over-determined or under-determined matrix? 
