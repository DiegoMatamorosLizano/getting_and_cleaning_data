##Course Project
#Script to clean and organize data 

#Data for this script is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library(dplyr)

#Getting column names
features <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/features.txt", col.names = c("count","functions"))
activities <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/activity_labels.txt", col.names = c("codes", "activities"))

#Reading training data
subject_train <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/train/y_train.txt", col.names = "codes")

#Reading test data
subject_test <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/test/y_test.txt", col.names = "codes")

#Merging data sets
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)
final <- cbind(subject_merged, y_merged, x_merged)

#Extracting mean and standard deviation for each measurement
stats_final <- final %>% 
  select(subject, codes, contains("mean"), contains("std"))

#Assigning activity names
stats_final$codes <- activities[stats_final$codes, 2]
names(stats_final)[1] = "Subject"
names(stats_final)[2] = "Activities"

#Renaming activities
names(stats_final)<-gsub("-mean()", "Mean", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("-std()", "Std Dev", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("-freq()", "Freq", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("mean", "Mean", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("std", "Std Dev", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("freq", "Freq", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("angle", "Angle", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("gravity", "Gravity", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("tBodyAccJerk", "T.Body Acc Jerk", names(stats_final))
names(stats_final)<-gsub("tBodyAccJerkMag", "T.Body Acc Jerk Mag", names(stats_final))
names(stats_final)<-gsub("tBodyAccMag", "T.Body Acc Mag", names(stats_final))
names(stats_final)<-gsub("tGravityAccMag", "T.Gravity Acc Mag", names(stats_final))
names(stats_final)<-gsub("tBodyAcc", "T.Body Acc", names(stats_final))
names(stats_final)<-gsub("tGravityAcc", "T.Gravity Acc", names(stats_final))
names(stats_final)<-gsub("tBodyGyroJerk", "T.Body Gyro Jerk", names(stats_final))
names(stats_final)<-gsub("tBodyGyroJerkMag", "T.Body Gyro Jerk Mag", names(stats_final))
names(stats_final)<-gsub("tBodyGyroMag", "T.Body Gyro Mag", names(stats_final))
names(stats_final)<-gsub("tBodyGyro", "T.Body Gyro", names(stats_final))
names(stats_final)<-gsub("fBodyBodyAccJerkMag", "Freq Body Acc Jerk Mag", names(stats_final))
names(stats_final)<-gsub("fBodyAccJerk", "Freq Body Acc Jerk", names(stats_final))
names(stats_final)<-gsub("fBodyAccMag", "Freq Body Acc Magnitude", names(stats_final))
names(stats_final)<-gsub("fBodyAcc", "Freq Body Acc", names(stats_final))
names(stats_final)<-gsub("fBodyBodyGyroMag", "Freq Body Gyro Mag", names(stats_final))
names(stats_final)<-gsub("fBodyGyro", "Freq Body Gyro", names(stats_final))
names(stats_final)<-gsub("fBodyBodyGyroJerkMag", "Freq Body Gyro Jerk Mag", names(stats_final))
names(stats_final)<-gsub("fBodyBodyGyroJerkMag", "Freq Body Gyro Jerk Mag", names(stats_final))

#New data set with the average by activity and subject
grouped_final <- stats_final %>%
  group_by(Subject, Activities) %>%
  summarise_all(mean)

#Export results
write.table(grouped_final, "/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/smartphone_act_grouped.txt", row.name=FALSE)
