function Source_vector = fun_SingleDipoleSource(Geometry,Loc,theta,magnitude);
%Inputs
%Locations of the dipole source
%magnitude of the source
%theta is the orientation of the source

%Returns the Source vector

%magnitude = 1;
DipoleInd = Loc;
NSourceLoc = length(Geometry.SourceInd);
Source_vector = zeros(2*NSourceLoc,1);

Source_vector(DipoleInd) = magnitude*cosd(theta);
Source_vector(DipoleInd+NSourceLoc) = magnitude*sind(theta);
