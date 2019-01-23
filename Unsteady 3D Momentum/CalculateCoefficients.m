aE = cat(4,-F(:,:,:,1), D(:,:,:,1) - F(:,:,:,1)/2, zeros(size(F(:,:,:,1))));
aW = cat(4, F(:,:,:,2), D(:,:,:,2) + F(:,:,:,2)/2, zeros(size(F(:,:,:,2))));
aN = cat(4,-F(:,:,:,3), D(:,:,:,3) - F(:,:,:,3)/2, zeros(size(F(:,:,:,3))));
aS = cat(4, F(:,:,:,4), D(:,:,:,4) + F(:,:,:,4)/2, zeros(size(F(:,:,:,4))));
aU = cat(4,-F(:,:,:,5), D(:,:,:,5) - F(:,:,:,5)/2, zeros(size(F(:,:,:,5))));
aD = cat(4, F(:,:,:,6), D(:,:,:,6) - F(:,:,:,6)/2, zeros(size(F(:,:,:,6))));

% Compute coefficients for U and V equations
coeffsUV(:,:,:,1) = max(aE,[],4);
coeffsUV(:,:,:,2) = max(aW,[],4);
coeffsUV(:,:,:,3) = max(aN,[],4);
coeffsUV(:,:,:,4) = max(aS,[],4);
coeffsUV(:,:,:,5) = max(aU,[],4);
coeffsUV(:,:,:,6) = max(aD,[],4);
coeffsUV(:,:,:,7) = rho.*dz_C.*dx_C.*dy_C./dt;
coeffsUV(:,:,:,8) = sum(coeffsUV(:,:,:,1:7),4)+DeltaF;
for i=2:cI-1
    for j=2:cJ-1
        for k = 2:cK-1
            sourceUV(i,j,k,1) = (P(i-1,j,k,timestep) - P(i+1,j,k,timestep)) * Ax(i,j,k)/2;%<<-----!!!!
            sourceUV(i,j,k,2) = (P(i,j-1,k,timestep) - P(i,j+1,k,timestep)) * Ay(i,j,k)/2;%<<-----!!!!
            sourceUV(i,j,k,3) = (P(i,j,k-1,timestep) - P(i,j,k+1,timestep)) * Az(i,j,k)/2;
        end
    end
end