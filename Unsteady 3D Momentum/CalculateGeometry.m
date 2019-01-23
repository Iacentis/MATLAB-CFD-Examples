xCoords_C = zeros(cI,cJ,cK); % X coords of the cells
yCoords_C = zeros(cI,cJ,cK); % Y coords of the cells
zCoords_C = zeros(cI,cJ,cK); % Z coords of the cells

xCoords_N = zeros(nI,nJ,nK); % X coords of the nodes
yCoords_N = zeros(nI,nJ,nK); % Y coords of the nodes
zCoords_N = zeros(nI,nJ,nK); % Z coords of the nodes

dxe_C     = zeros(cI,cJ,cK); % X distance to east cell
dxw_C     = zeros(cI,cJ,cK); % X distance to west cell

dyn_C     = zeros(cI,cJ,cK); % Y distance to north cell
dys_C     = zeros(cI,cJ,cK); % Y distance to south cell

dzu_C     = zeros(cI,cJ,cK); % Z distance to up cell
dzd_C     = zeros(cI,cJ,cK); % Z distance to down cell

dx_C      = zeros(cI,cJ,cK); % X size of the cell
dy_C      = zeros(cI,cJ,cK); % Y size of the cell
dz_C      = zeros(cI,cJ,cK); % Z size of the cell

dx = xL/(nI - 1);
dy = yL/(nJ - 1);
dz = zL/(nK - 1);
% Fill the coordinates
for i = 1:nI
    for j = 1:nJ
        for k = 1:nK
        % For the nodes
        xCoords_N(i,j,k) = (i-1)*dx;
        yCoords_N(i,j,k) = (j-1)*dy;
        zCoords_N(i,j,k) = (k-1)*dz;
        % For the cells
        % X
        if i > 1
            xCoords_C(i,j,k) = 0.5*(xCoords_N(i,j,k) + xCoords_N(i-1,j,k));
        end
        if i == nI && j>1
            yCoords_C(i+1,j,k) = 0.5*(yCoords_N(i,j,k) + yCoords_N(i,j-1,k));
        end
        if i == nI && k>1
            zCoords_C(i+1,j,k) = 0.5*(zCoords_N(i,j,k) + zCoords_N(i,j,k-1));
        end
        % Y
        if j >1
            yCoords_C(i,j,k) = 0.5*(yCoords_N(i,j,k) + yCoords_N(i,j-1,k));
        end
        if j == nJ && i>1
            xCoords_C(i,j+1,k) = 0.5*(xCoords_N(i,j,k) + xCoords_N(i-1,j,k));
        end
        if j == nJ && k>1
            zCoords_C(i,j+1,k) = 0.5*(zCoords_N(i,j,k) + zCoords_N(i,j,k-1));
        end
        % Z
        if k > 1
            zCoords_C(i,j,k) = 0.5*(zCoords_N(i,j,k) + zCoords_N(i,j,k-1));
        end
        if k == nK && i>1
            xCoords_C(i,j,k+1) = 0.5*(xCoords_N(i,j,k) + xCoords_N(i-1,j,k));
        end
        if k == nK && j>1
            yCoords_C(i,j,k+1) = 0.5*(yCoords_N(i,j,k) + yCoords_N(i,j-1,k));
        end
        % Fill dx_C and dy_C
        if i>1
            dx_C(i,j,k) = xCoords_N(i,j,k) - xCoords_N(i-1,j,k);
        end
        if j>1
            dy_C(i,j,k) = yCoords_N(i,j,k) - yCoords_N(i,j-1,k);
        end
        if k>1
            dz_C(i,j,k) = zCoords_N(i,j,k) - zCoords_N(i,j,k-1);
        end
        end
    end
end
xCoords_C(end,:,:) = xL;
yCoords_C(:,end,:) = yL;
zCoords_C(:,:,end) = zL;
% Fill dxe, dxw, dyn and dys
for i = 2:cI - 1
    for j = 2:cJ - 1
        for k = 2:cK - 1
            dxe_C(i,j,k) = xCoords_C(i+1,j,k) - xCoords_C(i,j,k);
            dxw_C(i,j,k) = xCoords_C(i,j,k) - xCoords_C(i-1,j,k);
            dyn_C(i,j,k) = yCoords_C(i,j+1,k) - yCoords_C(i,j,k);
            dys_C(i,j,k) = yCoords_C(i,j,k) - yCoords_C(i,j-1,k);
            dzu_C(i,j,k) = zCoords_C(i,j,k+1) - zCoords_C(i,j,k);
            dzd_C(i,j,k) = zCoords_C(i,j,k) - zCoords_C(i,j,k-1);
        end
    end
end
%% Additional Shorthands for later calculations
%Area in x-direction
Ax = 2.*dz_C.*dy_C.*dx_C./(dxe_C+dxw_C);
%Area in y-direction
Ay = 2.*dz_C.*dy_C.*dx_C./(dyn_C+dys_C);
%Area in z direction
Az = 2.*dz_C.*dy_C.*dx_C./(dzu_C+dzd_C);

dx = alphaUV.*rho.*dy_C.^2.*dz_C.^2.*dx_C.^1;
dy = alphaUV.*rho.*dy_C.^1.*dz_C.^2.*dx_C.^2;
dz = alphaUV.*rho.*dy_C.^2.*dz_C.^1.*dx_C.^2;