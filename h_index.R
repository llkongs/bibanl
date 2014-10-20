## This function computes exactly J.E. Hirsch's definition of h-index:
## h of papers have at least h citations each and the rest have 
## citations <= h each (whether the articles are arranged by 
## citations in an ascending order or not, it will return the true h-index).

h_index <- function(data,researcher = "researcher", totct = "tc", 
                    single = TRUE) {
        # data is a data.frame contains a single author's research articles.
        # researcher is a variable name(a column index) that represents the 
        # researcher's name of eacher article.
        # totct is a variable name(a column index) that represents the total 
        # citation of each article.
        # If single = TRUE, and there are more than one researchers in the data,
        # you will get a data frame with each researcher's h-index.
        # If single = FALSE, the data will be computed as a whole.(When you are
        # trying to compute an institution's h-index, this will be useful.)
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
        
        if (single == FALSE) {
                hinda <- Hindex(data)
        } else { if (single == TRUE) {
                        res <- unique(data[, researcher])
                        data$resch1 <- data[,researcher]
                        hinda <- vector()
                        for (j in res) {
                                hinda[j] <- Hindex(subset(data, 
                                                          data$resch1 == j))
                                }
                        hinda <- as.data.frame(hinda)
                        hinda$h.index <- hinda[,1]
                        hinda[,1] <- rownames(hinda)
                        rownames(hinda) <- 1:length(res)
                        colnames(hinda) <- c("researcher", "h-index")
                        } else {
                                stop("The value of single is invalid!")
                        }
                }
        hinda
}