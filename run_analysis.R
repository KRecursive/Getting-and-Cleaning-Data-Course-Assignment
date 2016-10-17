##Load the libraries
library(reshape2); library(dplyr)

## Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "f:/getdata_dataset.zip"
download.file(url, filename)
unzip(filename) 

## Unclutter workspace and delete downloaded zip file
rm(url)
rm(filename)
unlink("f:/getdata_dataset.zip", recursive = TRUE, force = FALSE)

## Load features and activities
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])

## Extract mean and standard deviation for each measurement
mstd <- grep(".*mean.*|.*std.*", features[,2])
MSTD <- features[mstd,2]
MSTD <- gsub('[()]', '', MSTD)
MSTD <- gsub('-', '', MSTD)

## Load the the train and test datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[mstd]
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train <- cbind(train_subjects, train_activities, train)
test <- read.table("UCI HAR Dataset/test/X_test.txt")[mstd]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

## Merge the train and test datasets with labels
data <- rbind(train, test)
colnames(data) <- c("subject", "activity", MSTD)

## Coerce subjects and activities to become factors
data$activity <- factor(data$activity, levels = activities[,1], labels = activities[,2])
data$subject <- as.factor(data$subject)

## Make the final tidy dataset
DATA <- melt(data, id = c("subject", "activity"))
DATAmeans <- dcast(DATA, subject + activity ~ variable, mean)
write.table(DATAmeans, "finaldata.txt", row.names = FALSE, quote = FALSE)



