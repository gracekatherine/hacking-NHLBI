## Split up large Framingham files into smaller ones
csv_name <- "phs000007.v22.pht003094.v1.p8.c1.e_exam_2011_m_0017s.HMB-IRB-MDS.csv"
data <- read.csv(csv_name)
data <- data[,1:548]

name_length <- nchar(csv_name) - 4
csv_name_short <- substr(csv_name, 1, name_length)
csv_name_1 <- paste(csv_name_short, "_1.csv", sep = "")
csv_name_2 <- paste(csv_name_short, "_2.csv", sep = "")
csv_name_3 <- paste(csv_name_short, "_3.csv", sep = "")
csv_name_4 <- paste(csv_name_short, "_4.csv", sep = "")

subset_1 <- data[,1:275]
subset_2 <- data[,c(1,2,276:548)]
subset_3 <- data[,c(1,2,842:1260)]
subset_4 <- data[,c(1,2,1500:1997)]

FileName <- rep(csv_name_1, nrow(subset_1))
subset_1 <- cbind(subset_1, FileName)

FileName <- rep(csv_name_2, nrow(subset_2))
subset_2 <- cbind(subset_2, FileName)

FileName <- rep(csv_name_3, nrow(subset_3))
subset_3 <- cbind(subset_3, FileName)

FileName <- rep(csv_name_4, nrow(subset_4))
subset_4 <- cbind(subset_4, FileName)

write.table(subset_1, file = csv_name_1, qmethod = "double", sep = ",", row.names = FALSE)
write.table(subset_2, file = csv_name_2, qmethod = "double", sep = ",", row.names = FALSE)
write.table(subset_3, file = csv_name_3, qmethod = "double", sep = ",", row.names = FALSE)
write.table(subset_4, file = csv_name_4, qmethod = "double", sep = ",", row.names = FALSE)
