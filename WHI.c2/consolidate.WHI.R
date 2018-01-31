## Consolidate WHI files
setwd("~/Desktop/work/HMS-DBMI/WHI.c2/XMLtoCSV")

## Establish two groups: data dictionary files and children files
## NB: list lengths are unequal because "phs000200.v10.pht001032.v7.WHI_Sample.data_dict.csv"
## has no children, so "phs000200.v10.pht001032.v7.WHI_Sample.data_dict_Children.csv" was deleted
children_files <- list.files(path = "./CSVFiles-v10", pattern = "Children")
dict_files <- list.files(path = "./CSVFiles-v10", pattern = "data_dict")
dict_files <- dict_files[!(dict_files %in% children_files)]

## Consolidate all data dictionaries into a single table, including original file names
n = length(dict_files)
all_dict = c()
for (i in 1:n) {
      options(warn = 1)
      print(i)
      file_name = c()
      file_name_i <- dict_files[i]
      file_path <- paste("./CSVFiles-v10/", file_name_i, sep = "")
      dict_i <- read.csv(file_path)
      file_name_i <- rep(file_name_i, nrow(dict_i))
      file_name = c(file_name, file_name_i)
      dict_i <- cbind(dict_i, file_name)
      all_dict <- rbind(all_dict, dict_i)
}
write.table(all_dict, file = "all_dict.csv", qmethod = "double", row.names = FALSE, sep = ",")

## Consolidate all children into a single table, including original file names.
n = length(children_files)
all_children = c()
for (i in 1:n) {
      options(warn = 1)
      print(i)
      file_name = c()
      file_name_i <- children_files[i]
      file_path <- paste("./CSVFiles-v10/", file_name_i, sep = "")
      children_i <- read.csv(file_path)
      file_name_i <- rep(file_name_i, nrow(children_i))
      file_name = c(file_name, file_name_i)
      children_i <- cbind(children_i, file_name)
      all_children <- rbind(all_children, children_i)
}

write.table(all_children, file = "all_dict_children.csv", qmethod = "double", row.names = FALSE, sep = ",")
