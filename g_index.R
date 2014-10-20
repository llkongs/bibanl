# This function is used for calculating the g-index. 
# The definition of g-index is : putting a researcher's article in a descending 
# way by citation, the first g articles has the total citation which is at least
# equal to g^2. 
# If g is biger than the number of total articles, it will return 
# a "pseudo g-index" which equals to the floored value of the square root of 
# the summartion of all articles citation.
# Make sure that there is only one researcher in the data.

g_index <- function(data, totct = "tc") {
        # data is a data.frame contains a single author's research articles.
        # totct is a variable name(a column index) that represents the total 
        # citation of each article.
        Hindex <- function(data, totct = "tc") {
                a <- vector()
                b <- vector()
                tlc <- data[, totct]
                for (i in 1:length(tlc)) {
                        a[i] <- ifelse(length(which(tlc >= i)) == i, i, 0)
                        b[i] <- ifelse(length(which(tlc >= i)) <= i,
                                       i, length(tlc))
                }
                q <- sum(a)
                h <- ifelse(q == 0, min(b)-1,q)
                h
        }
        c <- vector()
        x <- data[,totct]
        for (i in 1:length(x)) c[i] <- ifelse(sum(x[1:i]) >= i^2, 1, 0)
        a <- ifelse(sum(c) < sqrt(sum(x[1:Hindex(data)])), floor(sqrt(sum(x))), sum(c) )
        return(a)
}