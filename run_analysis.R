
# load the required libraries
library(plyr)
library(dplyr)

# read the required files
# the features file has the list of measured features. These will be used to
# assign the descriptive names to the variables for the tidy data set.
# the activity_tables file has the label descriptions for the activities
features <- read.table("features.txt", colClasses = c("numeric","character"))
activity <- read.table("activity_labels.txt", colClasses = c("character","character"))

# cname vector stores the column names to be applied to the tidy data set
cname <- c("SubjectID", "Activity", features$V2)

# read the files in the train folder
setwd("./train")

data_train <- cbind(read.table("subject_train.txt"),
           read.table("Y_train.txt", colClasses = c("character")),
           read.table("X_train.txt"))

names(data_train) <- cname

setwd("..")

# read the files in the test folder
setwd("./test")

data_test <- cbind(read.table("subject_test.txt"),
           read.table("Y_test.txt", colClasses = c("character")),
           read.table("X_test.txt"))

setwd("..")

# combine the test and train data sets
merged <- rbind(data_test, data_train)

# assign descriptive variable names, obtained from the features file
names(merged) <- cname

# replace the activity IDs in the dataset with the descriptive activity labels
merged[,2] <- mapvalues(merged[,2], activity[,1], activity[,2])

# extract a subset with the measurements on the mean and standard deviation only
data_sdmean <- grep("mean|std", names(merged)[seq(3,ncol(merged))], ignore.case = T)
merged <- merged[,data_sdmean]

# create the tidy data set with the average of each variable for each activity and each subject
tidy_data <- group_by(merged, SubjectID, Activity) %>% summarise_each(funs(mean))

# create a text file containing the tidy data set
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
