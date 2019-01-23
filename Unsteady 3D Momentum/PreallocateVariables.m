cI = nI + 1;                 % number of cells in the X direction. Cells added in the boundaries
cJ = nJ + 1;                 % number of cells in the Y direction. Cells added in the boundaries
cK = nK + 1;                 % number of cells in the Z direction.
coeffsUV  = zeros(cI,cJ,cK,8);  % coefficients for the U and V equation E, W, N, S, time and P
sourceUV  = zeros(cI,cJ,cK,3);  % source coefficients for the U and V equation U and V
coeffsPp  = zeros(cI,cJ,cK,7);  % coefficients for the pressure correction equation E, W, N, S and P
sourcePp  = zeros(cI,cJ,cK);    % source coefficients for the pressure correction equation
U         = zeros(cI,cJ,cK,nTimesteps);    % U velocity matrix
V         = zeros(cI,cJ,cK,nTimesteps);    % V velocity matrix
W         = zeros(cI,cJ,cK,nTimesteps);    % W velocity matrix
Ue        = zeros(cI,cJ,cK);    % Rhie-Chow east face velocity matrix
Uw        = zeros(cI,cJ,cK);    % Rhie-Chow west face velocity matrix
Vn        = zeros(cI,cJ,cK);    % Rhie-Chow north face velocity matrix
Vs        = zeros(cI,cJ,cK);    % Rhie-Chow south face velocity matrix
Wu        = zeros(cI,cJ,cK);    % Rhie-Chow Up face velocity matrix
Wd        = zeros(cI,cJ,cK);    % Rhie-chow Down face velocity matrix
P         = zeros(cI,cJ,cK,nTimesteps);    % pressure matrix
Pp        = zeros(cI,cJ,cK);    % pressure correction matrix
F         = zeros(cI,cJ,cK,6);  % Convective Coefficents
D         = zeros(cI,cJ,cK,6);  % Diffusive Coefficents
residuals = zeros(4,1);      % U, V, W and continueity residuals
%% Boundary Conditions
% A note: The method used (Coallocated grid with Rhie-chow) does not handle
% Inlet and Outlet boundary conditions (as in, velocity components
% perpendicular to the wall) all that well, and thus should be avoided. 
W(end,:,:,:) = UWall;