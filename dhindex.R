# This function counts all the articles whose citations at least equal to its 
# sequence number.
# When all the articles are arranged by number of citations in a decreasing way,
# the results of this function is h-index defined by J.E. Hirsch.
# 
# Make sure that there is only one researcher in the data.
#
# it can be written in another way:
# h <- vector()
# for (i in 1:length(x$tc)) h[i] <- x$tc[i] - i
# b <- vector()
# b <- which(h >= 0)
# length(b)

dhindex <- function(data, totct = "tc") {
        # data is a data.frame contains a single author's research articles.
        # totct is a variable name(a column index) that represents the total 
        # citation of each article.
        c <- vector()
        for (i in 1:length(data[,totct])) c[i] <- ifelse(data[,totct][i] >= i, 1, 0)
        sum(c)
}
