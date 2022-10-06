require(sf)
require(raster)
require(terra)
require(hsdar)
require(rgdal)
require(sf)
require(tictoc)

# read in base raster (what you want projection to be)
baseRaster <- list.files("Z:/Projects/iot4Ag/Outputs/SfM/PFarm-7-13-2022-all/odm_orthophoto", full.names=T)
baseRaster <- stack(baseRaster[[1]])
# read in rasters to be re-projected


hyperList <- list.files("Z://Data/Raster/Nano-Hyperspec/raw_cubes/100082_pistachio_07132022_2022_07_13_18_57_25",pattern="multi_or_line", full.names=T)

#hyperstack <- stack(hyperList)

tic()
for(x in 2:18){
  if((x %% 2) == 0){
  }
  else{
    hyperstack <- stack(hyperList[[x]])
  }}
  
toc()

my_stack <- stack(hyperstack)

ref_CRS <- crs(baseRaster)

#my_stack_reproj <- spTransform(my_stack, ref_CRS)
my_stack_reproj <- projectRaster(my_stack, ref_CRS)

tryingProject <-  projectRaster(my_stack, crs = ref_CRS)

#remove temporary files
removeTmpFiles(h = 0)

#sanity check part 1

ref_CRS == CRS(my_stack_reproj)

ref_CRS == CRS(new_crs_myrasterlist)
# should return TRUE

# sanity check part 2

plot(ref_raster, 1)
plot(my_stack_reproj, 1, add = TRUE)