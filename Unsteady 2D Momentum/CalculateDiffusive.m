D(:,:,1) = rho*nu*dy_C./dxe_C; % east diffusive
D(:,:,2) = rho*nu*dy_C./dxw_C; % west diffusive
D(:,:,3) = rho*nu*dx_C./dyn_C; % north diffusive
D(:,:,4) = rho*nu*dx_C./dys_C; % south diffusive
%D(:,1,:) = 0; D(:,cJ,:) = 0;
%D(1,:,:) = 0; D(cI,:,:) = 0;