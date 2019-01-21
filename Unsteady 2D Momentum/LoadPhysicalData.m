%% Fluid properties and B. C. inputs
% velocity of the upper wall
UWall = 1;
% density
rho   = 1;
%Reynolds Number
Re = 1e3; 
%% Geometric inputs (fixed so that a fair comparison can be made)
% number of nodes X direction.
nI = 31;
% number of nodes Y direction.
nJ = 31;
% length in X direction
xL =  1;
% length in Y direction
yL =  1; 
%% Dependant on above
% kinematic viscosity
nu = UWall * xL / Re; 