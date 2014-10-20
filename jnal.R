# This is a simple function to count how many articles one researcher has 
# published on some important journals.

jnal <- function(x) {
        j <- vector() 
        for (i in 1:length(x$source))  j[i] <- ifelse(x$source[i] == "SCIENCE" | x$source[i] == "NATURE" | x$source[i] == "NATURE CELL BIOLOGY" | x$source[i] == "NATURE REVIEWS GENETICS" | x$source[i] == "NATURE REVIEWS MOLECULAR CELL BIOLOGY" | x$source[i] == "PROCEEDINGS OF THE NATIONAL ACADEMY OF SCIENCES OF THE UNITED STATES OF AMERICA" | x$source[i] == "CELL" | x$source[i] == "NATURE STRUCTURAL & MOLECULAR BIOLOGY" | x$source[i] == "JOURNAL OF THE AMERICAN CHEMICAL SOCIETY" | x$source[i] == "MOLECULAR CELL" | x$source[i] == "NATURE BIOTECHNOLOGY" | x$source[i] == "NATURE CHEMICAL BIOLOGY" | x$source[i] == "NATURE CLINICAL PRACTICE ONCOLOGY" | x$source[i] == "NATURE COMMUNICATIONS" | x$source[i] == "NATURE GENETICS" |x$source[i] == "NATURE IMMUNOLOGY" | x$source[i] == "NATURE MEDICINE" | x$source[i] == "NATURE METHODS" | x$source[i] == "NATURE NEUROSCIENCE" | x$source[i] == "NATURE PROTOCOLS" | x$source[i] == "NATURE REVIEWS CANCER" | x$source[i] == "NATURE REVIEWS MICROBIOLOGY" | x$source[i] == "NATURE STRUCTURAL BIOLOGY" | x$source[i] == "NEURON" | x$source[i] == "NEW ENGLAND JOURNAL OF MEDICINE", 1 , 0) 
        return(sum(j))
}
