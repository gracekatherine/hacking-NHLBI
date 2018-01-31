## Read in WHI files
## NB: "phs000200.v10.pht001032.v7.WHI_Sample.data_dict.csv" has no children, so
## "phs000200.v10.pht001032.v7.WHI_Sample.data_dict_Children.csv" was deleted
setwd("~/Desktop/work/2015-2018/HMS DBMI/WHI")
library(XML)

## Create list of all text and XML data files in WHI cohort
txt_files <- list.files(path = "./PhenotypeFiles", pattern = "txt")
xml_files <- list.files(path = "./PhenotypeFiles", pattern = "xml")
num_files = length(txt_files)

## Convert all text and XML data files to individual CSV format
## Export output to new folder entitled "CSV Files"
for (i in 1:num_files) {
      options(warn = 1)
      print(i)
      ## Establish file naming conventions for text data
      txt_name_old = txt_files[i]
      txt_num = nchar(txt_name_old) - 4
      txt_name = substr(txt_name_old, 1, txt_num)
      txt_path_old = paste("./PhenotypeFiles/", txt_name_old, sep = "")
      txt_name_new = paste(txt_name, ".csv", sep = "")
      txt_path_new = paste("./CSVFiles/", txt_name_new, sep = "")
      
      ## Convert .txt to .csv format, export result to new folder entitled "CSV Files"
      txt_data <- read.delim(txt_path_old, comment.char = "#")
      FileName <- rep(txt_name_new, nrow(txt_data))
      txt_data <- cbind(txt_data, FileName)
      write.table(txt_data, file = txt_path_new, qmethod = "double", sep = ",", row.names = FALSE)

      ##Establish file naming conventions for XML data
      xml_name = xml_files[i]
      xml_num = nchar(xml_name) - 4
      xml_name_short = substr(xml_name, 1, xml_num)
      xml_name_old = paste("./PhenotypeFiles/", xml_name, sep = "")
      xml_name_new = paste("./CSVFiles/", xml_name_short, ".csv", sep = "")
      
      ## Read in XML data
      xml_data <- xmlTreeParse(xml_name_old, useInternalNodes = TRUE)
      rootNode <- xmlRoot(xml_data)
      
      ## Eliminate unnecessary top-level nodes (i.e. unique_keys),
      ## leaving us with only the variables to work with!
      xml_variables <- getNodeSet(xml_data, "//variable")
      num_variables <- length(xml_variables)
      variables_end <- length(names(rootNode))
      variables_start <- variables_end - num_variables + 1
      
## Convert variables and children to data frames, export to CSV(s)
      child_name = c()
      child_desc = c()
      child_value = c()
      for (j in variables_start:variables_end) {
            ## Create new tree with jth variable as top-level
            node <- rootNode[[j]]
            xml_node <- xmlDoc(node)
            
      ## Format first 3 children of jth variable as a data frame,
      ## export as CSV file.
            name = xpathSApply(xml_data, "//name", xmlValue)
            description = xpathSApply(xml_data, "//description", xmlValue)
            type = xpathSApply(xml_data, "//type", xmlValue)
            
            xml_df = cbind(name, description, type)
            write.table(xml_df, file = xml_name_new, qmethod = "double", row.names = FALSE, sep = ",")
            
            ## Establish number of variables with more than 3 children.
            ## If extra_children = 0, then the variable in question
            ## only has 3 children ("name", "description" and "type"),
            ## and thus has no additional ones to be parsed out.
            num_children = length(names(node))
            extra_children = num_children - 3L
            if (num_children == 3) {
                  next
            }
            
      ## Format extra children to data frame(s), export to CSV file.
            num = j - variables_start + 1
            name2 = rep(name[num], extra_children)
            
            ## Parse out attributes for encoded values
            node_codes <- getNodeSet(xml_node, "//value")
            if (length(node_codes) != 0) {
                  desc2 = xpathSApply(xml_node, "//value", xmlValue)
                  desc2 = gsub(",",";",desc2)
                  value2 = xpathSApply(xml_node, "//value", xmlAttrs)
                  
                  if ("comment" %in% names(node)) {
                        desc2 = c(desc2, "comment")
                        value3 = xpathSApply(xml_node, "//comment", xmlValue)
                        value2 = c(value2, value3)
                  }
                  if ("logical_min" %in% names(node)) {
                        desc2 = c(desc2, "logical_min")
                        value3 = xpathSApply(xml_node, "//logical_min", xmlValue)
                        value2 = c(value2, value3)
                  }
                  if ("logical_max" %in% names(node)) {
                        desc2 = c(desc2, "logical_max")
                        value3 = xpathSApply(xml_node, "//logical_max", xmlValue)
                        value2 = c(value2, value3)
                  }
                  if ("unit" %in% names(node)) {
                        desc2 = c(desc2, "unit")
                        value3 = xpathSApply(xml_node, "//unit", xmlValue)
                        value2 = c(value2, value3)
                  }
            }
            
            ## Parse out all other values as they are
            else {
                  desc2 = xmlSApply(node, xmlName)[4:num_children]
                  value2 = xmlSApply(node, xmlValue)[4:num_children]
            }
            child_name <- c(child_name, name2)
            child_desc <- c(child_desc, desc2)
            child_value <- c(child_value, value2)
      }
      
      children_df = cbind(child_name, child_desc, child_value)
      children_name = paste("./CSVFiles/", xml_name_short, "_Children.csv", sep = "")
      write.table(children_df, file = children_name, qmethod = "double", row.names = FALSE, sep = ",")
}