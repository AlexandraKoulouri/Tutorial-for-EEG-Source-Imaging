function [Sensors_Coordinates,Geometry] = fun_ElectrodeLocations(Geometry,Nel)
%nodes pnt of the mri mesh
%elements tri of the mri mesh



ExtraFunPath = cd; ExtraFunPath =[ExtraFunPath, '\Extrafunctions'];
%addpath(ExtraFunPath)


%Find Boundary Edges of the 2D mesh(head boundary);
[e, BndHInd] =boundedges(Geometry.pnt,Geometry.tri');

%Find the boundary Edges of the Skull/Scalp
[e,BndSInd] =boundedges(Geometry.pnt,cat(2,Geometry.skull.tri,Geometry.Brain.tri)');

%Find Boundary Edges of the Brain
[e,BndBInd] =boundedges(Geometry.pnt,Geometry.Brain.tri');

%Find Indices of the Electrodes
%Nel = 33;
BndHInd = Geometry.scalp.BInd; %Indices of the boundary scalp nodes
[ElInd] = fun_loc_electrodes(Nel, Geometry.pnt(BndHInd,:),Geometry.pnt);

Sensors_Coordinates = [Geometry.Pix.pnt(ElInd,1),Geometry.Pix.pnt(ElInd,2)];

%Locations of the sensors
Geometry.ElInd = ElInd;

function  [ElInd] = fun_loc_electrodes(Nel, scalp,g)
%Insert the scalp curve and the Number of sensors Nel

%Output: pp sensors locations

ExtraFunPath = cd; ExtraFunPath =[ExtraFunPath, '\Extrafunctions'];

pp = [];
k = convhull(scalp(:,1),scalp(:,2));
x=rg(scalp(k,1),1);
y=rg(scalp(k,2),1);
[xi,yi] = Curvefitting(x,y,0.3);

% ScalpLength= sum(sqrt(diff(scalp(1,:)).^2+diff(scalp(2,:)).^2));
% El_dis = ScalpLength/((Nel+1));
%  
ScalpLength= sum(sqrt(diff(xi).^2+diff(yi).^2));
El_dis = ScalpLength/((Nel+1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cx = mean(xi);cy = mean(yi);
Angle = mod(360*(atan2(yi-cy,xi-cx)/(2*pi)), 360);
Angle = abs(Angle-90);
Ind = find(Angle == min(Angle));
GroundP = [xi(Ind(1)),yi(Ind(1))];
IG = Ind;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Place equally spaced sensors around the scalp

p = GroundP;
pp(1,:)=p;
%rearrange the points 
ReArrangeInd = cat(2,[IG(1):max(size(xi))',1:IG(1)-1]);
xi = xi(ReArrangeInd);
yi = yi(ReArrangeInd);
tempp = p;

for ii = 1:Nel
     %check the distance between the points and current pii (find the point
     %with distance El_dis 
     dist = sqrt((xi-tempp(1,1)).^2+ (yi-tempp(1,2)).^2)';
     I = find(dist>=El_dis-0.3);
     
     %last point
     if isempty(I)
         I = length(dist);
       %  break;
     end        
     tempp=[xi(min(I)),yi(min(I))];
     p(ii+1,:)=tempp;
     pii = [tempp(1,1),tempp(1,2)];
     %find new point
     pp(ii+1,:) = pii; 
     %remove indices 
     ScalpInd = [min(I):max(size(xi))];
     xi = xi(ScalpInd);
     yi = yi(ScalpInd);
    % plot(p(:,1),p(:,2))
end 

%find the closest grid points
for i = 1:size(pp,1)

  dist1 = (pp(i,1)-g(:,1)).^2+(pp(i,2)-g(:,2)).^2;
  ElInd(i) = find(dist1== min(dist1));


end




