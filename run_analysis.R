## call the required package
library(plyr)

## Step 1

## read the sets / tests
X_train <- read.table("/Users/Mario/Documents/UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("/Users/Mario/Documents/UCI HAR Dataset/train/subject_train.txt")
Y_train <- read.table("/Users/Mario/Documents/UCI HAR Dataset/train/y_train.txt")

X_test <- read.table("/Users/Mario/Documents/UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("/Users/Mario/Documents/UCI HAR Dataset/test/subject_test.txt")
Y_test <- read.table("/Users/Mario/Documents/UCI HAR Dataset/test/y_test.txt")

## merge
X_data <- rbind(X_train, X_test)
subject_data <- rbind(subject_train,subject_test)
y_data <- rbind(Y_train,Y_test)

## Step 2

## extract the mean and standard deviation for each measurement
features <- read.table("features.txt")
meanstd <- grep("-(mean|std)\\(\\)", features[,2])

## subsetting
X_data <- X_data[, meanstd]
names(X_data) <- features[meanstd, 2]

## Step 3

## use descriptive names 
activities <- read.table("activity_labels.txt")
y_data [,1] <- activities[y_data[,1],2]
names(y_data) <- "activity"

## Step 4

## label the data with descriptive variables
names(subject_data) <- "subject"
all_data <- cbind(X_data, y_data, subject_data)

## Step 5

## tidy data
averages_data <- dply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)
