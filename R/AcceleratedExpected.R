## Copyright 2017 <Jeremy Yee> <jeremyyee@outlook.com.au>
## Expected value using nearest neighbours
################################################################################

AcceleratedExpected <- function(grid, value, disturb, weight, k = 1) {
    ## Use the nearest neighbour function from nabor package
    neighbour <- function(query, reference, knn) {
        output <- nabor::knn(reference, query, knn)
        return(output$nn.idx)
    }
    ## Call function 
    .Call('_rcss_AcceleratedExpected', PACKAGE = 'rcss', grid, value, disturb,
          weight, k, neighbour)
}
