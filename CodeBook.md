### Getting and Cleaning Data Course Project
#### Code Book
Explanation of data source used for coursera Getting and Cleaning Data Course Project.
#### Data Source
The raw data used in this project represents summary statistics of linear acceleration and angular velocity measurements, each in 3 different directions, as recorded at 50Hz by a Samsung Galaxy SII smartphone worn on the waist. Apparently this device has an 'embedded accelerometer and gyroscope' which can record these numbers. The original raw data was collected, analysed and published by Anguita_et al_[1].
A group of 30 volunteers between 19-48 years each performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) whilst wearing the smartphone. Consequently the measurements are all classified by individual subject (identified by a number from 1 to 30) and by activity (as described). There are no NULL values in the dataset, if so they would presumably they would be classified as activity DEAD. 
The sensor signals were processed using all sorts of techniques of which I only have a vague understanding, presumably the data will allow your smartphone to know what you are doing and administor a short electric shock when your activity levels are too low (no doubt the frequency of shocks will be set to increase during work hours).
Further information on the raw data can be found here:
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#### Data Processing
#####Compilation and filtering
The raw data contains 561 columns of measurements this was reduced to 66 by selecting only mean and standard deviations of each measurement. Other measurement of mean in the raw data set were all means of derived values and so were not included in tidy data set.
Also included for each range of measures was the subject and the activity.
This resulted in a tidy data set with 68 columns: 

|    | names.tidy_data.      |
|----|-----------------------|
| 1  | Subject               |
| 2  | Activity              |
| 3  | tBodyAcc-mean-X       |
| 4  | tBodyAcc-mean-Y       |
| 5  | tBodyAcc-mean-Z       |
| 6  | tBodyAcc-std-X        |
| 7  | tBodyAcc-std-Y        |
| 8  | tBodyAcc-std-Z        |
| 9  | tGravityAcc-mean-X    |
| 10 | tGravityAcc-mean-Y    |
| 11 | tGravityAcc-mean-Z    |
| 12 | tGravityAcc-std-X     |
| 13 | tGravityAcc-std-Y     |
| 14 | tGravityAcc-std-Z     |
| 15 | tBodyAccJerk-mean-X   |
| 16 | tBodyAccJerk-mean-Y   |
| 17 | tBodyAccJerk-mean-Z   |
| 18 | tBodyAccJerk-std-X    |
| 19 | tBodyAccJerk-std-Y    |
| 20 | tBodyAccJerk-std-Z    |
| 21 | tBodyGyro-mean-X      |
| 22 | tBodyGyro-mean-Y      |
| 23 | tBodyGyro-mean-Z      |
| 24 | tBodyGyro-std-X       |
| 25 | tBodyGyro-std-Y       |
| 26 | tBodyGyro-std-Z       |
| 27 | tBodyGyroJerk-mean-X  |
| 28 | tBodyGyroJerk-mean-Y  |
| 29 | tBodyGyroJerk-mean-Z  |
| 30 | tBodyGyroJerk-std-X   |
| 31 | tBodyGyroJerk-std-Y   |
| 32 | tBodyGyroJerk-std-Z   |
| 33 | tBodyAccMag-mean      |
| 34 | tBodyAccMag-std       |
| 35 | tGravityAccMag-mean   |
| 36 | tGravityAccMag-std    |
| 37 | tBodyAccJerkMag-mean  |
| 38 | tBodyAccJerkMag-std   |
| 39 | tBodyGyroMag-mean     |
| 40 | tBodyGyroMag-std      |
| 41 | tBodyGyroJerkMag-mean |
| 42 | tBodyGyroJerkMag-std  |
| 43 | fBodyAcc-mean-X       |
| 44 | fBodyAcc-mean-Y       |
| 45 | fBodyAcc-mean-Z       |
| 46 | fBodyAcc-std-X        |
| 47 | fBodyAcc-std-Y        |
| 48 | fBodyAcc-std-Z        |
| 49 | fBodyAccJerk-mean-X   |
| 50 | fBodyAccJerk-mean-Y   |
| 51 | fBodyAccJerk-mean-Z   |
| 52 | fBodyAccJerk-std-X    |
| 53 | fBodyAccJerk-std-Y    |
| 54 | fBodyAccJerk-std-Z    |
| 55 | fBodyGyro-mean-X      |
| 56 | fBodyGyro-mean-Y      |
| 57 | fBodyGyro-mean-Z      |
| 58 | fBodyGyro-std-X       |
| 59 | fBodyGyro-std-Y       |
| 60 | fBodyGyro-std-Z       |
| 61 | fBodyAccMag-mean      |
| 62 | fBodyAccMag-std       |
| 63 | fBodyAccJerkMag-mean  |
| 64 | fBodyAccJerkMag-std   |
| 65 | fBodyGyroMag-mean     |
| 66 | fBodyGyroMag-std      |
| 67 | fBodyGyroJerkMag-mean |
| 68 | fBodyGyroJerkMag-std  |

##### Summarizing
The raw data contained over 10000 rows of measurements these were summarized by means of unique pairs of subject and activity to give a final total of 180 rows in the tidy data set.
Grouping was acheived by combined subject and activity into a single string to provide a unique identifier for each row. Means were calculated for all the measurements in each column for all rows of with the same combination of subject and activity. After calculating the means the identifier string was split back into seperate columns of Subject and Activity.

#### References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012