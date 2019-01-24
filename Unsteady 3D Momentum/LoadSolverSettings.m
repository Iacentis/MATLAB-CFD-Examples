% maximum number of iterations
nIterations  = 1000;
% Amount of timesteps to calculate for
nTimesteps = 1000;
dt = 1/30; %Length of timestep
% amount of inner iterations when solving pressure correction
n_inner_iterations_gs = 30; 
% convergence criteria for residuals each variable
resTolerance = 1e-4; 
% under relaxation factor for U and V
alphaUV = 1;
% under relaxation factor for P
alphaP  = 1;     