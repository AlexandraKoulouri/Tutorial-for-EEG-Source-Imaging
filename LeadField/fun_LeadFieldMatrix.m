function  [L,L_el]= fun_LeadFieldMatrix(Geometry);

load ('FEM_matrix.mat') %Finite element matrix

%candidate source locations
CanSInd =  Geometry.SourceInd;

Nsc = length(CanSInd);       %number of candidate source locations
Npnt = size(Geometry.pnt,1); %number of nodes


%% Estimate dipole vector b (load vector)
b = zeros(Npnt, 2*Nsc);

for i = 1:Nsc
    [Ix,Iy] = fun_load_vector(CanSInd(i),Geometry.pnt,Element);
    b(:,i) =Ix; b(:,i+Nsc) =Iy; 
end    
El =Geometry.ElInd; %Electrodes

%Estimate the LeadField Matrix for every node
A(El(1),:) = 0;
A(El(1),El(1)) = 1;

L = zeros(Npnt ,2*Nsc);
L = A\b;


%Keep only the rows which correspond to electrodes
 L_el = L(El(2:end),:);
