## This function computes exactly J.E. Hirsch's definition of h-index:
## h of papers have at least h citations each and the rest have 
## citations <= h each (whether the articles are arranged by 
## citations in an ascending order or not, it will return the true h-index).

h_index <- function(data, totct = "tc") {
        # data is a data.frame contains a single author's research articles
        # totct is a variable name(a column index) that represents the total 
        # citation of each article.
        a <- vector()
        b <- vector()
        tlc <- data[, totct]
        for (i in 1:length(tlc)) {
                a[i] <- ifelse(length(which(tlc >= i)) == i, i, 0)
                b[i] <- ifelse(length(which(tlc >= i)) <= i, i, length(tlc))
        }
        q <- sum(a)
        h <- ifelse(q == 0, min(b)-1,q)
        h
}