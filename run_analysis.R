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
