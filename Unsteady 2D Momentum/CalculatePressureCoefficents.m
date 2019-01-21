%SIMPLE
for i=2:cI-1
  for j=2:cJ-1
    coeffsPp(i,j,1) = dx(i,j)/dxe_C(i,j)/(coeffsUV(i,j,6)-coeffsUV(i,j,5));
    coeffsPp(i,j,2) = dx(i,j)/dxw_C(i,j)/(coeffsUV(i-1,j,6)-coeffsUV(i-1,j,5));
    coeffsPp(i,j,3) = dy(i,j)/dyn_C(i,j)/(coeffsUV(i,j,6)-coeffsUV(i,j,5));
    coeffsPp(i,j,4) = dy(i,j)/dys_C(i,j)/(coeffsUV(i,j-1,6)-coeffsUV(i,j-1,5));
    sourcePp(i,j)   = rho * dy_C(i,j) * (Ue(i-1,j) - Ue(i,j))+...
                      rho * dx_C(i,j) * (Vn(i,j-1) - Vn(i,j));
  end
end
coeffsPp(cI-1,:,1) = 0; % Homogeneous Neumann BCs
coeffsPp(2   ,:,2) = 0;
coeffsPp(:,cJ-1,3) = 0;
coeffsPp(:,   2,4) = 0;
coeffsPp(:,:,5) = sum(coeffsPp(:,:,1:4), 3) + DeltaF;
