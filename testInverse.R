source("inverse.R")

# Set-Up
matrixOps <- makeCacheMatrix()
inv <- cacheSolve(matrixOps)
print(inv)

# A new Matrix is being set in the matrixOps class. Inverse would be calculated and cached
sample = rbind(c(1, -1/4, 5), c(5,-1/4, 1), c(2,3,4))
matrixOps$set(sample)
print(cacheSolve(matrixOps))

# On this second call, instead of recalculating, the cached inverse would be returned
print(cacheSolve(matrixOps))
