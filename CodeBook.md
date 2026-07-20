# Code Book

## Dataset Description

This dataset was created from the UCI Human Activity Recognition Using Smartphones Dataset.

The original dataset contains measurements collected from accelerometers and gyroscopes from Samsung Galaxy S smartphones worn by participants performing six activities.

The purpose of this project was to merge training and testing datasets, clean the variables, and create a tidy dataset containing the average measurements for each subject and activity.

---

## Variables

### subject
The ID of the participant who performed the activity.

### activity
The activity performed by the participant:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

### Measurement Variables

Only variables containing measurements of the mean and standard deviation were retained.

Examples include:

- Accelerometer Mean measurements
- Accelerometer STD measurements
- Gyroscope Mean measurements
- Gyroscope STD measurements

---

## Transformations Performed

1. Loaded training and testing datasets.
2. Combined subject, activity, and measurement data.
3. Merged training and testing datasets into one dataset.
4. Selected only mean and standard deviation measurements.
5. Replaced activity IDs with descriptive activity names.
6. Renamed variables to make them more descriptive.
7. Created a second tidy dataset containing the average of each measurement for every subject and activity.
8. Exported the final dataset as tidy_data.txt.

---

## Output Dataset

The final dataset contains one row for each subject/activity combination and the average values of each measurement variable.