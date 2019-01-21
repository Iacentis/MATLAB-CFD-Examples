%Convective
F(1:end-1,:,1) = rho*dy_C(1:end-1,:,1).*Ue(1:end-1,:); % east convective
F(2:end,:,2)   = rho*dy_C(1:end-1,:,1).*Ue(1:end-1,:); % west convective
F(:,1:end-1,3) = rho*dx_C(:,1:end-1,1).*Vn(:,1:end-1); % north convective
F(:,2:end,4)   = rho*dx_C(:,1:end-1,1).*Vn(:,1:end-1); % south convective

DeltaF = F(:,:,1) - F(:,:,2) + F(:,:,3) - F(:,:,4);