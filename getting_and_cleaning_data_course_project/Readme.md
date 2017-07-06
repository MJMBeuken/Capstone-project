# Getting and cleaning data course project.

## The run_analysis script results in a merged and tidy dataset:
### The following steps are proceeded as follows:

* Downloads the dataset from working directory.
* Loads the activity labels and feature information.
* Keeping only those columns which reflect a mean or standard deviation and removing "[()]"
* Loads the train datasets.
* Loads the activity and subject data and merges columns with the dataset
* Loads the test dataset.
* Loads the activity and subject data and merges columns with the dataset
* Merges the train and test datasets via rows.
* Inserts activitylabels.
* Converts the activity and subject columns into factors
* Reshape with melt command to take wide-format data and melt it into long-format data.
* Reshape with dcast command to make sure that 'Activiteit' and 'Onderwerpnummer' get a column each and that variable describes the mean for each subject and activity pair.
* Converts to txt-file

## The end result is shown in the file traintest.txt.
