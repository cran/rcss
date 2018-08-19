## Copyright 2017 <Jeremy Yee> <jeremyyee@outlook.com.au>
## Expected value function using conditional expectation matrices
################################################################################

FastExpected <- function(grid, value, disturb, weight, r_index, smooth = 1) {
    ## Use the nearest neighbour function from nabor package
    neighbour <- function(query, reference, knn) {
        output <- nabor::knn(reference, query, knn)
        return(output$nn.idx)
    }
    ## Call function 
    .Call('_rcss_FastExpected', PACKAGE = 'rcss', grid, value, r_index,
          disturb, weight, smooth, neighbour)
}
