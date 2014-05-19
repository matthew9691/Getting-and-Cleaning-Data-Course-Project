setwd("/Users/matthew/RProject")
library(plyr)
# import raw data files
# assumes download file is already 'unzipped' in R working directory"
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

# import features.txt which lists the column headings
features <- read.table("features.txt")

# Select only data columns containing '-mean()' or '-std()' in features:
# NOTE specifically excluded features with 'Mean' as they are
# derived measurements not the mean or std of actual measurements
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

