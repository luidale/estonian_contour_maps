###
# Creates Estonian county countour map with two lakes (Peisi and VC?rtsjC?rv),
# capital (Tallinn) and some counties labeled.
# Map will be saved as PDF.
### 
# Teeb Eesti maakondade kontuurkaardi, koos kahe jC?rve (PeipijC?rv ja VC?rtsjC?rv),
# pealinnaga (Tallinn) ja mC?ned maakonnad on eraldi mC?rgitud.
# Kaart salvestatakse PDF-na.
##

library(raster)

###
# INPUT -----------------------------------------
###

# Counties to label
counties = c("Põlva","Võru","Valga")
# Counties available:
# Harju, Hiiu, Ida-viru, Jõgeva, Järva, Lääne, Lääne-Viru, Põlva, Pärnu, Rapla,
# Saare, Tartu, Valga, Viljandi, Võru,

# Output file
output_file = "estonia_county_contour"


###
# CODE ------------------------------------------
###

# Download data
est0 <- getData('GADM', country='EST', level=0)
est1 <- getData('GADM', country='EST', level=1)
est2 <- getData('GADM', country='EST', level=2)
lat0 <- getData('GADM', country='LVA', level=0)
rus0 <- getData('GADM', country='RUS', level=0)
rus1 <- getData('GADM', country='RUS', level=1)
rus2 <- getData('GADM', country='RUS', level=2)

# Plot Estonia
plot(est0)

# Plot Russia
plot(rus0, add=TRUE)

# Plot Latvia
plot(lat0, add=TRUE)

# Plot all counties with ligth grey
plot(est1,add=TRUE, col="grey97")

# Plot wanted counties with darker grey
plot(est1[est1$NAME_1 %in% counties,], add=TRUE, col="grey")

# Plot Tallinn with red
plot(est2[20,], add=TRUE, col="red")

# Plot lakes with ligth blue
plot(est1[est1$NAME_1 %in% c("Peipsi"),], add=TRUE, col="skyblue")
plot(est2[est2$NAME_2 %in% c("Võrtsjärve"),], add=TRUE, col="skyblue")
plot(rus2[rus2$NAME_2 %in% c("Pskov"),], add=TRUE, col="skyblue")

# Add labels
## Selected counties
label_size = 4
for (i in 1:length(counties)) {
  text(coordinates(est1[est1$NAME_1 == counties[i],]),
       labels = paste(counties[i],"",sep="") #
       ,cex=label_size)
}  
## Tallinn
text(coordinates(est2[20,])+c(0.45,0), labels=c("Tallinn"), cex=label_size)
## Latvia
text(coordinates(lat0)+c(0.45,0.7), labels=c("Latvia"), cex=label_size)
## Russia
text(coordinates(lat0)+c(2,2), labels=c("Russia"), cex=label_size, srt=90)
text(coordinates(lat0)+c(2.5,1.8), labels=c("Russia"), cex=label_size, srt=90)
text(coordinates(lat0)+c(3,1.6), labels=c("Russia"), cex=label_size, srt=90)

# Save as PDF
saveToPDF <- function(...) {
  d = dev.copy(pdf,...)
  dev.off(d)
}

saveToPNG <- function(...) {
  d = dev.copy(png,...)
  dev.off(d)
}

#dev.copy2pdf(file = paste(output_file,".pdf",sep=""), )
#dev.off()

saveToPDF(paste(output_file,".pdf",sep=""),width=23.38, height=16.54)
saveToPNG(paste(output_file,".png",sep=""),width=2400, height=1600)
