# Getting and Cleaning Data Course Project
# Author: Zainab Umay

# Load libraries
library(dplyr)

# Download and unzip dataset if needed
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url, destfile = "dataset.zip")

unzip("dataset.zip")

# Read activity labels
activity_labels <- read.table(
  "UCI HAR Dataset/activity_labels.txt",
  col.names = c("activity_id", "activity")
)

# Read feature names
features <- read.table(
  "UCI HAR Dataset/features.txt",
  col.names = c("feature_id", "feature_name")
)

# Clean feature names
features$feature_name <- gsub("\\(", "", features$feature_name)
features$feature_name <- gsub("\\)", "", features$feature_name)
features$feature_name <- gsub("-", "", features$feature_name)
features$feature_name <- gsub(",", "", features$feature_name)

# Read training data
train_subject <- read.table(
  "UCI HAR Dataset/train/subject_train.txt",
  col.names = "subject"
)

train_activity <- read.table(
  "UCI HAR Dataset/train/y_train.txt",
  col.names = "activity_id"
)

train_data <- read.table(
  "UCI HAR Dataset/train/X_train.txt"
)

# Read testing data
test_subject <- read.table(
  "UCI HAR Dataset/test/subject_test.txt",
  col.names = "subject"
)

test_activity <- read.table(
  "UCI HAR Dataset/test/y_test.txt",
  col.names = "activity_id"
)

test_data <- read.table(
  "UCI HAR Dataset/test/X_test.txt"
)

# Assign feature names
colnames(train_data) <- features$feature_name
colnames(test_data) <- features$feature_name

# Merge training and testing datasets
train <- cbind(train_subject, train_activity, train_data)
test <- cbind(test_subject, test_activity, test_data)

merged_data <- rbind(train, test)

# Extract only mean and standard deviation measurements
mean_std_columns <- grep(
  "mean|std",
  colnames(merged_data),
  value = TRUE
)

tidy_data <- merged_data %>%
  select(subject, activity_id, all_of(mean_std_columns))

# Replace activity IDs with descriptive activity names
tidy_data <- tidy_data %>%
  left_join(activity_labels, by = "activity_id") %>%
  select(subject, activity, everything(), -activity_id)

# Create descriptive variable names
names(tidy_data) <- gsub("^t", "time", names(tidy_data))
names(tidy_data) <- gsub("^f", "frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("mean", "Mean", names(tidy_data))
names(tidy_data) <- gsub("std", "STD", names(tidy_data))

# Create second tidy dataset with averages
final_tidy_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise(
    across(
      everything(),
      mean
    ),
    .groups = "drop"
  )

# Save tidy dataset
write.table(
  final_tidy_data,
  "tidy_data.txt",
  row.names = FALSE
)