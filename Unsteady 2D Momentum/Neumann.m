function VarOut = Neumann(VarIn)
VarOut = VarIn;
VarOut(1,:) = VarOut(2,:);
VarOut(end,:) = VarOut(end-1,:);
VarOut(:,1) = VarOut(:,2);
VarOut(:,end) = VarOut(:,end-1);
end