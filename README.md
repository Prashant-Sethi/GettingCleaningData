# Getting and Cleaning Data

## Course Project

The script run_analysis.R creates a tidy data set which can be used for analysis. The process starts with collecting data from different data sets and merging them together logically. Subsequent steps involve proper labelling of the merged data set, and then cleaning the data set to generate a new data set which is suitable for further analysis.

In the given data scheme, the two data sets are test and train, which are in the respective folders by the same names. Each folders contains three files, the individual files containing information about a subject ID, the activity code, and the measurements for the different features which are listed in a separate file in the root folder. The root folder also consists of an activity labels file which has descriptive names for the activity labels according to the activity code.

The read.table() function is used to read all the necessary files. First the data pertaining to the individual test and train data sets is merged together, columnwise, with the first two columns having information about the Subject ID and the activity code performed by each subject during that measurement, the measurement values being stored in the subsequent columns.

After that, the two test and train data sets are now merged, row-wise, so a complete dataset with all the test and train measurements is obtained. Further to creating the merged data sets, the column names are assigned to the dataset so that each column can be identified by its header.

In this merged data set, the only values of interest to us are the measurements on the mean and standard deviation for each measurement. To extract this subset from the complete data set, a pattern matching function grep() is used to create a subset of the columns in which 'mean' or 'std' appear in the column name.

At this step, the dataset is ready for the final cleaning step. All the columns (variables) of interest have been isolated along with the information about corresponding subject and activity IDs.

However, at this stage, there are too many individual measurements for each pair of subject and activity. To make the analysis purposeful and meaningful, it is a logical step to summarize the data such that only one measurement exists for each subject-activity pair. The most common statistical measure used to summarise such data is the mean of the observations.

In this script also, in the final step of cleaning the data, all the observations are grouped by subjectID and activity, and finally mean is taken on each group of observations. This is done using the summarise_each() function, chained with the group_by() function. The group_by() function logically separates the data in groups according to the subjectID and activity which are passed to it as arguments, and then the summarise_each() function is used to apply the mean() function to each subsetted group.

The tidy data set thus created has 180 observations for each variable. This figure can be used to verify the correctness of the procedure as there are a total of 30 subjects in the study, and 6 calssifications of activity, thus giving a total of (30 x 6 =) 180 possible subject-activity combinations.