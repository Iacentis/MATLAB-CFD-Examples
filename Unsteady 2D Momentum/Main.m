clear; clc; close all; clf
disp('Starting')
LoadPhysicalData
LoadSolverSettings
PreallocateVariables
CalculateGeometry
CalculateDiffusive
for timestep = 2:nTimesteps
    residuals = zeros(3,1);
    P(:,:,timestep) = P(:,:,timestep-1);
    for iter=1:nIterations
        CalculateFluxes
        CalculateCoefficients
        U(:,:,timestep) = TimeGaussSeidel(U(:,:,timestep),U(:,:,timestep-1),coeffsUV,sourceUV(:,:,1)); 
        V(:,:,timestep) = TimeGaussSeidel(V(:,:,timestep),V(:,:,timestep-1),coeffsUV,sourceUV(:,:,2));
        CalculateFaceVelocities 
        CalculatePressureCoefficents
        for iter_gs=1:n_inner_iterations_gs
            Pp = GaussSeidelSolve(Pp,coeffsPp,sourcePp,1); 
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
%CreateGif
%%
Blip = U./sqrt(U.^2+V.^2);
Blop = V./sqrt(U.^2+V.^2);
subplot(1,2,1)
quiver(xCoords_C,yCoords_C,U(:,:,end),V(:,:,end),0)
axis([0,1,0,1])
subplot(1,2,2)
quiver(xCoords_C,yCoords_C,Blip(:,:,end),Blop(:,:,end),0.4)
axis([0,1,0,1])
disp('Finished')