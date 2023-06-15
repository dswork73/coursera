# Load packages
packages <- c('dplyr', 'data.table','reshape2') 
lapply(packages, require, character.only = TRUE)

# Load data
path <- getwd()
activity_labels <- read.table(file = paste((file.path(path, "UCI HAR Dataset/activity_labels.txt")))
                        , col.names = c("class_labels", "activity_name"))
features <- read.table(file = paste((file.path(path, "UCI HAR Dataset/features.txt")))
                  , col.names = c("index", "feature_names"))
features_filter <- grep("(mean|std)\\(\\)", features$feature_names)
measurements <- features$feature_names[features_filter]
measurements <- gsub('[()]', '', measurements)

# Load train data
train <- read.table(file = paste(file.path(path, "UCI HAR Dataset/train/X_train.txt")))[, features_filter]
data.table::setnames(train, colnames(train), measurements)
train_subjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("subject_number"))
train_activities <- fread(file.path(path, "UCI HAR Dataset/train/y_train.txt")
                          , col.names = c("activity"))
train <- cbind(train_subjects, train_activities, train)

# Load test data
test <- read.table(file = paste(file.path(path, "UCI HAR Dataset/test/X_test.txt")))[, features_filter]
data.table::setnames(test, colnames(test), measurements)
test_subjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("subject_number"))
test_activities <- fread(file.path(path, "UCI HAR Dataset/test/y_test.txt")
                         , col.names = c("activity"))
test <- cbind(test_subjects, test_activities, test)

# merge datasets
merge_data <- rbind(train, test)

# Convert class labels to activity name basically. More explicit. 
merge_data[["activity"]] <- factor(merge_data[,activity]
                                 , levels = activity_labels[["class_labels"]]
                                 , labels = activity_labels[["activity_name"]])

merge_data[["subject_number"]] <- as.factor(merge_data[, subject_number])
merge_data <- reshape2::melt(data = merge_data, id = c("subject_number", "activity"))
merge_data <- reshape2::dcast(data = merge_data, subject_number + activity ~ variable, fun.aggregate = mean)

# Write table
write.table(x = merge_data, file = "tidy_data.txt", quote = FALSE, row.names = FALSE)
