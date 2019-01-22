aE = cat(3,-F(:,:,1), D(:,:,1) - F(:,:,1)/2, zeros(size(F(:,:,1))));
aW = cat(3, F(:,:,2), D(:,:,2) + F(:,:,2)/2, zeros(size(F(:,:,2))));
aN = cat(3,-F(:,:,3), D(:,:,3) - F(:,:,3)/2, zeros(size(F(:,:,3))));
aS = cat(3, F(:,:,4), D(:,:,4) + F(:,:,4)/2, zeros(size(F(:,:,4))));

% Compute coefficients for U and V equations
coeffsUV(:,:,1) = max(aE,[],3);
coeffsUV(:,:,2) = max(aW,[],3);
coeffsUV(:,:,3) = max(aN,[],3);
coeffsUV(:,:,4) = max(aS,[],3);
coeffsUV(:,:,5) = rho.*dx_C.*dy_C./dt;
coeffsUV(:,:,6) = sum(coeffsUV(:,:,1:5),3)+DeltaF;
for i=2:cI-1
  for j=2:cJ-1
    sourceUV(i,j,1) = (P(i-1,j,timestep) - P(i+1,j,timestep)) * Ax(i,j)/2;%<<-----!!!!
    sourceUV(i,j,2) = (P(i,j-1,timestep) - P(i,j+1,timestep)) * Ay(i,j)/2;%<<-----!!!!
  end
end