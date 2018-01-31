## Consolidate ARIC files
setwd("~/Desktop/work/HMS DBMI/ARIC")

## Establish two groups: data dictionary files and children files
## NB: list lengths are unequal because "phs000280.v3.pht001441.v3.ARIC_Sample.data_dict.csv"
## has no children, so "phs000280.v3.pht001441.v3.ARIC_Sample.data_dict_Children.csv" was deleted
## Other files deleted for the same reason:
## "phs000280.v3.pht004041.v1.BPU01.data_dict_Children.csv"
## "phs000280.v3.pht004105.v1.HHXCOD22.data_dict_Children.csv"
## "phs000280.v3.pht004154.v1.RHXCOD05.data_dict_Children.csv"
## "phs000280.v3.pht004155.v1.RHXCOD32.data_dict_Children.csv"
## "phs000280.v3.pht004156.v1.RHXCOD42.data_dict_Children.csv"
## "phs000280.v3.pht004165.v1.RTABF25.data_dict_Children.csv"
## "phs000280.v3.pht004166.v1.RTABF34.data_dict_Children.csv"
## "phs000280.v3.pht004167.v1.RTABF42.data_dict_Children.csv"
## "phs000280.v3.pht004169.v1.RTABM25.data_dict_Children.csv"
## "phs000280.v3.pht004170.v1.RTABM34.data_dict_Children.csv"
## "phs000280.v3.pht004171.v1.RTABM42.data_dict_Children.csv"
## "phs000280.v3.pht004172.v1.RTASBF24.data_dict_Children.csv"
## "phs000280.v3.pht004173.v1.RTASBF33.data_dict_Children.csv"
## "phs000280.v3.pht004174.v1.RTASBF42.data_dict_Children.csv"
## "phs000280.v3.pht004175.v1.RTASBM24.data_dict_Children.csv"
## "phs000280.v3.pht004176.v1.RTASBM33.data_dict_Children.csv"
## "phs000280.v3.pht004177.v1.RTASBM42.data_dict_Children.csv"
## "phs000280.v3.pht004178.v1.RTASWF24.data_dict_Children.csv"
## "phs000280.v3.pht004179.v1.RTASWF33.data_dict_Children.csv"
## "phs000280.v3.pht004180.v1.RTASWF42.data_dict_Children.csv"
## "phs000280.v3.pht004181.v1.RTASWM24.data_dict_Children.csv"
## "phs000280.v3.pht004182.v1.RTASWM33.data_dict_Children.csv"
## "phs000280.v3.pht004183.v1.RTASWM42.data_dict_Children.csv"
## "phs000280.v3.pht004185.v1.RTAWF25.data_dict_Children.csv"
## "phs000280.v3.pht004186.v1.RTAWF34.data_dict_Children.csv"
## "phs000280.v3.pht004187.v1.RTAWF42.data_dict_Children.csv"
## "phs000280.v3.pht004189.v1.RTAWM25.data_dict_Children.csv"
## "phs000280.v3.pht004190.v1.RTAWM34.data_dict_Children.csv"
## "phs000280.v3.pht004191.v1.RTAWM42.data_dict_Children.csv"
## "phs000280.v3.pht004209.v1.UBMDBF02.data_dict_Children.csv"
## "phs000280.v3.pht004210.v1.UBMDBM02.data_dict_Children.csv"
## "phs000280.v3.pht004211.v1.UBMDWF02.data_dict_Children.csv"
## "phs000280.v3.pht004212.v1.UBMDWM02.data_dict_Children.csv"
## "phs000280.v3.pht004214.v1.UBMEBF4.data_dict_Children.csv"
## "phs000280.v3.pht004215.v1.UBMEBM4.data_dict_Children.csv"
## "phs000280.v3.pht004216.v1.UBMEWF4.data_dict_Children.csv"
## "phs000280.v3.pht004217.v1.UBMEWM4.data_dict_Children.csv"
## "phs000280.v3.pht004219.v1.UBMFBF02.data_dict_Children.csv"
## "phs000280.v3.pht004220.v1.UBMFBM02.data_dict_Children.csv"
## "phs000280.v3.pht004221.v1.UBMFWF02.data_dict_Children.csv"
## "phs000280.v3.pht004222.v1.UBMFWM02.data_dict_Children.csv"
## "phs000280.v3.pht004224.v1.UBMGBF01.data_dict_Children.csv"
## "phs000280.v3.pht004225.v1.UBMGBM01.data_dict_Children.csv"
## "phs000280.v3.pht004226.v1.UBMGWF01.data_dict_Children.csv"
## "phs000280.v3.pht004227.v1.UBMGWM01.data_dict_Children.csv"
## "phs000280.v3.pht004232.v1.V2ECG.data_dict_Children.csv"
## "phs000280.v3.pht004233.v1.V3ECG.data_dict_Children.csv"

children_files <- list.files(path = "./CSVFiles", pattern = "Children")
dict_files <- list.files(path = "./CSVFiles", pattern = "data_dict")
dict_files <- dict_files[!(dict_files %in% children_files)]

## Consolidate all data dictionaries into a single table, including original file names
n = length(dict_files)
all_dict = c()
for (i in 1:n) {
      options(warn = 1)
      print(i)
      file_name = c()
      file_name_i <- dict_files[i]
      file_path <- paste("./CSVFiles/", file_name_i, sep = "")
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
      file_path <- paste("./CSVFiles/", file_name_i, sep = "")
      children_i <- read.csv(file_path)
      file_name_i <- rep(file_name_i, nrow(children_i))
      file_name = c(file_name, file_name_i)
      children_i <- cbind(children_i, file_name)
      all_children <- rbind(all_children, children_i)
}
write.table(all_children, file = "all_dict_children.csv", qmethod = "double", row.names = FALSE, sep = ",")
