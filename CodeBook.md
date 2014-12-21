Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, data, and any transformations performed during the analysis.  

The run_analysis.R script performs the following 5 steps:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The outputs of the script are 2 files called 'cleaned_data.txt' and 'data_with_means.txt'

* trainingData, testData, features, yTrainLabels, yTestLabels and subjectTrain and subjectTest contain the loaded data from the data files.
