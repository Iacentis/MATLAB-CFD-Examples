v = VideoWriter(sprintf('Unsteady_Results_%d_seconds.avi',round(nTimesteps*dt)));
v.FrameRate = 60;
open(v);
for timestep = 1:nTimesteps
quiver(xCoords_C,yCoords_C,U(:,:,timestep),V(:,:,timestep),0)
axis([0,xL,0,yL])
title('Vector plot of the velocity field','Interpreter','Latex');
xlabel('x [m]','Interpreter','Latex');
ylabel('y [m]','Interpreter','Latex');
writeVideo(v,getframe(gcf));
end
close(v);