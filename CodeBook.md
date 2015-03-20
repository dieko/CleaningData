# CodeBook

This code book that describes the the data, variables, and transformations or work that are performed to clean up the data.
The analysis uses the open source software R [1] and R package reshape2 [2]
 
[1] R Core Team (2014). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL http://www.R-project.org/.
  
[2] Hadley Wickham (2007). Reshaping Data with the reshape Package. Journal of Statistical Software, 21(12), 1-20. URL http://www.jstatsoft.org/v21/i12/.


## The data source

    Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Data Set Information

Use of this dataset in publications must be acknowledged by referencing the following publication:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


### The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The files in folders 'train/subject_train.txt' and 'train/Inertial Signals/total_acc_x_train.txt' are not used in this assignment.


## Transformation details


### The R script called run_analysis.R does the following:
- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement.
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Downloading and unzipping raw data

Used variables  | contains
------------- | -------------
fileUrl  | url of file to download
path_data  | location of raw data files
date_download  | date of download


### Load and process Activity files (Y)
 
Used variables  | contains
------------- | -------------
activity_test  | y_test data
activity_train  | y_train data
activity_labels  | activity labels
activity_data  | merged activity data (test and train)

Activity_ID and Activity_Label are used as variable names for dataframe activity_data


### Load and process Subject files
 
Used variables  | contains
------------- | -------------
subject_test  | subject_test data
subject_train  | subject_train data
subject_data  | merged subject data (test and train)

subject is used as variable name fot dataframe subject_data


### Load and process Features files (X)
 
Used variables  | contains
------------- | -------------
features_test  | X_test data
features_train  | X_train data
subset_features  | logical variable;TRUE's for mean and std containing features
features  | used as column names
features_data  | merged features data (test and train)

The content of features.txt contains characters which are not supported by R as valid column names (see ?make.names). In stead of using the R function make.names() which replaces invalid characters by dots, I chose to remove the parentheses and replace the minus signs by underscores.


### Merge features_data, activity_data and subject_data by column

Used variables  | contains
------------- | -------------
data  | merged features_data, activity_data and subject_data by column


### Independent tidy data set with the average of each variable for each activity and each subject

Used variables  | contains
------------- | -------------
id_variables  | non-measure variables, used for R function melt() (package rshape2)
melt_data  | long format representation of data
tidy_data  | wide format representation of data with the average of each variable for each activity and each subject







 


