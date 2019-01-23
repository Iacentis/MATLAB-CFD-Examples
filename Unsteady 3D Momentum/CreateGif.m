%Creates a .gif file from the produced unsteady-state data
h = figure;
set(h,'Position',[400,0,900,900])
[sx,sy,sz] = meshgrid(linspace(0.1,0.9,3),linspace(0.1,0.9,3),linspace(0.1,0.9,3));
x = permute(xCoords_C,[2,1,3]);
x(end,:,:) = x(end-1,:,:);
y = permute(yCoords_C,[2,1,3]);
y(:,end,:) = y(:,end-1,:);
z = permute(zCoords_C,[2,1,3]);
z(end,end,:) = z(end-1,end-1,:);
filename = sprintf('GraphicalResults/UnsteadyStateResultsRibbon_Duration_%0.0f_seconds_resolution_%dx%d.gif',dt*nTimesteps,nI,nJ);
for timestep = 1:1:nTimesteps
    quiver3(xCoords_C,yCoords_C,zCoords_C,U(:,:,:,timestep),V(:,:,:,timestep),W(:,:,:,end),0)
    axis([0,xL,0,yL,0,zL])
    title(sprintf('Vector plot of the velocity field at t=%0.2f',dt*timestep),'Interpreter','Latex');
    xlabel('x [m]','Interpreter','Latex');
    ylabel('y [m]','Interpreter','Latex');
    zlabel('z [m]','Interpreter','Latex');
    view(3)
    daspect([1,1,1])
    drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if timestep == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',dt); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',dt);
    end 
end