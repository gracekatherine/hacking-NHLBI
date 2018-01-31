setwd("~/Desktop/work/2015-2018/HMS-DBMI/WHI.c1/XMLtoCSV/CSVFiles-v10")

## Split up large WHI file into 2 smaller ones
csv_name <- "phs000200.v10.pht002118.v4.p3.c1.ecg_rel2.HMB-IRB.csv"
name_length <- nchar(csv_name) - 4
csv_name_short <- substr(csv_name, 1, name_length)
csv_name_1 <- paste(csv_name_short, "_1.csv", sep = "")
csv_name_2 <- paste(csv_name_short, "_2.csv", sep = "")
data <- read.csv(csv_name)
data <- data[,1:653]

subset_1 <- data[,1:328]
subset_2 <- data[,c(1,2,329:653)]

FileName <- rep(csv_name_1, nrow(subset_1))
subset_1 <- cbind(subset_1, FileName)

FileName <- rep(csv_name_2, nrow(subset_2))
subset_2 <- cbind(subset_2, FileName)

write.table(subset_1, file = csv_name_1, qmethod = "double", sep = ",", row.names = FALSE)
write.table(subset_2, file = csv_name_2, qmethod = "double", sep = ",", row.names = FALSE)
