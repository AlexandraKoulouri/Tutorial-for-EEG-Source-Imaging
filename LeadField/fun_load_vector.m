function [Ix,Iy] = fun_load_vector(S_Ind,g,Element);
% This code was implemented by Alexandra Koulouri, 10.10.2014
% S_Ind: Insert the candidate source index
% The code is designed for linear basis functions (2D case only) 
% and dipole sources

% OutPut vector
% [Ix,Iy]    = gradient of basis function at Node S_Ind 
% This piece of code was written by Alexandra Koulouri, 10.11.2014

Ng       = max(size(g));                      %The number of nodes
NElement = max(size(Element));                   %The number of elements
                

%For linear basis function    
H = reshape([Element.Topology],3,NElement)';  %For Triangles
%mH = max(max(H));                             %Number of Nodes

Ix = zeros(Ng,1);
Iy = zeros(Ng,1);

%First find the elementh where g(S_Ind,:) is located;
%find the triangles which are close to the source candidate

Hind = find( H(:,1)==S_Ind | H(:,2)==S_Ind | H(:,3)==S_Ind);
     
for ii = 1:length(Hind);
        %Go through the neigboring elements
        ind = H(Hind(ii),:);               %Indices of the element
        gg  = g(ind,:); 
        I = DipoleCoeff_L(gg);
        Ix(ind) = Ix(ind) + I(1,:)';
        Iy(ind) = Iy(ind) + I(2,:)';
end
