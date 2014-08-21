# Function name : run_analysis
#
# Parameters : none
#
# Version : 1.0
#
# Date : 2014-08-21
#
# Description : This function reads in the supplied files for the 
#               "Human Activity Recognition Using Smartphones Data Set "
#               URL = http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#               And merges the test and training data sets, returning the 
#               data for standard deviation and mean for each dataset


run_analysis <- function () {
    
    
    # loading and combining to get X
    X_train <- read.table("train/X_train.txt")
    X_test <- read.table("test/X_test.txt")
    X <- rbind (X_train, X_test)
    
    # clean up
    rm(X_train)
    rm(X_test)
    
    # load the features table to get the variable names
    features <- read.table("features.txt")
    
    # getting the columns for mean and standard deviation
    col_ints <- grep("mean|std", as.character(features[,2]))
    col_chars <- grep("mean|std", as.character(features[,2]), value = TRUE)
    
    # Subsetting to get the required columns
    X <- X[,col_ints]
    
    # setting the column names
    names(X) <- col_chars
    
    # loading and merging to get y activity indicator 
    y_train <- read.table("train/y_train.txt")
    y_test <- read.table("test/y_test.txt")
    y <- rbind (y_train, y_test)
    
    # clean up
    rm(y_test)
    rm(y_train)
    
    # load the activity names
    activity <- read.table("activity_labels.txt")
    
    # Add the activity names to the target data set
    X["Activity"] <- factor(x=as.character(y[,1]), labels=activity[,2])
    
    # Subject
    # loading and merging to get subject  
    subject_train <- read.table("train/subject_train.txt")
    subject_test <- read.table("test/subject_test.txt")
    subject <- rbind (subject_train, subject_test)
    
    X["Subject"] <- subject
    
    # Return the data set
    X
}

# Function name : tidy_dataset
#
# Parameters : dataframe from the run_analysis function
#
# Version : 1.0
#
# Date : 2014-08-21
#
# Description : This function reads in output of the run_analysis function as 
#               an input and represents the data, averaging the data per 
#               measurement type for each activity and for each subject

tidy_dataset <- function (X) {
    
    # Split the input dataset into its seperate activity components
    spList <- split(X, X$Activity)
    
    # for each component calculate the mean and combine into the target dataset
    for (i in seq_along(names(spList))) {
        # the mean for the activity
        meanlist <- unlist(lapply(spList[[i]][1:79], mean))
        
        if (i==1) {
            # create the target data set
            td <- meanlist    
        } else {
            # add the next activity to the data set
            td <- cbind(td, meanlist)            
        }       
    }
    
    # Store the activity column names
    activityNames<-names(spList)
    
    # Split the input dataset into its seperate subject components 
    spList <- split(X, X$Subject)
    
    # for each component calculate the mean and combine into the target dataset
    for (i in seq_along(names(spList))) {
        # the mean for the activity
        meanlist <- unlist(lapply(spList[[i]][1:79], mean))
        
        # add the next activity to the data set
        td <- cbind(td, meanlist)            
               
    }
    
    # Store the subject column names
    subjectNames<-names(spList)
    
    # combine the column names
    namelist <- c(activityNames, subjectNames)
    
    # Add the column names
    colnames(td) <- namelist
    
    # return the tidy dataset
    td 
} 

# get the mean / std subset of the data
X <- run_analysis()

# get the tidy data subset
td <- tidy_dataset(X)

# write the tidy dataset to disk
write.table(td, "tidy.txt", row.names = FALSE)



