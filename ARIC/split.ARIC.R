## Split up large ARIC files into smaller ones
csv_name <- "phs000280.v3.pht004208.v1.p1.c1.UBMDALL.HMB-IRB.csv"
data <- read.csv(csv_name)
data <- data[,1:1330]

name_length <- nchar(csv_name) - 4
csv_name_short <- substr(csv_name, 1, name_length)
csv_name_1 <- paste(csv_name_short, "_1.csv", sep = "")
csv_name_2 <- paste(csv_name_short, "_2.csv", sep = "")
csv_name_3 <- paste(csv_name_short, "_3.csv", sep = "")

subset_1 <- data[,c(1,1330,2:444)]
subset_2 <- data[,c(1,1330,445:887)]
subset_3 <- data[,c(1,1330,888:1329)]

FileName <- rep(csv_name_1, nrow(subset_1))
subset_1 <- cbind(subset_1, FileName)

FileName <- rep(csv_name_2, nrow(subset_2))
subset_2 <- cbind(subset_2, FileName)

FileName <- rep(csv_name_3, nrow(subset_3))
subset_3 <- cbind(subset_3, FileName)

write.table(subset_1, file = csv_name_1, qmethod = "double", sep = ",", row.names = FALSE)
write.table(subset_2, file = csv_name_2, qmethod = "double", sep = ",", row.names = FALSE)
write.table(subset_3, file = csv_name_3, qmethod = "double", sep = ",", row.names = FALSE)
