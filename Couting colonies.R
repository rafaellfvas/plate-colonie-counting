install.packages("imager")
library(imager)

#uploading file 

plate <- "C:/Users/rafae/Desktop/R Test/bsubtilis.jpg"
plate1 <- load.image(plate)
plot (plate1)

#RGB Scalling 
plate.r<-R(plate1); plate.gr<-G(plate1); plate.b<-B(plate1)
explate<-plate.r-plate.gr- plate.b
plot(explate)

# blur before thresholding to fill some gaps
explate.blur <- isoblur(explate, 3)
explate.blur <- threshold(explate.blur, thr="auto", approx=FALSE, adjust=1.21)
plot(explate.blur)


# split into connected component and keep only colonies
ccs <- split_connected(explate.blur)
largeccs <- purrr::keep(ccs, function(x) {sum(x) > 10})

# count colonies
cat(sprintf("Number of colonies: %i\n" ,  length(largeccs))) 

result<-capture.output (cat(sprintf("Number of colonies: %i\n" ,  length(largeccs)))) 
result 

plot(explate.blur) 
title (result)


# criar loop

result <- c(result)
treatment <- c(1:100)
# data.frame 
df<- data.frame(treatment, result)

