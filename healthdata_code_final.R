#Start

library("dplyr")
library("data.table")
library("stringr")
library("ggplot2")
library("choroplethr")

#Read the data to dataframes



selcol = c("DRG Definition","Provider City","Provider State","Provider Zip Code",
           "Total Discharges","Average Covered Charges","Average Total Payments","Average Medicare Payments")


healthData <- fread("Inpatient_Prospective.csv", select = selcol)

 
healthData <- tbl_df(healthData)

#Deletes any rows with null's

na.omit(healthData)

#Assigning new column names 

colnames(healthData) <- c("DRG_Definition","City","State","Zip","Discharge","Covered_Charges","Avg_Cost","Total_Pay")

#Now removing the '$' symbol for the columns which has it

Covered_Charges <- as.numeric(gsub("$", "", healthData$Covered_Charges, fixed = TRUE))

Avg_Cost <- as.numeric(gsub("$", "", healthData$Avg_Cost, fixed = TRUE))

Total_Pay <- as.numeric(gsub("$", "", healthData$Total_Pay, fixed = TRUE))

#Now putting every thing in the dataframe

healthData_new <- data.frame(healthData[1],healthData[2],healthData[3],healthData[4],healthData[5],Covered_Charges,Avg_Cost,Total_Pay)

#Writting the dataframe to a csv file

write.csv2(healthData_new,"Inpatient_Prospective_new.csv",quote = FALSE, row.names = FALSE)

#plot diagram

g <- ggplot(healthData, aes(x= State , y= Discharge)) + scale_fill_hue(l=40) + geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1),
        panel.background = element_rect(fill = 'white' ))
g

#End