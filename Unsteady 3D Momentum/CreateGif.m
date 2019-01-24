%Creates a .gif file from the produced unsteady-state data
h = figure;
set(h,'Position',[400,0,900,900])
nParticles = 80000;
particles = rand(nParticles,3);
x = permute(xCoords_C,[2,1,3]);
x(end,:,:) = x(end-1,:,:);
y = permute(yCoords_C,[2,1,3]);
y(:,end,:) = y(:,end-1,:);
z = permute(zCoords_C,[2,1,3]);
z(end,end,:) = z(end-1,end-1,:);
framesPerStep = 1;
filename = sprintf('GraphicalResults/UnsteadyStateResultsParticlesLowFramerate_Duration_%0.0f_seconds_resolution_%dx%d.gif',dt*nTimesteps,nI,nJ);
for timestep = 1:1:nTimesteps
    u = permute(U(:,:,:,timestep),[2,1,3]);
    v = permute(V(:,:,:,timestep),[2,1,3]);
    w = permute(W(:,:,:,timestep),[2,1,3]);
    %quiver3(xCoords_C,yCoords_C,zCoords_C,U(:,:,:,timestep),V(:,:,:,timestep),W(:,:,:,end),0)
    hold off
    plot3([0,1,0,0;0,1,1,1],[0,0,0,0;0,0,0,0],[0,0,0,1;1,1,0,1],'k.-')
    hold on
    plot3([0,1,0,0;0,1,1,1],[0,0,0,0;0,0,0,0]+1,[0,0,0,1;1,1,0,1],'k.-')
    plot3([0,1,0,0;0,1,1,1],[0,0,0,1;1,1,0,1],[0,0,0,0;0,0,0,0],'k.-')
    plot3([0,0,0,0;0,0,0,0],[0,1,0,0;0,1,1,1],[0,0,0,1;1,1,0,1],'k.-')
    plot3([0,0,0,0;0,0,0,0]+1,[0,1,0,0;0,1,1,1],[0,0,0,1;1,1,0,1],'k.-')
    surf([0,0;1,1],[0,1;0,1],[0,0;0,0],'EdgeAlpha',0,'FaceAlpha',1)
    particlePlot = plot3(particles(:,1),particles(:,2),particles(:,3),'.');
    particlePlot.MarkerSize = 1;
    particleU = interp3(x,y,z,u,particles(:,1),particles(:,2),particles(:,3));
    particleV = interp3(x,y,z,v,particles(:,1),particles(:,2),particles(:,3));
    particleW = interp3(x,y,z,w,particles(:,1),particles(:,2),particles(:,3));
    particles = particles + [particleU,particleV,particleW].*dt + normrnd(0,nu,size(particles)).*dt;
    for i = 1:nParticles
        if(max(particles(i,1:2) > 1))
            particles(i,:) = [rand*dt,rand,0.99];
        else 
            if(min(particles(i,:) < 0))
                particles(i,:) = [rand*dt,rand,0.99];
            end
        end
    end
    axis([-0.05,1.05,-0.05,1.05,-0.05,1.05])
    title(sprintf('Vector plot of the velocity field at t=%0.3f',dt*timestep),'Interpreter','Latex');
    xlabel('x [m]','Interpreter','Latex');
    ylabel('y [m]','Interpreter','Latex');
    zlabel('z [m]','Interpreter','Latex');
    view(24,12)
    daspect([1,1,1])
    if(or(mod(timestep,framesPerStep) == 1,framesPerStep == 1))
    drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if timestep == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1/24); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/24);
    end
end
end