
# INSTRUCTIONS: 
# Here are the data for the project:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each 
# measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.



library(dplyr) # We work with the dplyr library

run_analysis <- function(){
  url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  # download the zip file and extract it
  getFiles(url)
  # get the data from the extrated files and merge it
  data_merged <- mergeData()
  # Get tidy data set with the average of each variable for each activity and each subject
  data_average <- getDataAverage(data_merged)
  
  #save the tidy data
  write.table(data_average, file = "tidyData.txt", row.names = FALSE)
  
  #Returns tidy data.frame with the average grouped
  data_average
  
}

#download the zip file and extract it
getFiles <- function(url){
  # download the data from the source
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data_cleaning.zip")
  #Unzip the data
  unzip("data_cleaning.zip")
}

# get the data from the extrated files and merge it
mergeData<- function(){
  # Set the path for the archives we have to use
  path <- "./UCI HAR Dataset"
  path_features <- paste(path, "features.txt", sep="/")
  path_activity_labels <- paste(path, "activity_labels.txt", sep="/")
  path_dataX_test <- paste(path, "/test/X_test.txt", sep="")
  path_datay_test <- paste(path, "/test/y_test.txt", sep="")
  path_subject_test <- paste(path, "/test/subject_test.txt", sep="")
  path_dataX_train <- paste(path, "/train/X_train.txt", sep="")
  path_datay_train <- paste(path, "/train/y_train.txt", sep="")
  path_subject_train <- paste(path, "/train/subject_train.txt", sep="")  
  
  ## Get Label data
  # get the feature table
  features <- read.table(path_features) %>% 
    select(id=V1, feature_label = V2) # change the names to be descriptive
  # get the activity labels table
  activity_labels <- read.table(path_activity_labels) %>%
    select(id=V1, activity_label=V2)
  
  ## Get Test data
  # get the X test data table with the names in features and we select just mean and std columns
  dataX_test <- read.table(path_dataX_test, col.names = features$feature_label) %>%
    select(contains("mean"), contains("std"))
  
  # get the Y test data table and merge with the activity_labels
  dataY_test <- read.table(path_datay_test, col.names = "id_activity") %>%
    merge(activity_labels,by.x="id_activity", by.y = "id")
  
  # get the subject test data and change column name to subject
  dataSubject_test <- read.table(path_subject_test,col.names = "subject")
  
  
  # Merge all the test data
  data_test <- cbind(dataSubject_test,dataY_test,dataX_test)
 
  ## Get Train data
  # get the X train data table with the names in features and we select just mean and std columns
  dataX_train <- read.table(path_dataX_train, col.names = features$feature_label)%>%
    select(contains("mean"), contains("std"))
  
  # get the Y test data table and merge with the activity_labels
  dataY_train <- read.table(path_datay_train, col.names = "id_activity")%>%
    merge(activity_labels,by.x="id_activity", by.y = "id")
  
  # get the subject train data and change column name to subject
  dataSubject_train <- read.table(path_subject_train,col.names = "subject")
  
  ## Merge data
  # Merge all the train data
  data_train <- cbind(dataSubject_train,dataY_train,dataX_train)
  
  # Merge train and test data
  data <- rbind(data_test, data_train)

}

# Get tidy data set with the average of each variable for each activity and each subject
getDataAverage <- function(data){
  # calculate the mean by subject and activity
  data_average <- aggregate(data[4:89],list(data$subject, data$activity_label),mean) %>%
    # change group columns names
    rename(subject=Group.1, activity=Group.2) %>% 
    # order the table by subject number
    arrange(subject)
  
}
