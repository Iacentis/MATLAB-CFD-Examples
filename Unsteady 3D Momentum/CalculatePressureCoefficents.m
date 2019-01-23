%SIMPLE
for i=2:cI-1
  for j=2:cJ-1
      for k=2:cK-1
    coeffsPp(i,j,k,1) = dx(i,j,k)/dxe_C(i,j,k)/(coeffsUV(i+0,j,k,8));%-coeffsUV(i+0,j,k,7));
    coeffsPp(i,j,k,2) = dx(i,j,k)/dxw_C(i,j,k)/(coeffsUV(i-1,j,k,8));%-coeffsUV(i-1,j,k,7));
    coeffsPp(i,j,k,3) = dy(i,j,k)/dyn_C(i,j,k)/(coeffsUV(i,j+0,k,8));%-coeffsUV(i,j+0,k,7));
    coeffsPp(i,j,k,4) = dy(i,j,k)/dys_C(i,j,k)/(coeffsUV(i,j-1,k,8));%-coeffsUV(i,j-1,k,7));
    coeffsPp(i,j,k,5) = dz(i,j,k)/dzu_C(i,j,k)/(coeffsUV(i,j,k+0,8));%-coeffsUV(i,j,k+0,7));
    coeffsPp(i,j,k,6) = dz(i,j,k)/dzd_C(i,j,k)/(coeffsUV(i,j,k-1,8));%-coeffsUV(i,j,k-1,7));
    sourcePp(i,j,k)   = rho*dy_C(i,j,k)*dz_C(i,j,k)*(Ue(i-1,j,k) - Ue(i,j,k))+...
                        rho*dx_C(i,j,k)*dz_C(i,j,k)*(Vn(i,j-1,k) - Vn(i,j,k))+...
                        rho*dx_C(i,j,k)*dy_C(i,j,k)*(Wu(i,j,k-1) - Wu(i,j,k));
      end
  end
end
coeffsPp(cI-1,:,:,1) = 0; % Homogeneous Neumann BCs
coeffsPp(2   ,:,:,2) = 0;
coeffsPp(:,cJ-1,:,3) = 0;
coeffsPp(:,   2,:,4) = 0;
coeffsPp(:,:,cK-1,5) = 0;
coeffsPp(:,:,   2,6) = 0;
coeffsPp(:,:,:,7) = sum(coeffsPp(:,:,:,1:6), 4) + DeltaF;
