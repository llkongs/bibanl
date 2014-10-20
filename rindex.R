# This function is used for calculating the r-index.
# The definition of r-index is:  putting a researcher's article in a descending 
# way by citation, the square root of the summation of  the first h(the h-index) 
# articles' citation is the r-index.

rindex <- function(data,totct = "tc") {
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
        x <- data[, totct]
        data <- data[order(x,decreasing = TRUE), ]   
        sqrt(sum(x[1:Hindex(data)]))
}