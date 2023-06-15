# Getting and Cleaning Data Course Project

Load all related libraries

Read activity_labels.txt in table format and rename activity_labels columns

Read features.txt in table format and rename features columns

Read X_train.txt in table format and rename X_test columns with the values from the features variable

Read subject_train.txt in table format and rename subject_train columns

Read y_train.txt in table format and rename Y_train columns

Append the X_train, Y_train and subject_train tables

Read X_test.txt in table format and rename X_test columns

Read subject_test.txt in table format and rename subject_test columns

Read y_test.txt in table format and rename y_test columns

Append the X_test, y_test and subject_test tables

Merge train and test tables

Melt the data set on all value conserving as ids (subject number and activity)

Cast the melted data set to produce the tidy dataset

Write the tidy data set
