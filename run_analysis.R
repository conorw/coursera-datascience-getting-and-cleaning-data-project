###########################
#STEP 1: Merges the training and 
#the test sets to create one data set.
###########################
#- 'train/X_train.txt': Training set.
#- 'train/y_train.txt': Training labels.
#- 'test/X_test.txt': Test set.
#- 'test/y_test.txt': Test labels.

#read in the training and test data sets
trainingData <- read.table("./data/train/X_train.txt")
testData <- read.table("./data/test/X_test.txt")

#now merge the datasets
merged <- rbind(trainingData, testData)

############################
#STEP 2: Extracts only the measurements on the 
#mean and standard deviation for each measurement.
############################
features <- read.table("./data/features.txt")[, 2]
names(merged) <- features
#only look for items matching 'mean' or 'std'
matches <- grep("(mean|std)\\(\\)", names(merged))
#extract only the matching elements
matchingElements <- merged[, matches]

############################
#STEP 3: Uses descriptive activity names
#to name the activities in the data set
############################
yTrainLabels <- read.table("./data/train/y_train.txt")
yTestLabels  <- read.table("./data/test/y_test.txt")
yMergedLabels <- rbind(yTrainLabels, yTestLabels)[, 1]

activityNames <-
  c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities <- activityNames[yMergedLabels]

###########################
#STEP 4: Appropriately label the data
#set with descriptive variable names.
###########################
subjectTrain <- read.table("./data/train/subject_train.txt")
subjectTest  <- read.table("./data/test/subject_test.txt")
combinedsubjects <- rbind(subjectTrain, subjectTest)[, 1]

cleanedData <- cbind(Subject = combinedsubjects,Activity= activities, matchingElements)
write.table(cleanedData, "cleaned_data.txt")

###########################
#STEP 5: From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable 
#for each activity and each subject.
###########################
library(plyr)
# Calculate means for all cols except the subject and activity columns
limitedColMeans <- function(data) { colMeans(data[,-c(1,2)]) }
tidyMeans <- ddply(cleanedData, .(Subject, Activity), limitedColMeans)
names(tidyMeans)[-c(1,2)] <- paste0("Mean", names(tidyMeans)[-c(1,2)])

# Write file
write.table(tidyMeans, "data_with_means.txt", row.names = FALSE)

