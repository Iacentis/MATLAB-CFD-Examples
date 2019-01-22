%Creates a .gif file from the produced unsteady-state data
h = figure;
set(h,'Position',[0,0,400,800])
filename = sprintf('GraphicalResults/UnsteadyStateResults_Duration_%0.0f_seconds_resolution_%dx%d.gif',dt*nTimesteps,nI,nJ);
for timestep = 1:nTimesteps
    subplot(2,1,1)
    quiver(xCoords_C,...
           yCoords_C,...
           U(:,:,timestep),...
           V(:,:,timestep),0)
    axis([0,xL,0,yL])
    title(sprintf('Vector plot of the velocity field at t=%0.2f',dt*timestep),'Interpreter','Latex');
    xlabel('x [m]','Interpreter','Latex');
    ylabel('y [m]','Interpreter','Latex');
    subplot(2,1,2)
    surf(xCoords_C,yCoords_C,P(:,:,timestep),'EdgeAlpha',0)
    axis([0,xL,0,yL,min(P(:)),max(P(:))])
    title(sprintf('Pressure field at t=%0.2f',dt*timestep),'Interpreter','Latex');
    xlabel('x [m]','Interpreter','Latex');
    ylabel('y [m]','Interpreter','Latex');
    colormap jet
    view(0,90)
    colorbar
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