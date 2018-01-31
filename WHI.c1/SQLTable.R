setwd("~/Desktop/Work/2014-2018/HMS-DBMI/WHI.c1/XMLtoCSV")

txt_files <- list.files(path = "./PhenotypeFiles-v10", pattern = "txt")

TableName <- c()
FileName <- c()

for (i in 1:9) {
      TableName_i <- paste("WHI.v10c1_data_00", i, sep = "")
      FileName_i <- txt_files[i]
      TableName <- c(TableName, TableName_i)
      FileName <- c(FileName, FileName_i)
}

for (i in 10:99) {
      TableName_i <- paste("WHI.v10c1_data_0", i, sep = "")
      FileName_i <- txt_files[i]
      TableName <- c(TableName, TableName_i)
      FileName <- c(FileName, FileName_i)
}

for (i in 100:125) {
      TableName_i <- paste("WHI.v10c1_data_", i, sep = "")
      FileName_i <- txt_files[i]
      TableName <- c(TableName, TableName_i)
      FileName <- c(FileName, FileName_i)
}

table_final <- cbind(TableName, FileName)

write.table(table_final, file = "SQL_table.csv", qmethod = "double", row.names = FALSE, sep = ",")
