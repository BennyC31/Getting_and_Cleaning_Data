# Getting_and_Cleaning_Data
Repo for Coursera Course

Project Script (run_analysisy.R)

Steps:

-Checks if project data set exists.  If not, downloads into the project working directory.  Otherwise, skips and moves to the next step.

-Checks if “UCI HAR Dataset” directory exists from downloaded zip file.  If not, creates the directory.
Once the directory is created or already exists, unzips the data from the zip file into this directory.

-Loads the following data sets into data frames using read.table function:
  features.txt, activity_lables.txt, subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, y_train.txt

-Merges the following datasets using bind:
  X_train and X_test
  y_train and y_test
  subject_train and subject_test

-Merges the above three datasets into one dataset using cbind and removes punctuation.

-Creates a dataset (tidydat) from the above to only include columns with mean and std.

-Updates the tidydat variable names with appropriate labels.

-Using chaining create a new dataset (mytidydat) from tidydat to summarize the mean by subject/activity

-Write mytidydat to a text file (myTidyData.txt) using write.table function.
