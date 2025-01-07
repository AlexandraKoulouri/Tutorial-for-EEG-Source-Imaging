function [Cand_Source_Coordinates,Geometry ]= CandSourceLocations(Opt,Geometry) 
%%Save 2D mesh of an MRI slice: 
%H has the topology of the mesh
%Geometry.pnt: the coordinates of the discrete nodes 
%Geometry.tri: elements of the discrete geometry
%Geometry.scalp.pnt: coordinate of the nodes in the scalp
%Geometry.skull.pnt: coordinates of the nodes in the skull
%Geometry.Brain.pnt: coordinates of the nodes in the brain



%Find the indices of the nodes for the candidates source locations 
%OPTIONS FOR THE SOURCES

BInd = Geometry.Brain.Ind;

if (Opt ==1)
  %A. In Cortical Gray Matter area (superficial area)
  ii = find(BInd(:,2)==2);
    cc = mean(Geometry.pnt);
  dist = (Geometry.pnt(BInd(ii,1),1)- cc(1)).^2+(Geometry.pnt(BInd(ii,1),2)- cc(2)).^2;
  min_dist = min(dist);
  max_dist = max(dist);
  ij = find(dist>0.56*max_dist);
  SInd = BInd(ii(ij),1);
  
else
  % %B. Sources everywhere in the Gray Matterc
  ii = find(BInd(:,2)==2);
  SInd =BInd(ii,1);

  end
 
 Cand_Source_Coordinates = [Geometry.Pix.pnt(SInd,1),Geometry.Pix.pnt(SInd,2)];
 Geometry.SourceInd = SInd;

 
%