# This function will return some bibliometrical indexes in a data frame.
# There can be more than one researcher in the data.
# This function will put every researcher's article in an decreasing order by 
# citations

datanl <- function(data,researcher ="researcher", totct = "tc", pbsr = "source", 
                   pyear = "pyear") {
        # data is a data.frame contains a single author's research articles.
        # researcher is a variable name(a column index) that represents the 
        # researcher's name of eacher article.
        # totct is a variable name(a column index) that represents the total 
        # citation of each article.
        # pbsr is a variable name that represents the pulication source(which 
        # journal the article has been published).
        # pyear is a variable name that represents the publication year of each
        # paper.
        bibm <- function(data,researcher ="researcher", totct = "tc", pbsr = "source", 
                         pyear = "pyear") {
                h <- 0; g <- 0; r <- 0; y <- 0; allc <- 0
                data <- data[order(data[,totct],decreasing = TRUE),]
                data[,pbsr] <- as.factor(data[,pbsr])
                h <- Hindex(data); g <- g_index(data); y <- 2014 - min(data[,pyear]) +1
                r <- rindex(data); allc <- sum(data[,totct])
                qqq <- data.frame(data[,researcher][1])
                colnames(qqq)[1] <- "researcher"
                qqq$h.index <- h; qqq$g.index <- g; qqq$r.index <- r
                qqq$number <- length(data[,totct]); qqq$year1st <- y
                qqq$journals <- length(unique(data[,pbsr])); qqq$vip <- jnal(data)
                qqq$avc <- allc/length(data[,totct]);qqq$allc <- allc
                #qqq$rhmax <- rmhindex(data)[1]
                #qqq$rhmin <- rmhindex(data)[2]
                #qqq$rhavg <- rmhindex(data)[3]
                return(qqq)
        }
        res <- unique(data[, researcher])
        data$resch1 <- data[,researcher]
        qqq <- bibm(subset(data, resch1 == res[1]))
        if(length(res) == 1){
                qqq <- qqq
        } else {
                for (j in 2:length(res)) {
                qqq <- rbind(qqq, bibm(subset(data, resch1 == res[j])))
                }
        }        
        return(qqq)                      
}