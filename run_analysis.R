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
names(stats_final)<-gsub("-std()", "Std Deviation", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("-freq()", "Frequency", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("mean", "Mean", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("std", "Std Deviation", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("freq", "Frequency", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("angle", "Angle", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("gravity", "Gravity", names(stats_final), ignore.case = TRUE)
names(stats_final)<-gsub("tBodyAccJerk", "Time Body Acceleration Jerk", names(stats_final))
names(stats_final)<-gsub("tBodyAccJerkMag", "Time Body Acceleration Jerk Mag", names(stats_final))
names(stats_final)<-gsub("tBodyAccMag", "Time Body Acceleration Magnitude", names(stats_final))
names(stats_final)<-gsub("tGravityAccMag", "Time Gravity Acceleration Magnitude", names(stats_final))
names(stats_final)<-gsub("tBodyAcc", "Time Body Acceleration", names(stats_final))
names(stats_final)<-gsub("tGravityAcc", "Time Gravity Acceleration", names(stats_final))
names(stats_final)<-gsub("tBodyGyroJerk", "Time Body Gyroscope Jerk", names(stats_final))
names(stats_final)<-gsub("tBodyGyroJerkMag", "Time Body Gyroscope Jerk Magnitude", names(stats_final))
names(stats_final)<-gsub("tBodyGyroMag", "Time Body Gyroscope Magnitude", names(stats_final))
names(stats_final)<-gsub("tBodyGyro", "Time Body Gyroscope", names(stats_final))
names(stats_final)<-gsub("fBodyBodyAccJerkMag", "Frequency Body Acceleration Jerk Magnitude", names(stats_final))
names(stats_final)<-gsub("fBodyAccJerk", "Frequency Body Acceleration Jerk", names(stats_final))
names(stats_final)<-gsub("fBodyAccMag", "Frequency Body Acceleration Magnitude", names(stats_final))
names(stats_final)<-gsub("fBodyAcc", "Frequency Body Acceleration", names(stats_final))
names(stats_final)<-gsub("fBodyBodyGyroMag", "Frequency Body Gyroscope Magnitude", names(stats_final))
names(stats_final)<-gsub("fBodyGyro", "Frequency Body Gyroscope", names(stats_final))
names(stats_final)<-gsub("fBodyBodyGyroJerkMag", "Frequency Body Gyroscope Jerk Magnitude", names(stats_final))
names(stats_final)<-gsub("fBodyBodyGyroJerkMag", "Frequency Body Gyroscope Jerk Magnitude", names(stats_final))

#New data set with the average by activity and subject
grouped_final <- stats_final %>%
  group_by(Subject, Activities) %>%
  summarise_all(mean)

#Export results
write.table(grouped_final, "/Users/diegomatamoroslizano/Desktop/Desktop/Training/R/UCI HAR Dataset/smartphone_act_grouped.txt", row.name=FALSE)
