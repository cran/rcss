## Copyright 2017 <Jeremy Yee> <jeremyyee@outlook.com.au>
## Additive duals for finite distribution case
################################################################################

FiniteAddDual <- function(path, disturb, grid, value, expected, build = "fast", k = 1) {
    ## Use the nearest neighbour function from nabor package
    neighbour <- function(query, reference, knn) {
        output <- nabor::knn(reference, query, knn)
        return(output$nn.idx)
    }
    .Call('_rcss_FiniteAddDual', PACKAGE = 'rcss', path, disturb, grid, value,
          expected, build, k, neighbour)
}
