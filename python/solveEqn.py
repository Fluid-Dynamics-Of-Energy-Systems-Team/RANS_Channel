#**************************************************************************
#       function to solve linear system  [A].x = b
#**************************************************************************
# Inputs:
#   x       variable to be solved
#   A       coefficient matrix
#   b       right hand side
#   omega   under-relaxation parameter
#
# Output:
#   x_new   updated x
#


def solveEqn(x,A,b,omega):
    
    import numpy as np

    n = np.size(x)
    x_new = x
    
    # add boundary conditions
    b = b - x[0]*A[1:n-1,0] - x[n-1]*A[1:n-1,n-1]
    
#    # perform under-relaxation
    b[:] = b[:] + (1-omega)/omega * A.diagonal()[1:n-1]*x[1:n-1]
    np.fill_diagonal(A, A.diagonal()/omega)
    
    # solve linear system
#    result = np.linalg.solve(A[1:n-1, 1:n-1], b)
    x_new[1:n-1] = np.linalg.solve(A[1:n-1, 1:n-1], b)
    return x_new
    
