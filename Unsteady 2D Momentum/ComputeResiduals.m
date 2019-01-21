if iter>1
    residuals(:,end+1) = zeros(3,1);
end
for i=2:cI-1  % 1: (resU), 2: (resV), 3: (resCon)
  for j=2:cJ-1
    residuals(1,end) = residuals(1,end) + abs(...
                      U(i+1,j,timestep)*coeffsUV(i,j,1)+...
                      U(i-1,j,timestep)*coeffsUV(i,j,2)+...
                      U(i,j+1,timestep)*coeffsUV(i,j,3)+...
                      U(i,j-1,timestep)*coeffsUV(i,j,4)+...
                      U(i,j,timestep-1)*coeffsUV(i,j,5)-...
                      (coeffsUV(i,j,6))*U(i,j,timestep)+...
                      sourceUV(i,j,1));
                    
    residuals(2,end) = residuals(2,end) + abs(...
                      V(i+1,j,timestep)*coeffsUV(i,j,1)+...
                      V(i-1,j,timestep)*coeffsUV(i,j,2)+...
                      V(i,j+1,timestep)*coeffsUV(i,j,3)+...
                      V(i,j-1,timestep)*coeffsUV(i,j,4)+...
                      V(i,j,timestep-1)*coeffsUV(i,j,5)-...
                      V(i,j,timestep)*(coeffsUV(i,j,6))+...
                      sourceUV(i,j,2));
                    
    residuals(3,end) = residuals(3,end) + abs(DeltaF(i,j));
  end
end
% Check convergence
converged = true;
for i=1:size(residuals,1)
    if resTolerance<residuals(i,end)
        converged = false;
        break;
    end
end