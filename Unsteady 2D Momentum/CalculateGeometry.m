xCoords_C = zeros(cI,cJ); % X coords of the cells
yCoords_C = zeros(cI,cJ); % Y coords of the cells
xCoords_N = zeros(nI,nJ); % X coords of the nodes
yCoords_N = zeros(nI,nJ); % Y coords of the nodes
dxe_C     = zeros(cI,cJ); % X distance to east cell
dxw_C     = zeros(cI,cJ); % X distance to west cell
dyn_C     = zeros(cI,cJ); % Y distance to north cell
dys_C     = zeros(cI,cJ); % Y distance to south cell
dx_C      = zeros(cI,cJ); % X size of the cell
dy_C      = zeros(cI,cJ); % Y size of the cell

dx = xL/(nI - 1);
dy = yL/(nJ - 1);
% Fill the coordinates
for i = 1:nI
    for j = 1:nJ
        % For the nodes
        xCoords_N(i,j) = (i-1)*dx;
        yCoords_N(i,j) = (j-1)*dy;
        % For the cells
        if i > 1
            xCoords_C(i,j) = 0.5*(xCoords_N(i,j) + xCoords_N(i-1,j));
        end
        if i == nI && j>1
            yCoords_C(i+1,j) = 0.5*(yCoords_N(i,j) + yCoords_N(i,j-1));
        end
        if j >1
            yCoords_C(i,j) = 0.5*(yCoords_N(i,j) + yCoords_N(i,j-1));
        end
        if j == nJ && i>1
            xCoords_C(i,j+1) = 0.5*(xCoords_N(i,j) + xCoords_N(i-1,j));
        end
        % Fill dx_C and dy_C
        if i>1
            dx_C(i,j) = xCoords_N(i,j) - xCoords_N(i-1,j);
        end
        if j>1
            dy_C(i,j) = yCoords_N(i,j) - yCoords_N(i,j-1);
        end
    end
end
xCoords_C(end,:) = xL;
yCoords_C(:,end) = yL;
% Fill dxe, dxw, dyn and dys
for i = 2:cI - 1
    for j = 2:cJ - 1
        dxe_C(i,j) = xCoords_C(i+1,j) - xCoords_C(i,j);
        dxw_C(i,j) = xCoords_C(i,j) - xCoords_C(i-1,j);
        dyn_C(i,j) = yCoords_C(i,j+1) - yCoords_C(i,j);
        dys_C(i,j) = yCoords_C(i,j) - yCoords_C(i,j-1);
    end
end
%% Additional Shorthands for later calculations
%Area in x-direction
Ax = 2*dy_C.*dx_C./(dxe_C+dxw_C);
%Area in y-direction
Ay = 2*dy_C.*dx_C./(dyn_C+dys_C);

dx = alphaUV.*rho.*dy_C.^2.*dx_C;
dy = alphaUV.*rho.*dx_C.^2.*dy_C;