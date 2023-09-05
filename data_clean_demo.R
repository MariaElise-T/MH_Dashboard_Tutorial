library(readxl)

#####################################################
# Treatment Facilities Data Prep
#####################################################

TreatmentFacilities_1 <- read_excel("Desktop/FindTreament_Facility_listing_2023_09_05_244410.xlsx")
TreatmentFacilities_2 <- read_excel("Desktop/FindTreament_Facility_listing_2023_09_05_244433.xlsx")

# Start by concatenating

TreatmentFacilities <- rbind(TreatmentFacilities_1, TreatmentFacilities_2)


