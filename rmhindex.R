# This is an interesting function which I call it the "random h-index" function.
# Concretley, the function will first randomly order one researcher's article 
# by citations. Then it counts all the articles whose citations at least equal 
# to its sequence number. The process above will be repeated for n times. 
# n equals to the number of articles. All the "random h-index" will be 
# strored in a vector. Its maximum, minimum and average value of the vector will
# be returned.

rmhindex <- function(data, totct = "tc") {
        # data is a data.frame contains a single author's research articles.
        # totct is a variable name(a column index) that represents the total 
        # citation of each article.
        dhindex <- function(data, totct = "tc") {
                c <- vector()
                for (i in 1:length(data[,totct])) {
                        c[i] <- ifelse(data[,totct][i] >= i, 1, 0) 
                }      
                sum(c)
        }
        x <- data[,totct]
        cxz <- vector()
        for (i in 1:length(x)) {
                cxz[i] <- dhindex(data[order(runif(length(x))),])
        }
        q <- c(maximum = max(cxz), minimum = min(cxz), average = 
                       round(mean(cxz), 0))
        q
}

# Now(2014-10-20),unfortunately, I don't know what exactly its bibliometrical 
# meaning is.