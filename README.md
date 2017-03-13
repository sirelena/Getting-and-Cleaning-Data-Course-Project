

# Getting And Cleaning Data Course Project
Repository containing:  
  
* a README file: README.md (this file)
* a script for performing the analysis: run_analysis.R
* a tidy data set: tidyData.txt
* a code book: CodeBook.md

***

## Objective of the analysis script
run_analysis.R does the following:  
  
1. Downloads the data set from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
2. Merges the training and the test sets to create one data set.  
3. Extracts only the measurements on the mean and standard deviation for each measurement.  
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names.  
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

***

## Requirements

* Use of package dplyr  
* Internet connection for downloading the data set

***

## Script intructions
For using run_analysis.R the steps are:  
  
1. download run_analysis.R to your working path  
2. Load run_analysis.R with: source("run_analysis.R")  
3. Execute the main function without any variables: run_analysis()  
4. The functions returns the tidy data dataframe and stores it as "tidyData.txt"  


***


## Instructions to read the tidydata.txt

Command: read.table("tidyData.txt",header=TRUE)


***

## Functions in the script

### getFiles(url)
Downloads the zip from the given url file and extracts it

### mergeData()
Gets the data from the extrated txt files and merges it

### getDataAverage(data_merged)
Gets tidy data set with the average of each variable for each activity and each subject

***

## More information about the original data set

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

