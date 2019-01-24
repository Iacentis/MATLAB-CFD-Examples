%% Fluid properties and B. C. inputs
% velocity of the upper wall
UWall = 1;
% density
rho   = 1;
%Reynolds Number
Re = 2.9e2; 
%% Geometric inputs (fixed so that a fair comparison can be made)
% number of nodes X direction.
nI = 25;
% number of nodes Y direction.
nJ = 25;
% number of nodes Z direction
nK = 25;
% length in X direction
xL = 1;
% length in Y direction
yL = 1;
% length in Z direction
zL = 1;
%% Dependant on above
% kinematic viscosity
nu = UWall * xL / Re; 