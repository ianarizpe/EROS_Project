install.packages("terrra")

require(sf)
#require(raster)

require(hsdar)
require(rgdal)
require(terra)
require(sf)
library(conflicted)

# read in base raster (what you want projection to be)
baseRaster <- list.files("Z:/Projects/iot4Ag/Outputs/SfM/PFarm-7-13-2022-all/odm_orthophoto", full.names=T)
baseRaster <- c(baseRaster[[1]])
baseRaster <- rast(baseRaster[[1]])


# read in rasters to be re-projected
hyperList <- list.files("Z://Data/Raster/Nano-Hyperspec/raw_cubes/100082_pistachio_07132022_2022_07_13_18_57_25",pattern="multi_or_line", full.names=T)
projectedList <- list() #empty list to pour reprojected data in


#stack hyperspec
hyperStack <- c(hyperList)
#hyperStack <- terra::rast(hyperStack[[1]])
extraStack <- c()


#Grab the base Projection
ref_CRS <- terra::crs(baseRaster)


#reproject into veg indexes 

avl <- c("NDVI")
vi <- vegindex(hyperStack, index=avl)




#  [Loop] stack raster in each loop, then project it. Proceed to move onto next object in list
for (i in 1:length(hyperList)) {
  print(i)
  extraStack<- c(hyperStack[[i]])
  extraStack<- (extra
  #Reproject from phantom drone to hyperspec (REMEMBER TO ADD METHOD!)
  hyperspecProject <- terra::project(extraStack,baseRaster)

  projectedList <- append(projectedList, hyperspecProject)
    
}


#remove temporary files
removeTmpFiles(h = 0)

#sanity check part 1

crs(baseRaster) == crs(hyperspecProject)


compareCRS(baseRaster, tryingProject)

# should return TRUE
# sanity check part 2

em = merge(extent(baseRaster), extent(tryingProject[[1]]))
plot(em, type="n")
plot(baseRaster,add=TRUE, legend=FALSE)
plot(tryingProject[[1]], add=TRUE, legend=FALSE)





plot(baseRaster, 1)
plot(tryingProject, 1, add = TRUE)