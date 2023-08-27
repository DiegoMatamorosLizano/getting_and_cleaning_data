Full description of the data set:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Location of the data set: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Contents of the data set:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Information about the features:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Cleaning steps
Utilizing dply library the following steps where performed:
1. Reading files from directory (where files downloaded where located) - read.table()
2. Merge training and test files - rbind() & cbind()
3. Select the columns required using contains("mean"), contains("std") functions
4. Renaming columns so can be more understendable using gsub() function
5. Preparing final dataset using group_by() and summarise_all()
6. Exporting resulting data set

For extra details please review the file named 'run_analysis.R' located in this repository
