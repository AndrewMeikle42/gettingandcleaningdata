# requires a file called "getdata_projectfiles_UCI HAR Dataset.zip to be located in the home directory
# can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# data originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

zipfile <- "getdata_projectfiles_UCI HAR Dataset.zip"

unzip(zipfile)

# 1. merge training and test data into merged data set

traindata <- read.table("UCI HAR dataset/train/X_train.txt")
trainlabel <- read.table("UCI HAR dataset/train/y_train.txt")
trainsubject <- read.table("UCI HAR dataset/train/subject_train.txt")

testdata <- read.table("UCI HAR dataset/test/X_test.txt")
testlabel <- read.table("UCI HAR dataset/test/y_test.txt")
testsubject <- read.table("UCI HAR dataset/test/subject_test.txt")

mergeddata <- rbind(traindata,testdata)
mergedlabel <- rbind(trainlabel,testlabel)
mergedsubject <- rbind(trainsubject,testsubject)

# 2. extract only mean and standard deviation for each measurement

features <- read.table("UCI HAR dataset/features.txt")
features_meanstd <- grep("mean\\(|std", features[, 2]) 
mergeddata <- mergeddata[,features_meanstd]

# 3. use descriptive activity names to name the activities in the data set

activitylabels <- read.table("UCI HAR dataset/activity_labels.txt")
activitylabels[,2] <- tolower(activitylabels[,2])
mergedlabel <- activitylabels[mergedlabel[,1],2]
mergedlabel <- as.data.frame(mergedlabel)

# 4. appropriately label the data set with descriptive variable names

names(mergedlabel) <- "activity"
names(mergedsubject) <- "subject"
names(mergeddata) <- features[features_meanstd,2]
names(mergeddata) <- gsub("\\(\\)", "",names(mergeddata))
completedata <- cbind(mergedsubject,mergedlabel,mergeddata)

# 5. create tidy data set with average of each variable for each activity and each subject

tidydata <- completedata[0,]

for(i in 1:30) {    #cycle through i = subject
    for(j in 1:6) { #cycle through j = activity
        x <- (i-1)*6 + j
        tidydata[x, 1] <- i
        tidydata[x, 2] <- activitylabels[j,2]
        for(k in 3:68) {
            tidydata[x, k] <- mean(completedata[(completedata$subject == i) & (completedata$activity == activitylabels[j,2]), k])
        }
    }
}

write.table(tidydata, file="tidydata.txt", row.name = FALSE)
