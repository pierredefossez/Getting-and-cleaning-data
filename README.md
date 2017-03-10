# Getting-and-cleaning-data

This is the final assignment for the Getting and Cleaning Data course. 

The run_analysis script will:

    Download and unzip the dataset 
    Extract the activity and variable information
    Create a logical vector to identify the variables that are either mean or SD
    Read the corresponding values in the training and test sets, and merge these two
    Append the subject and activity columns to the data set
    Simplify the activity names and attach these names to the data
    Transform the activity label to a descriptive text
    Melt and cast the large dataset to return an output file containing the average of each measurement, for each activity and each subject
