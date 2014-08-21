run_analysis
============

Project for week three of session 6 of the getting and cleaning data coursera course from John Hopkins
###The data


The data is an snapshot of the data from the "Human Activity Recognition Using Smartphones Data Set" that can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* Note that the original data can be cound at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###The run_analysis.R script

This script contains 2 functions and example code for producing the 'tidy' data set

* run_analysis() - this function loads the data downloaded from the project. It merges the test and teh train data and reduces the information to only include information about the mean and standard deviation measurements. A dataframe containing this information is returned by the function

* tidy_dataset() - this function takes a single argument, the dataframe produced from run_analysis() and returns a dataframe containing the averages for the measurement for each activity type and for each subject.

Typically to use these functions in R 

Change the working directory to the location of the two sub directories train and test

* source("run_analysis.R")
+ this will load the two functions described above and will execute them
+ this will leave the output from run_analysys in a data.frame called X 
+ and the output from tidy_dataset(X) will be in td
+ the file tidy.txt will be written to the current working directory







