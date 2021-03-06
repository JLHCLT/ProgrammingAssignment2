#OVERALL DESCRIPTION OF THE FUNCTIONS makeCacheMatrix (mCM) AND cacheSolve (cS)
#Note that all matrices supplied are assumed invertible.

#mCM
#reads in a user defined matrix.  Each time it is called, it first allocates 
#space for a local variable for the inverse matrix. It defines four functions;

#set (only accessed if called by the #command mCM$set().  In this case the
#inverse is initially set to #NULL).

#get (returns the argument of mCM when called by cS.)

#setInverse (sets the inverse (MInverse). On a first call of mCM, is sets the
#cS. It defines this as inv using the assignment <<- so it can be accessed
#inverse as NULL and subsequently, the value of the inverse (inv) calculated by
#outside the local scope of mCM.)

#getInverse() (returns the inverse (possibly cached) when called by cS).

#Finally a list of these functions is passed to cS when called. This makes it 
#easy to access and pass values using "$", as in mCM.Object$get().

#cacheSolve() (CS)
#Used in conjuction with makeCacheMatrix (mCM). When called, cS first gets the
#inverse matrix stored in mCM. This is either NULL or not (an actual matrix).
#It then tests which of these two cases we have.  If the inverse is NULL, then
#it looks at mCM and gets the matrix that was passed to mCM (by the user),
#calculates the inverse (with the solve command), returns it to mCM to be stored
#there so that it is accessible in the parent environment, and outputs the
#inverse function. If the inverse is not NULL (an actul matrix) then it returns
#the user the cached inverse with a message that the cached inverse has been
#retrieved.



#Following the example provided (makeVector), the function makeCacheMatrix 
#below takes a matrix inputted by the user and makes the matrix along with its 
#inverse (initially set as NULL) available to the function cacheSolve defined 
#below.

makeCacheMatrix<-function(Matrix=matrix()) {

  MInverse <- NULL

  set <- function(MatrixInput) {
    Matrix <<- MatrixInput
    MInverse <<- NULL
  }

  get <- function() Matrix
  setInverse <- function(inv) MInverse <<- inv
  getInverse <- function() MInverse
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)

}

#Following the example provided (cachemean), the function cacheSolve takes 
#information stored in makeCacheMatrix and computes the inverse, or returns 
#the inverse cached in mCM

cacheSolve <- function(mCM.Object, ...) {

  inverse <- mCM.Object$getInverse()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  data <- mCM.Object$get()
    inv <- solve(data, ...)
    mCM.Object$setInverse(inv)
    inv

}
