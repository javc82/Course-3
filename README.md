# Course-3
Getting and Cleaning Data Course Project

Jason C. 

This README.md file shows the data script and explains how it works.

First, there is an explanation of the assignment. 
Second, there is an explanation of the data, as provided in the original README.txt file: 
Third, I provide the code which is also provided in the run_analysis.R file: 

FIRST: 

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.



Second, the data script: 

# FIRST, we will merge the training and test data sets together

library(plyr)
setwd("~/Data Science Coursera/Class 3/UCI HAR Dataset/train")

# I ended-up not using the download file, but if I did it would be: 

if(!file.exists("./Data Science Coursera/Class 3")){dir.create("./UCI HAR Dataset")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Data Science Coursera/Class 3/UCI HAR Dataset.zip",method="curl")
unzip(zipfile="./Data Science Coursera/Class 3/UCI HAR Dataset.zip",exdir="./data")


# We have 3 data sets in the zipfile that need to be read out for the train
# sets and 3 data sets for the test sets. 


x_train <- read.table("~/Data Science Coursera/Class 3/UCI HAR Dataset/train/x_train.txt", quote="\"")
y_train <- read.table("~/Data Science Coursera/Class 3/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("~/Data Science Coursera/Class 3/UCI HAR Dataset/train/subject_train.txt", quote="\"")


setwd("~/Data Science Coursera/Class 3/UCI HAR Dataset/test")

x_test <- read.table("~/Data Science Coursera/Class 3/UCI HAR Dataset/test/x_test.txt", quote="\"")
y_test <- read.table("~/Data Science Coursera/Class 3/UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_test <- read.table("~/Data Science Coursera/Class 3/UCI HAR Dataset/test/subject_test.txt", quote="\"")

# Next, we need to create the data sets that combine the x_, y_, and subject_ sub-sets

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# SECOND, we want an R script that: 
#"Extracts only the measurements on the mean and standard deviation for each measurement." 

# Need to go up a level to get to tge features info 

setwd("~/Data Science Coursera/Class 3/UCI HAR Dataset")

features <- read.table("features.txt")
features

# Next, we need to get only the columns with mean() or std()

mean_std <- grep("-(mean|std)\\(\\)", features[, 2])

# Next, we subset the columns we want in the x_data
x_data <- x_data[, mean_std]

# Next, we examine the column names 

# correct the column names
names(x_data) <- features[mean_std, 2]

# next, check out the structure of the data set we created
str(x_data)

# It is 10299 observations of 66 variables 

# THIRD, we will "Use descriptive activity names to name the activities in the data set
# we are still in the higher-level folder 

activitynames <- read.table("activity_labels.txt")

# Use the corrected activity names in the y data
y_data[, 1] <- activitynames[y_data[, 1], 2]

# Use the corrected column name for activity
names(y_data) <- "activity"

# Check the data
head(activitynames)
head(y_data)

head(y_data$activity,30)


# FOURTH,
# "Appropriately label the data set with descriptive variable names"

names(subject_data)<-gsub("^t", "time", names(subject_data))
names(subject_data)<-gsub("^f", "frequency", names(subject_data))
names(subject_data)<-gsub("Acc", "Accelerometer", names(subject_data))
names(subject_data)<-gsub("Gyro", "Gyroscope", names(subject_data))
names(subject_data)<-gsub("Mag", "Magnitude", names(subject_data))
names(subject_data)<-gsub("BodyBody", "Body", names(subject_data))

names(subject_data) <- "subject"

# Bind all of the data together 

all_data <- cbind(x_data, y_data, subject_data)
all_data

# reaches max print when running all_data; omitted 10152 rows

# FINALLY,
# "Create a second, independent tidy data set with the average 
# of each variable for each activity and each subject

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)

averages_data
