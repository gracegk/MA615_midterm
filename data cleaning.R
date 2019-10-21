library(wbstats)
library(tidyverse)
library(knitr)
library(magrittr)
library(esquisse)
library(rattle)

new_wb_cache <- wbcache()

wb_data <- wb(country = c("USA", "MEX", "SWE", "GHA", "KOR", "PHL", "AUS", "RUS"), 
  indicator = c("NY.GDP.PCAP.CD", "SP.DYN.LE00.IN", "SP.DYN.IMRT.IN", 
  "SP.URB.GROW", "SP.URB.TOTL", "EN.ATM.NOXE.KT.CE", "EN.ATM.CO2E.PC", 
  "SH.MED.NUMW.P3", "SH.DYN.MORT", "SH.MED.PHYS.ZS"))
names(wb_data)

wb_countries <- wbcountries()
names(wb_countries)

wb_data <- merge(wb_data, y = wb_countries[c("iso2c", "region")], by = "iso2c", all.x = TRUE)
wb_data <- subset(wb_data, region != "Aggregates")

wb_data$indicatorID[wb_data$indicatorID == "NY.GDP.PCAP.CD"] <- "GDP"
wb_data$indicatorID[wb_data$indicatorID == "SP.DYN.LE00.IN"] <- "life_expectancy"
wb_data$indicatorID[wb_data$indicatorID == "SP.DYN.IMRT.IN"] <- "infant_mortality"
wb_data$indicatorID[wb_data$indicatorID == "SP.URB.GROW"] <- "urban_pop_growth_pct"
wb_data$indicatorID[wb_data$indicatorID == "SP.URB.TOTL"] <- "urban_pop"
wb_data$indicatorID[wb_data$indicatorID == "EN.ATM.NOXE.KT.CE"] <- "n2o_emission"
wb_data$indicatorID[wb_data$indicatorID == "EN.ATM.CO2E.PC"] <- "co2_emission"
wb_data$indicatorID[wb_data$indicatorID == "SH.MED.NUMW.P3"] <- "nurses_midwives_per_1000"
wb_data$indicatorID[wb_data$indicatorID == "SH.DYN.MORT"] <- "under5_mortality_per_1000"
wb_data$indicatorID[wb_data$indicatorID == "SH.MED.PHYS.ZS"] <- "physicians_per_1000"

library(reshape2)
wb_data <- dcast(wb_data, iso2c + country + date + region ~ indicatorID, value.var = 'value')

#take out iso2c, region columns
wb_data <- wb_data[,c(2:3, 5:14)]
#change class of date from character to numeric
wb_data$date <- as.numeric(wb_data$date)
data <- na.omit(wb_data)

save(data, file = "/Users/home/Documents/MSSP Fall 2019/MA615/MA615_midterm/Clean_WB_data.RData")



#esquisser(wb_data)
#esquisser(data)