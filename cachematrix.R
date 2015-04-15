## A library for calculating and caching the inverse of a matrix. The responsibility of inverse calculation
## and the cache has been separated into two different functions

## makeCacheMatrix is a holder for a matrix and its inverse and provides methods to read and update them.
## The functions defined inside makeCacheMatrix are allowed to update the data in its parent environment
## (which is makeCacheMatrix). Everybody outside of the environment of makeCacheMatrix can update/read the
## matrix/inverse only via the functions that are returned as a list
makeCacheMatrix <- function(mtrx = matrix()) {
	cachedInverse <- NULL
	# Sets the matrix, resets the cached inverse to NULL
	set <- function(input)
	{
		mtrx <<- input
		cachedInverse <<- NULL
	}
	
	# Fetches the matrix available in the environment
	get <- function() mtrx
	
	# Sets the inverse of the matrix (calculated externally).
	### Caution: Setting a random inverse could bring the matrix and inverse out of synch.
	### So, never call the setInverse() without calling the set()
	setInverse <- function(inverse) cachedInverse <<- inverse
	
	# Fetches the inverse of the matrix that has been cahced, NULL otherwise
	getInverse <- function() cachedInverse
	
	# List of functions available to read/update the matrix and its inverse
	list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}

## Fetches the inverse of the matrix if it is cached, else calculates, caches and then returns the inverse
cacheSolve <- function(matrixOps, ...) {
	## Try fetching the inverse from the cache
	inverse <- matrixOps$getInverse()
	if(!is.null(inverse))
	{
		message("getting cached data")
		return(inverse)
	}
	# The cache was NULL, hence fetch the matrix and calculate the invesrse
	mtrx <- matrixOps$get()
	inverse <- solve(mtrx, ...)
	# Cache the inverse for subsequent accesses and return the inverse
	matrixOps$setInverse(inverse)
	inverse
}
