Pp = (Pp - Pp(2,2,2));
Pp = Neumann(Pp);% Set Pp with reference to cell (2,2) and copy to boundaries
P(:,:,:,timestep) = P(:,:,:,timestep) + alphaP * Pp; % Correct velocities, pressure and mass flows
for i = 2:cI-1
  for j = 2:cJ-1
      for k = 2:cK-1
        U(i,j,k,timestep) = U(i,j,k,timestep) + alphaUV*Ax(i,j,k)/(2*coeffsUV(i,j,k,8))*(Pp(i-1,j,k) - Pp(i+1,j,k));
        V(i,j,k,timestep) = V(i,j,k,timestep) + alphaUV*Ay(i,j,k)/(2*coeffsUV(i,j,k,8))*(Pp(i,j-1,k) - Pp(i,j+1,k));
        W(i,j,k,timestep) = W(i,j,k,timestep) + alphaUV*Az(i,j,k)/(2*coeffsUV(i,j,k,8))*(Pp(i,j,k-1) - Pp(i,j,k+1));
      end
  end
end
P(:,:,:,timestep) = Neumann(P(:,:,:,timestep)); % Copy P to boundaries