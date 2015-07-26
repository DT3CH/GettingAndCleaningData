##Donald Clyburn
##Getting and Cleaning data
##course project


##Run Analyasis  script
##load plyr library
library(plyr)

##This script will run the analysis on the supplied data archive and return the desired 
##Tidy data set of mean values of the selected features.
#load all data sets into tables X_train, y_train, Labels, features


## Overall initial goal : Merge all the data sets into a new single data set

## Subset 1) gather all training data and subject training labels from supplied archive
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
#subject who performed the training
subject_train <- read.table("./train/subject_train.txt")

## Subset 2) gather all test data and subject test labels from supplied archive
#test set and lables
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
#subject who performed test
subject_test <- read.table("./test/subject_test.txt")


## Merge Set step 1) merge the 'x'(test/train) sets to make one set containing both x training and test data
x_set <- rbind(x_test, x_train)
## Merge Set step 2) merge the 'y'(test/train) sets to make one set containing both y training and test data
y_set <- rbind(y_test, y_train)
#Merge Set step 3) join all subject data from the train and test folders
subject_set <- rbind(subject_test, subject_train)

##End intial goal current sets : y_set, x_set, subject_set


## Second goal : extract data from the mean and std feature table , use feature table vector names as 
## new data set column names

## extract only mean | std labels from the features.txt file
features <- read.table("features.txt")
#return vector of numbers that have mean or std data
filter_features <- grep("-(mean|std)\\(\\)", features[, 2])
## subset set columns in x_set and then apply column names from filter_feature
x_set <- x_set[,filter_features]
names(x_set) <-features[filter_features, 2]

##End Second Goal modified sets, x_set now has column names from feature.txt

## Overall Goal 3 : Name activities in the data set using the activity_labels.txt file, replace numbers 1:6
## in y_train and y_test with labels

#read in activity_lables to a vector
activity <- read.table("activity_labels.txt")

#replace y_set names with activity labels
y_set[,1] <- activity[y_set[,1], 2]

#rename y_set column
names(y_set) <- "activity"

##End Third Goal modified sets, y_set now has activity as column name, and activity lables for 1:6

##Overall Goal 4 : Appropriately labels the data set with descriptive variable names. 
names(subject_set) <- "subject"
##bind all columns together into a new data set
total_sets <- cbind(subject_set, y_set ,x_set)

## Merge Sets 3) subject , y_set and x_set are now one main set of data that can be itself subset
##End Fourth Goalnew data set total_sets contains all previously merged sets with only std or mean variables

## Final Goal 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##find means of values using ddply (dplyr package) to subset the vector by subject and activity
# then apply colMeans function and write file
mean_total_data <- ddply(total_sets, .(subject, activity), function(x) colMeans(x[,3:68]))

write.table(mean_total_data, file = "UCIdata.txt", row.names = F)

##End Fifth Goal subset the new data set and write the mean data according to subject and activity.

