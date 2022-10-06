require(sf)
require(raster)
require(hsdar)
require(rgdal)
require(sf)

# read in base raster (what you want projection to be)

ref_raster <- raster("filename and path")

# read in rasters to be re-projected
my_list <- list.files("dir of files", pattern - regex)
my_stack <- stack(my_list)

#ref_CRS <- CRS(ref_raster)
ref_CRS <- CRS(ref_raster)
my_stack_reproj <- spTransform(my_stack, ref_CRS)


#remove temporary files
removeTmpFiles(h = 0)

#sanity check part 1

ref_CRS == CRS(my_stack_reproj)

# should return TRUE

# sanity check part 2

plot(ref_raster, 1)
plot(my_stack_reproj, 1, add = TRUE)