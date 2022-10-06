require(tictoc)

x = 1:10
y = 11:20

# Create a SpatRaster from a file
f <- system.file("ex/elev.tif", package="terra")
r <- rast(f)
r

m <- as.matrix(r, nrow = 90, ncol = 1)

r2 <- rast(m)
