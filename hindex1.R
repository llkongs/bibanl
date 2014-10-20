# This function will find the first article's number whose citations is less
# than its number and return this number minus one.
# When all the articles are arranged by number of citations in a decreasing way
# the results of this function is the  h-index defined by J.E. Hirsch.
# Make sure that there is only one researcher in the data.
hindex1 <- function(data, totct = "tc") {
        # data is a data.frame contains a single author's research articles.
        # totct is a variable name(a column index) that represents the total 
        # citation of each article.
        h <- vector()
        x <- data[,totct]
        for (i in 1:length(x)) h[i] <- x[i] - i
        return((which(h < 0 ))[1]-1)
}