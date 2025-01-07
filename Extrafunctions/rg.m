function [f]=rg(y,lambda)
% F=RG(Y,Lambda) returns the estimated (smoothed) values
% of a function V based on the 'noisy' uniformly sampled
% observations Y. The values of F are returned in the same
% uniform grid as Y. Lambda is the regularization parameter
% which here is the weight of curvature while the weight of
% the output error is n^(-1), where n is the number of data
% points.
% Lambda \approx 0 gives F = Y and Lambda >>> n^(-1) gives
% F \approx mean(Y) in all grid points.
% Jari Kaipio, University of Kuopio, Aug. 11, 1993
% For the functional to be minimized, see "Spline Models for
% Observational Data" by Grace Wahba, SIAM, 1990, which
% otherwise considers only cases with continuos index sets.
n=length(y);
H=[eye(n);toeplitz([-1 zeros(1,n-4)], ...
[-1 3 -3 1 zeros(1,n-4)])];
H = sparse(H);
W=diag([ones(n,1);lambda*ones(n-3,1)]);
W = sparse(W);
%keyboard
f=(H'*W*H)\(H'*W*[y;zeros(n-3,1)]);

% Rubric Graduation (Whittaker 1923)