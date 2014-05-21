# R Script for compiling and tidying data as part of
# Peer Reviewed Course Project for
# coursera Getting and Cleaning Data Short Course
# May 2014
library(plyr)
library(data.table)

# import raw data files
# assumes downloaded data file is already 'unzipped' into R working directory
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# import features.txt which lists the column headings
features <- read.table("./UCI HAR Dataset/features.txt")

# Select only data columns containing '-mean()' or '-std()':
# NOTE I have specifically excluded features with 'Mean' as they are
# derived measurements and not the mean or std of actual measurements
# which is how I interpret the requirement 2 of the project
X_test <- X_test[,grep("mean\\()|std\\()",features$V2)]  
X_train <- X_train[,grep("mean\\()|std\\()",features$V2)] 

# combine the test and training sets for 'X', 'y' and 'subject'
X_combined <- rbind(X_test,X_train)
y_combined <- rbind(y_test,y_train)
subject_combined <- rbind(subject_test,subject_train)

# Subset the feature descriptions to use as the column names
columnHeadings <- subset(features, grepl("mean\\()|std\\()",features$V2)==TRUE)
colnames(X_combined) <- as.character(columnHeadings$V2)

# Replace y_combined Activity code with correct Activity descriptor
Activity <- function(x) {
        if(x == 1) y <- "WALKING"
        if(x == 2) y <- "WALKING_UPSTAIRS"
        if(x == 3) y <- "WALKING_DOWNSTAIRS"
        if(x == 4) y <- "SITTING"
        if(x == 5) y <- "STANDING"
        if(x == 6) y <- "LAYING"
        return(y)
}
y_combined$V1 <- sapply(y_combined$V1,Activity)

# Adding an Activity column to the X_combined data
colnames(y_combined) <- c("Activity")
data_yX <- cbind(y_combined,X_combined)

# Adding a Subject column and then sorting to provide a final completed dataset:
colnames(subject_combined) <- c("Subject")
data_complete <- cbind(subject_combined,data_yX)
data_complete <- arrange(data_complete,Activity)
data_complete <- arrange(data_complete,Subject)

# Combine Subject and Activity into a combined identifier
Subject.Activity <- interaction(data_complete$Subject,data_complete$Activity)
data_complete <- cbind(Subject.Activity,data_complete[,3:68])

# Calculate mean of groups by combinations of Subject and Activity
data_complete2 <- data.table(data_complete)
data_complete3 <- data_complete2[, lapply(.SD, mean), by = Subject.Activity]
data_complete4 <- as.data.frame(data_complete3)

# Seperate back out the Subject and Activity into different columns to satisfy
# one of the tidy data requirements
SA.List <- strsplit(as.character(data_complete4[,1]),".",fixed=TRUE) 
Subject <- sapply(SA.List, "[[", 1)
Activity <- sapply(SA.List, "[[", 2)

# Combine all columns into final dataset 
tidy_data <- cbind(Subject,Activity,data_complete4[,2:67])

# Simplify the column label text to remove duplicatation and extra characters
names(tidy_data) <- gsub("BodyBody","Body",names(tidy_data),)
names(tidy_data) <- gsub("\\()","",names(tidy_data),)

# Write tidy data to file:
write.table(tidy_data, file = "tidy_data.txt", quote=FALSE, row.names = FALSE)