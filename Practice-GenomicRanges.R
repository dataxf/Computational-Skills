# Lecture notes "Working with Range Data" - March 30, 2017
# Install packages
source("http://bioconductor.org/biocLite.R")
biocLite()

biocLite("GenomicRanges")
library(IRanges)

# Ranges are created as "IRange Objects" by specifying start and end sites:
rng <- IRanges(start=4, end=13)
rng

# Ranges can also be created using vector arguments:
rng2 <- IRanges(start=4, width=3)
rng2

x <- IRanges(start=c(4, 7, 2, 20), end=c(13, 7, 5, 23))
x

# And we can give these ranges names:
names(x) <- letters[1:4]
x

# a special object with class IRanges:
class(x)

# increment one of these component
end(x) <- end(x) + 4
x

# range() function can also be used to inspect the entire length of all ranges 
range(x)

# subsets of ranges
x[2:3]
start(x) < 5
x[start(x) < 5]
x[width(x) > 8]

# merge ranges
a <- IRanges(start=7, width=4)
b <- IRanges(start=2, end=5)
c <- c(a, b)
c

# IRanges objects can be grown (+) or shrunk (-)
x <- IRanges(start=c(40, 80), end=c(67, 114))
x + 4L
x - 10L