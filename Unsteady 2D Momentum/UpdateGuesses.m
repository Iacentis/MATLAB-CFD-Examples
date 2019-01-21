Pp = (Pp - Pp(2,2));
Pp = Neumann(Pp);% Set Pp with reference to cell (2,2) and copy to boundaries
P = P + alphaP * Pp; % Correct velocities, pressure and mass flows
for i = 2:cI-1
  for j = 2:cJ-1
    U(i,j,timestep) = U(i,j,timestep) + alphaUV*Ax(i,j)/(2*coeffsUV(i,j,5))*(Pp(i-1,j) - Pp(i+1,j));
    V(i,j,timestep) = V(i,j,timestep) + alphaUV*Ay(i,j)/(2*coeffsUV(i,j,5))*(Pp(i,j-1) - Pp(i,j+1));
  end
end
P = Neumann(P); % Copy P to boundaries