# This is the core function of the h-index function. It will computes the exact 
# Hirsch's defined h-index.
# Make sure that there is only one researcher in the data.

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