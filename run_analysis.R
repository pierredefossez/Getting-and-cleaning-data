library(reshape2)

##Download and unzip the files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!exists("./data/activity.zip")) {
        download.file(fileUrl, destfile = "activity.zip", method="curl")    
}

if (!exists("UCI HAR dataset")) {
        unzip("./activity.zip")
}

measurements <- read.table("./UCI HAR Dataset/features.txt")[,2]
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Select only the mean and SD values
keep <- grepl("-mean|-std", measurements)
keep_names <- measurements[keep]

#Merge training and test datasets
data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")[keep]
data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")[keep]
all_data <- rbind(data_train, data_test)

#Attach activity list
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
all_y <- rbind(y_train, y_test)
all_data <- cbind (all_y, all_data)

#Attach subject list
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
all_subject <- rbind(subject_train, subject_test)
all_data <- cbind (all_subject, all_data)

#Simplify the value names
keep_names <- measurements[keep]
keep_names <- gsub("[-()]", "", keep_names)
keep_names <- gsub("mean", " Mean", keep_names)
keep_names <- gsub("std", " StDev", keep_names)

#Attach colum names
colnames(all_data) <- c("subject", "activity", keep_names)

#Assign text description to activity category
all_data$activity <- factor(all_data$activity, levels = activities[,1], labels = activities[,2])

#Average of each variable for each activity and each subject.
all_data.melted <- melt(all_data, id = c("subject", "activity"))
all_data.mean <- dcast(all_data.melted, subject + activity ~ variable, mean)

#Write output file
write.table(all_data.mean, "output.txt", row.names=FALSE)
