library(dplyr)
library(reshape2)
##set your working dir
##setwd("")


fname <- "mydataproj.zip"

# Checking if file already exists.
if (!file.exists(fname)){
  furl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(furl, fname, method="curl")
}  

# Checking if folder from zip file exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fname) 
}

feat <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
act <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subjtest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feat$functions)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feat$functions)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
##Merge data sets.
xds <- rbind(xtrain, xtest)
yds <- rbind(ytrain, ytest)
subj <- rbind(subjtrain, subjtest)
datmerge <- cbind(subj, yds, xds)
names(datmerge)<-gsub("[[:punct:]]","",names(datmerge))
##Get mean and standard deviation
tidydat <- datmerge %>% select(subject, code, contains("mean"), contains("std"))
##Use descriptive activity names
tidydat$code <- act[tidydat$code, 2]
##Label data set variable names with appropriate labels
names(tidydat)[2] = "activity"
names(tidydat)<-gsub("^t", "time", names(tidydat))
names(tidydat)<-gsub("^f", "freq", names(tidydat))
names(tidydat)<-gsub("-mean()", "mean", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("-std()", "std", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("-freq()", "freq", names(tidydat), ignore.case = TRUE)
names(tidydat)<-tolower(names(tidydat))
names(tidydat)<-gsub("meanx$", "mean_x", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("meany$", "mean_y", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("meanz$", "mean_z", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("freqx$", "freq_x", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("freqy$", "freq_y", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("freqz$", "freq_z", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("stdx$", "std_x", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("stdy$", "std_y", names(tidydat), ignore.case = TRUE)
names(tidydat)<-gsub("stdz$", "std_z", names(tidydat), ignore.case = TRUE)
##create second, independent tidy data set with average of each var for
##each activity/subject
mytidydat <- tidydat %>%
  group_by(subject, activity) %>%
  summarize_all(mean)
write.table(mytidydat, "myTidyData.txt", row.name=FALSE, quote = FALSE)
