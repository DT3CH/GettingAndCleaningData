##Donald Clyburn
##Getting and Cleaning data
##course project



setwd("G:/R Code/analysis/UCI HAR Dataset")
filepathBase <- "G:/R Code/analysis/UCI HAR Dataset/"
##read activity labels into a table from activity_lables.txt

dfActivityLabels <- read.table(file = paste0(filepathBase,"activity_labels.txt"),
                                  header = F, sep = " ", col.names = c("activity_id", "activity_label"))

#load features as columns for new data set

dfColNames <- read.table(file= paste0(filepathBase,"features.txt"),
                         header = F, sep = " ", col.names = c("feature_id", "feature_label"))



#create new data set merged from trainning and test data sets
#then create a new data set from parameters in project
#------------------------------------------------------------------
dirfiles <- list.files("./UCI HAR Dataset/test")
#read ID numbers from subject_test file 1:30
ID <- read.table("G:/R Code/analysis/UCI HAR Dataset/test/subject_test.txt")

dim(ID)
names(ID) <- c("ID")

#  test_labels vector contains label (walking, walking_upstairs etc...) information 
test_labels<- read.table("G:/R Code/analysis/UCI HAR Dataset/test/y_test.txt")
dim(test_labels)
names(test_labels) <- c("Labels")

#read data from X_test.txt, only want to keep std and mean or 1:6 in data set
test_Variables <- read.table("G:/R Code/analysis/UCI HAR Dataset/test/X_test.txt")
dim(test_Variables)
#create vector of names to use as column names in test_variable
test_names <- as.character(dfColNames$feature_label)
names(test_Variables) <- test_names
##filter out columns without std OR mean in them measurments
test_Variables <- test_Variables[, grep("-mean\\(\\)|-std\\(\\)", names(test_Variables))]
##clean up test_variables data

names(test_Variables) <- gsub("-mean", "Mean", names(test_Variables))
names(test_Variables) <- gsub("-std", "STD", names(test_Variables))
names(test_Variables) <- gsub("\\(", "", names(test_Variables))
names(test_Variables) <- gsub("\\)", "", names(test_Variables))
names(test_Variables) <- gsub("-", "", names(test_Variables))
names(test_Variables) <- gsub("Body", "", names(test_Variables))
names(test_Variables) <- gsub("Acc", "Acceleration", names(test_Variables))
names(test_Variables) <- gsub("Gyro", "Gyroscopic", names(test_Variables))
names(test_Variables) <- gsub("Mag", "Magnitude", names(test_Variables))
names(test_Variables) <- gsub("BodyBody", "Body2", names(test_Variables))
#names(test_Variables) <- gsub("Gravity", "Gravity", names(test_Variables))
names(test_Variables) <- gsub("^t", "Time", names(test_Variables))
names(test_Variables) <- gsub("^f", "Frequency", names(test_Variables))

## Merge/ Join activities with the metadata in dfActiityLabels

test_category <- data.frame(rep("test", nrow(test_Variables)))
names(test_category) <- c("Group")

testData <- cbind(ID,test_category,test_labels,test_Variables)


##repeat steps for train data sets 


## The ID vector contains the patients ID (1:30)
ID <- read.table("./train/subject_train.txt")  
dim(ID)
## Name the vector 'ID'
names(ID) <- c("ID")

## The train_labels Vector contains the label information (1:6 <- WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
train_labels <- read.table("./train/y_train.txt") 
dim(train_labels)
## Name the vector 'train_labels'
names(train_labels) <- c("Labels")

train_Variables <- read.table("./train/X_train.txt") 
dim(train_Variables)
names(train_Variables) <- train_Variables

train_names <- as.character(dfColNames$feature_label)
names(train_Variables) <- train_names



train_Variables <- train_Variables[, grep("-mean\\(\\)|-std\\(\\)", names(train_Variables))]

## Clean up the column names
names(train_Variables) <- gsub("-mean", "Mean", names(train_Variables))
names(train_Variables) <- gsub("-std", "STD", names(train_Variables))
names(train_Variables) <- gsub("\\(", "", names(train_Variables))
names(train_Variables) <- gsub("\\)", "", names(train_Variables))
names(train_Variables) <- gsub("-", "", names(train_Variables))
names(train_Variables) <- gsub("Body", "", names(train_Variables))
names(train_Variables) <- gsub("Acc", "Acceleration", names(train_Variables))
names(train_Variables) <- gsub("Gyro", "Gyroscopic", names(train_Variables))
names(train_Variables) <- gsub("Mag", "Magnitude", names(train_Variables))
names(train_Variables) <- gsub("BodyBody", "Body2", names(train_Variables))
#names(train_Variables) <- gsub("Gravity", "Gravity", names(train_Variables))
names(train_Variables) <- gsub("^t", "Time", names(train_Variables))
names(train_Variables) <- gsub("^f", "Frequency", names(train_Variables))


## Create a 'Group' category so we know which rows are from the training group
train_category <- data.frame(rep("train", nrow(train_Variables)))
names(train_category) <- c("Group")

train_Data <- cbind(ID, train_category, train_labels, train_Variables)

UCItidy <- rbind(testData, train_Data)

write.table(UCItidy, file = "./UCIdata.txt", col.names=TRUE, row.names=FALSE)

