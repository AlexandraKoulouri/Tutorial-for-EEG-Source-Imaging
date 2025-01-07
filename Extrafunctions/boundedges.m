function [e, BndInd] =boundedges(p,t)
%BOUNDEDGES Find boundary edges from triangular mesh
%   E=BOUNDEDGES(P,T)

%   Copyright (C) 2004-2012 Per-Olof Persson. See COPYRIGHT.TXT for details.

% Form all edges, non-duplicates are boundary edges
% This code has been modified to return also the Indices of the boundary
% Nodes (9.2013)

ElNum = size(t,1);

edges=[t(:,[1,2]);
       t(:,[1,3]);
       t(:,[2,3])];
node3=[t(:,3);t(:,2);t(:,1)];
edges=sort(edges,2);

%the commented part of the code I am not sure if it works properly, it
%seems that something is wrong.
% BndElInd = mod(ix,ElNum);
% ind = find(BndElInd == 0);
% BndElInd(ind) = 1;
% BndElInd = unique(BndElInd);

%find the edges which don't belong to two triangles
[foo,ix,jx]=unique(edges,'rows');
u=zeros(max(jx),1);
for i = 1:max(jx)
     SameRows = find(jx==i);
     if (length(SameRows)==1)
         u(i)=i;
     end
end
uu=foo(u>0,:);
BndInd = unique(uu(:));

vec=histc(jx,1:max(jx));
qx=find(vec==1);
e=edges(ix(qx),:);
node3=node3(ix(qx));

% Orientation
v1=p(e(:,2),:)-p(e(:,1),:);
v2=p(node3,:)-p(e(:,1),:);
ix=find(v1(:,1).*v2(:,2)-v1(:,2).*v2(:,1)>0);
e(ix,[1,2])=e(ix,[2,1]);