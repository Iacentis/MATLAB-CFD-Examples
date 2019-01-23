clear; clc; close all; clf
disp('Starting')
LoadPhysicalData
LoadSolverSettings
PreallocateVariables
CalculateGeometry
CalculateDiffusive
for timestep = 2:nTimesteps
    residuals = zeros(4,1);
    P(:,:,:,timestep) = P(:,:,:,timestep-1);
    for iter=1:nIterations
        CalculateFluxes
        CalculateCoefficients
        U(:,:,:,timestep) = TimeGaussSeidel(U(:,:,:,timestep),U(:,:,:,timestep-1),coeffsUV,sourceUV(:,:,:,1)); 
        V(:,:,:,timestep) = TimeGaussSeidel(V(:,:,:,timestep),V(:,:,:,timestep-1),coeffsUV,sourceUV(:,:,:,2));
        W(:,:,:,timestep) = TimeGaussSeidel(W(:,:,:,timestep),W(:,:,:,timestep-1),coeffsUV,sourceUV(:,:,:,3));
        CalculateFaceVelocities 
        CalculatePressureCoefficents
        for iter_gs=1:n_inner_iterations_gs
            Pp = GaussSeidelSolve(Pp,coeffsPp,sourcePp); 
        end
        UpdateGuesses
        ComputeResiduals
        if converged
            fprintf('Timestep: %d, iterations: %d, Continuity Error: %d\n',timestep,iter,residuals(3,end))
            break;
        end
    end
    if(~converged)
        disp(residuals(:,end)')
        break;
    end
end
CreateGif