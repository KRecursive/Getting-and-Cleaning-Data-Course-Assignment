##Load the libraries
library(reshape2); library(dplyr)

## Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "f:/getdata_dataset.zip"
download.file(url, filename)
unzip(filename) 

##Unclutter workspace and delete downloaded zip file
rm(url)
rm(filename)
unlink("f:/getdata_dataset.zip", recursive = TRUE, force = FALSE)

