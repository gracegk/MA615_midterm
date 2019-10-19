library(wbstats)
new_wb_cache <- wbcache()

wb_data <- wb(indicator = c("SP.URB.GROW", "SP.URB.TOTL", "EN.ATM.NOXE.KT.CE", "EN.ATM.CO2E.PC", 
                            "SH.MED.NUMW.P3", "SH.DYN.MORT", "SH.MED.PHYS.ZS"))
names(wb_data)

wb_countries <- wbcountries()
names(wb_countries)
wb_data <- merge(wb_data, y = wb_countries[c("iso2c", "region")], by = "iso2c", all.x = TRUE)
wb_data <- subset(wb_data, region != "Aggregates")

wb_data$indicatorID[wb_data$indicatorID == "SP.URB.GROW"] <- "Urban population growth (annual %)"
wb_data$indicatorID[wb_data$indicatorID == "SP.URB.TOTL"] <- "Urban population"
wb_data$indicatorID[wb_data$indicatorID == "EN.ATM.NOXE.KT.CE"] <- "Nitrous oxide (N2O) emissions, total (KtCO2e)"
wb_data$indicatorID[wb_data$indicatorID == "EN.ATM.CO2E.PC"] <- "CO2 emissions, total (KtCO2)"
wb_data$indicatorID[wb_data$indicatorID == "SH.MED.NUMW.P3"] <- "Nurses and midwives (per 1,000 people)"
wb_data$indicatorID[wb_data$indicatorID == "SH.DYN.MORT"] <- "Under-five mortality rate (per 1,000)"
wb_data$indicatorID[wb_data$indicatorID == "SH.MED.PHYS.ZS"] <- "Physicians (per 1,000 people)"

library(reshape2)
wb_data <- dcast(wb_data, iso2c + country + date ~ indicatorID, value.var = 'value')

perc_increase <- mutate((nextyear - thisyear)/thisyear)
lapply(wb_data$`Urban population`, )

dataxna <- wb_data[wb_data$date == "2006",] 
view(na.omit(dataxna))