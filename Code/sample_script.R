library(readxl)

##############################
# File Import
##############################

SAMHSA_facilities <- read_excel("C:/Users/met48/Desktop/MH_Dashboard_Tutorial/Data/FindTreament_Facility_listing_2023.xlsx")
Local_MH_authorities <- read_excel("C:/Users/met48/Desktop/MH_Dashboard_Tutorial/Data/Local_MH_authorities.xlsx")
Hospitals <- read.csv("C:/Users/met48/Desktop/MH_Dashboard_Tutorial/Data/Hospital_General_Information.csv")
LCDC <- read_excel("C:/Users/met48/Desktop/MH_Dashboard_Tutorial/Data/Supply Tables for LCDC.xlsx")
LPC <- read_excel("C:/Users/met48/Desktop/MH_Dashboard_Tutorial/Data/Supply Tables for LPC.xlsx")
Psychiatrists <- read_excel("C:/Users/met48/Desktop/MH_Dashboard_Tutorial/Data/Supply Tables for Psychiatrists.xlsx")

###################################
# Cleaning - MH Authorities
###################################

# We want a row for each county.  If a MH authority covers 8 counties, it will appear 8 times in the dataset, and each county will appear once

# We will start with a list of counties from the LPC dataset

counties <- LPC[,"COUNTY"]

# Now we need consistent capitalization in county names so the computer can match them

counties$COUNTY = toupper(counties$COUNTY)
Local_MH_authorities$Counties <- toupper(Local_MH_authorities$Counties)

# Now we will iterate through the counties, and for each county check all MH authorities to find a match

for(i in 1:nrow(counties)){
  for(j in 1:nrow(Local_MH_authorities)){
    if(grepl(counties[i,1], Local_MH_authorities[j,'Counties'], fixed=TRUE)==TRUE){
      counties[i,2] = Local_MH_authorities[j,1]
    }
  }
}
  
counties

###################################
# Cleaning - SAMHSA Facilities
###################################



###################################
# Cleaning - Emergency Rooms
###################################

# We want to keep the first 11 columns of data

Hospitals <- Hospitals[,1:11]

# We only want Texas hospitals

Hospitals_TX <- Hospitals[which(Hospitals$State=='TX'),]

# We only want hospitals with emergency services

Hospitals_TX <- Hospitals_TX[which(Hospitals_TX$Emergency.Services=='Yes'),]

###################################
# Cleaning - Health Professionals
###################################

# We want to keep the number of professionals and ratio of professionals per 100k for each dataset

LCDC <- LCDC[,c("COUNTY", "PROFESSION COUNT", "RATIO 100K POPULATION TO PROFESSION")]
colnames(LCDC) = c("COUNTY", "LCDC COUNT", "LCDC per 100k")

LPC <- LPC[,c("COUNTY", "PROFESSION COUNT", "RATIO 100K POPULATION TO PROFESSION")]
colnames(LPC) = c("COUNTY", "LPC COUNT", "LPC per 100k")

Psychiatrists <- Psychiatrists[,c("COUNTY", "PROFESSION COUNT", "RATIO 100K POPULATION TO PROFESSION")]
colnames(Psychiatrists) = c("COUNTY", "PSYCHIATRIST COUNT", "PSYCHIATRISTS per 100k")

# we want to merge on FIPS and county name

Professionals <- merge(LCDC, LPC, by=c("COUNTY"))
Professionals <- merge(Professionals, Psychiatrists, by=c("COUNTY"))

