###
# Creates Estonian county countour map with two lakes (Peisi and Võrtsjärv),
# capital (Tallinn) and some counties labeled.
# Map will be saved as PDF.
### 
# Teeb Eesti maakondade kontuurkaardi, koos kahe järve (Peipijärv ja VÕrtsjärv),
# pealinnaga (Tallinn) ja mõned maakonnad on eraldi märgitud.
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
output_file = "estonia_contout_estonia"


###
# CODE ------------------------------------------
###

# Download data
est0 <- getData('GADM', country='EST', level=0)
est1 <- getData('GADM', country='EST', level=1)
est2 <- getData('GADM', country='EST', level=2)


# Plot Estonia
plot(est0)

# Plot all counties with ligth grey
plot(est1,add=TRUE, col="grey97")

# Plot wanted counties with darker grey
plot(est1[est1$NAME_1 %in% counties,], add=TRUE, col="grey")

# Plot Tallinn with red
plot(est2[20,], add=TRUE, col="red")

# Plot lakes with ligth blue
plot(est1[est1$NAME_1 %in% c("Peipsi"),], add=TRUE, col="skyblue")
plot(est2[est2$NAME_2 %in% c("Võrtsjärve"),], add=TRUE, col="skyblue")

# Add labels
label_size = 4
for (i in 1:length(counties)) {
  text(coordinates(est1[est1$NAME_1 == counties[i],]),
       labels = paste(counties[i],"maa",sep="") #
       ,cex=label_size)
}  
text(coordinates(est2[20,])+c(0.45,0), labels=c("Tallinn"), cex=label_size)

# Save as PDF
dev.copy2pdf(file = paste(output_file,".pdf",sep=""), width=23.38, height=16.54)
png(paste(output_file,".png",sep=""))
dev.off()