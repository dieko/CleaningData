## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Loads library reshape2, installs reshape2 if needed
if (!(require("reshape2", character.only=T, quietly=T))) {
        install.packages("reshape2")
        library("reshape2", character.only=T)
}

date <- date()
# Get the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
path_data <- file.path("./data" , "UCI HAR Dataset")


# Load and process Activity files (Y)
activity_test  <- read.table(file.path(path_data, "test" , "Y_test.txt" ),header = FALSE)
activity_train <- read.table(file.path(path_data, "train", "Y_train.txt"),header = FALSE)
# Load activity labels, only 2nd column is needed
activity_labels <- read.table(file.path(path_data, "activity_labels.txt"))[,2]
activity_test[,2] <- activity_labels[activity_test[,1]]
activity_train[,2] <- activity_labels[activity_train[,1]]
names(activity_test) <- c("Activity_ID", "Activity_Label")
names(activity_train) <- c("Activity_ID", "Activity_Label")
# bind activity data by row
activity_data<- rbind(activity_test, activity_train)
                              
# Load and process Subject files
subject_test  <- read.table(file.path(path_data, "test" , "subject_test.txt"),header = FALSE)
subject_train <- read.table(file.path(path_data, "train", "subject_train.txt"),header = FALSE)
names(subject_test) = "subject"
names(subject_train) = "subject"
# bind subject data by row
subject_data <- rbind(subject_test, subject_train)
                              
# Load and process Features files (X)
features_test  <- read.table(file.path(path_data, "test" , "X_test.txt" ),header = FALSE)
features_train <- read.table(file.path(path_data, "train", "X_train.txt"),header = FALSE)
# Load features, these will be used as column names, only 2nd column is needed
features <- read.table(file.path(path_data, "features.txt"))[,2]
# Only the mean and standard deviation of the measurements are needed
# Assumption is made that only variables containing "mean" or "std" are containing 
# mean or standard deviation values.
# Variable names containg "Mean" or "STD" are omitted
subset_features <- grepl("mean|std", features)
# Subsetting features data and names
features_test <- features_test[,subset_features]
features_train <- features_train[,subset_features]
features <- features[subset_features]
# The variable names are still containing invalid characters such as 
# parentheses and minus signs
# remove parentheses from features
features <- gsub("[()]","",features)
# replace minus signs by underscores
features <- gsub("-","_",features)
names(features_test) <- features
names(features_train) <- features

# bind features data by row
features_data <- rbind(features_test, features_train)
                                                     
# merge features_data, activity_data and subject_data by column
data <- do.call(cbind, list(features_data, activity_data, subject_data))

id_variables <- c("subject", "Activity_ID", "Activity_Label")
melt_data <- melt(data, id.vars = id_variables)
# Apply mean function to dataset using dcast function
tidy_data <- dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt")

                                                     
                                                     
                                                     