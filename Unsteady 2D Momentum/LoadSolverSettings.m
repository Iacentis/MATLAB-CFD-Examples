% maximum number of iterations
nIterations  = 2e3;
% Amount of timesteps to calculate for
nTimesteps = 300;
dt = 1/30; %Length of timestep
% amount of inner iterations when solving pressure correction
n_inner_iterations_gs = 50; 
% convergence criteria for residuals each variable
resTolerance = 1e-4; 
% under relaxation factor for U and V
alphaUV = 0.5;
% under relaxation factor for P
alphaP  = 0.5;     