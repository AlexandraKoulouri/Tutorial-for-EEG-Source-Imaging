function [f,Ind] = InterpolateNearN(g,p,ind);
% 
% Assign each p(x,y) to the nearest node g(x,y)of the surface
% 
% Output:
%  f   ... Interpolated values for points defined in the L-by-2 matrix p
%  ind ... Index of the g values 
% Input:
%  g ... Nodal cordinates for H. N-by-2 matrix.
%  p ... Coordinates for the interpolation. L-by-2 matrix


% A. Koulouri 15.05.2013


%T = tsearchn(g,H,p); % find the triangle where point p_i lies (if NaN then the point is not in any triangle)
n = max(size(p));
%f = zeros(size(g));
Ind = zeros(n,1);
for ii=1:n
  %nearest neighbor interpolation
  dist = sqrt((p(ii,1)-g(ind,1)).^2+(p(ii,2)-g(ind,2)).^2);
  u = find(dist<=min(dist));
  Ind_g  = ind(u(1));
  Ind(ii)=Ind_g;
 
end

Ind = unique(Ind);
%f = g(Ind,:);
f=g(Ind,:);
% plot(g(:,1),g(:,2),'*r');
% hold on
% plot(f(:,1),f(:,2),'*');
% hold off