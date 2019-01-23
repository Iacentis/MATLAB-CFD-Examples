function varOut = GaussSeidelSolve(varIn,coeffs,source)
%Solves a linear 2D-system by means of under-relaxed gauss-seidel.
%varIn: The variable being solved (MxN matrix)
%coeffs: The linear coefficients for the neighbouring nodes (MxNx5 matrix)
%source: Source-term vector (MxN matrix)
%softening: The under relaxation factor (float greater than 0 and smaller
%or equal to 1, where 1 is no underrelaxation
varOut = varIn;
for i=2:size(varOut,1)-1
    for j = 2:size(varOut,2)-1
        for k = 2:size(varOut,3)-1
        varOut(i,j,k) = (...
                       coeffs(i,j,k,1) * varOut(i+1,j,k) +...
                       coeffs(i,j,k,2) * varOut(i-1,j,k) +...
                       coeffs(i,j,k,3) * varOut(i,j+1,k) +...
                       coeffs(i,j,k,4) * varOut(i,j-1,k) +...
                       coeffs(i,j,k,5) * varOut(i,j,k+1) +...
                       coeffs(i,j,k,6) * varOut(i,j,k-1) +...
                       source(i,j,k)...
                       )/coeffs(i,j,k,7);
        end
    end
end
end