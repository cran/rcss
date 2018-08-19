## Copyright 2017 <Jeremy Yee> <jeremyyee@outlook.com.au>
## Additive duals using nearest neighbours
################################################################################

FastAddDual <- function(path, subsim, weight, grid, value, Scrap) {
        ## Use the nearest neighbour function from nabor package
    neighbour <- function(query, reference, knn) {
        output <- nabor::knn(reference, query, knn)
        return(output$nn.idx)
    }
    ## Call function 
    .Call('_rcss_FastAddDual', PACKAGE = 'rcss', path, subsim, weight, grid, value, Scrap, neighbour)
}
