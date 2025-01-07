
function int = DipoleCoeff(g);

% Calculate the coefficients of the dipoles source in an element with g coordinates.
% for linear basis
% the dipole source is assumed as a simple dipole (i.e. dirac function)
% 
%  INPUT
%
% g = element points
% %
% OUTPUT
%
% int = coefficients of the dipole source [3x2] matrix

% int = [(jt)^{-1}L ] 
% This piece of code was written by Alexandra Koulouri, 10.11.2014
int = 0;

L=[-1 1 0;-1 0 1]; %Linear basis function:  phi1=1-n-u, phi2=n, ph3=u where (n,u)in [0,1]^2
                   %L->[\partial{phi1}{n},\partial{phi2}{n},\partial{phi3}{n};
                   %    \partial{phi1}{u}, \partial{phi2}{u},\partial{phi3}{u}]

Jt=L*g;            %Jacobian Transpose: J^T=L*g; (g->coordinates of the element's Nodes - size[3x2])
iJt=inv(Jt);
%dJt=abs(det(Jt));

G=iJt*L;
    

int = G;