D(:,:,:,1) = rho*nu*dz_C.*dy_C./dxe_C; % east diffusive
D(:,:,:,2) = rho*nu*dz_C.*dy_C./dxw_C; % west diffusive
D(:,:,:,3) = rho*nu*dz_C.*dx_C./dyn_C; % north diffusive
D(:,:,:,4) = rho*nu*dz_C.*dx_C./dys_C; % south diffusive
D(:,:,:,5) = rho*nu*dx_C.*dy_C./dzu_C; % Up diffusive
D(:,:,:,6) = rho*nu*dx_C.*dy_C./dzd_C; % Down diffusive
%D(:,1,:,:) = 0; D(:,cJ,:,:) = 0;
%D(1,:,:,:) = 0; D(cI,:,:,:) = 0;
%D(:,:,1,:) = 0; D(:,:,cK,:) = 0;