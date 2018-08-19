## Copyright 2017 <Jeremy Yee> <jeremyyee@outlook.com.au>
## Finds the assigned policy for the paths using nearest neighbours
################################################################################

FastPathPolicy <- function(path, grid, control, Reward, expected) {
    ## Use the nearest neighbour function from nabor package
    neighbour <- function(query, reference, knn) {
        output <- nabor::knn(reference, query, knn)
        return(output$nn.idx)
    }
    ## Call function 
    .Call('_rcss_FastPathPolicy', PACKAGE = 'rcss', path, grid, control, Reward,
          expected, neighbour)
}
