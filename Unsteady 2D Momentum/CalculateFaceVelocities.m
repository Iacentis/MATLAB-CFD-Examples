% Rhie-Chow
for i = 2:cI-2
    for j = 2:cJ-1
        Ue(i,j) = (U(i,j,timestep)+U(i+1,j,timestep))./2+...
                  alphaUV.*dy_C(i,j)./(coeffsUV(i,j,5)*4).*...
                  (P(i+2,j,timestep)-...
                   3*P(i+1,j,timestep)+...
                   3*P(i,j,timestep)-...
                   P(i-1,j,timestep));
    end
end
for i = 2:cI-1
    for j = 2:cJ-2
        Vn(i,j) = (V(i,j,timestep)+V(i,j+1,timestep))./2+...
                  alphaUV.*dx_C(i,j)./(coeffsUV(i,j,5)*4).*...
                  (P(i,j+2,timestep)-...
                   3*P(i,j+1,timestep)+...
                   3*P(i,j,timestep)-...
                   P(i,j-1,timestep));
    end
end
for i = 2:cI
    Uw(i,:) = Ue(i-1,:);
end
for j = 2:cJ
    Vs(:,j) = Vn(:,j-1);
end