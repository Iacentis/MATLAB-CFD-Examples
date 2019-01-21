cI = nI + 1;                 % number of cells in the X direction. Cells added in the boundaries
cJ = nJ + 1;                 % number of cells in the Y direction. Cells added in the boundaries
coeffsUV  = zeros(cI,cJ,6);  % coefficients for the U and V equation E, W, N, S, time and P
sourceUV  = zeros(cI,cJ,2);  % source coefficients for the U and V equation U and V
coeffsPp  = zeros(cI,cJ,5);  % coefficients for the pressure correction equation E, W, N, S and P
sourcePp  = zeros(cI,cJ);    % source coefficients for the pressure correction equation
U         = zeros(cI,cJ,nTimesteps);    % U velocity matrix
V         = zeros(cI,cJ,nTimesteps);    % V velocity matrix
Ue        = zeros(cI,cJ);    % Rhie-Chow east face velocity matrix
Uw        = zeros(cI,cJ);    % Rhie-Chow west face velocity matrix
Vn        = zeros(cI,cJ);    % Rhie-Chow north face velocity matrix
Vs        = zeros(cI,cJ);    % Rhie-Chow south face velocity matrix
P         = zeros(cI,cJ);    % pressure matrix
Pp        = zeros(cI,cJ);    % pressure correction matrix
F         = zeros(cI,cJ,4);  % Convective Coefficents
D         = zeros(cI,cJ,4);  % Diffusive Coefficents
residuals = zeros(3,1);      % U, V and continueity residuals
%% Boundary Conditions
% A note: The method used (Coallocated grid with Rhie-chow) does not handle
% Inlet and Outlet boundary conditions (as in, velocity components
% perpendicular to the wall) all that well, and thus should be avoided. 
U(:,end,:) = UWall;
U(:,1,:) = -UWall;