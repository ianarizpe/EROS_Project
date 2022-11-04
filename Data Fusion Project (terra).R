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

install.packages("terrra")


require(raster)
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
baseRaster <- terra::rast(baseRaster[[1]])


# read in rasters to be re-projected
hyperList <- list.files("Z://Data/Raster/Nano-Hyperspec/raw_cubes/100082_pistachio_07132022_2022_07_13_18_57_25",pattern="multi_or_line", full.names=T)
hyperList = hyperList[-grep("hdr", hyperList)] #cut list so that it leaves outfiles we dont need
projectedList <- list()                        #empty list to pour reprojected data in


#stack hyperspec
hyperStack <- c(hyperList)
extraStack <- c()


#Grab the base Projection
ref_CRS <- terra::crs(baseRaster)


#create speclib
vegtest <- raster::brick(hyperStack[[1]])

vegtest2 <- raster::stack(hyperStack)
vegtest2 <- as.matrix(vegtest2)
 #vegtest <- raster::brick(vegtest)
#vegtest <- as.matrix(extraStack[[1]])

refrence <- raster::stack(hyperStack[[1]])

wv  <- names(refrence)
wv <-  as.numeric(substr(wv, 2,5))

vegspec <- speclib(vegtest,  wv )

#reproject into veg indexes 
avl <- vegindex()
vi <- vegindex(vegspec, "NDVI")




#[Loop] stack raster in each loop, then project it. Proceed to move onto next object in list
for (i in seq(from = 1, to = 18, by = 2)) {
  print(i)
  
  #remove from list and change from character to raster
  extraStack<- terra::rast(hyperStack[[i]])
  
  #Reproject from phantom drone to hyperspec (REMEMBER TO ADD METHOD!)
  hyperspecProject <- terra::project(extraStack,baseRaster)
  
  #write raster to hard drive writeRaster(hypersceProject, "dir/file.tif")
  # close raster from R session
  
  #remove temp files inside loop  
}

#if you want a list of your rasters, you can point to dir that you save them in in above loop, and make list of fnmaes (don't make a list of actual rasters way too big)
#projectedList <- append(projectedList, hyperspecProject)

#remove temporary files
unlink(paste0(normalizePath(tempdir()), "/", dir(tempdir())), recursive = TRUE)

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