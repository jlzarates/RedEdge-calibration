##Set WD 
setwd("H:/Ximena/MSc Thesis/Results")
#setwd("D:/Google Drive/MSc Thesis/Results")

###Load libraries
library(raster)
library(ggplot2)


##Load files
#DLS
Exif<-read.csv("./UAV imagery/Lonnstorp/2017_03_24/Micasense/Flight_2/000/2017_03_24_2_Lonnstorp_EXIF.csv", header=T)
head(Exif)



#Load images
T.img.path<- list.files(path=("./UAV imagery/Lonnstorp/2017_03_24/Micasense/Flight_2/000"), (pattern=".tif$"), 
                        full.names=T) #List images

T.img<- lapply(T.img.path,raster) #Load all bands
names(T.img)<-T.img.path


#Sun elevation angle correction

for (i in 1:length(T.img))   
{
  T.img[[i]]<-T.img[[i]]* (sin(Exif$SunA[i]*pi/180))
  writeRaster(T.img[[i]],paste0("./UAV imagery/Lonnstorp/2017_03_24/Micasense/Flight_2/SEA/",
                                substr(names(T.img[i]),59,68),".tif"), datatype="INT2U",
              options="COMPRESS=NONE", overwrite=T)  
}


#End
###################################################################################################################













##################################################################################################################
datetime<-"2017-02-23 14:13:59 CEST" #date of the measurement
DOY<-DateToDOY(datetime)  #numeric vector containing the coverted date in Day Of the Year (DOY).
