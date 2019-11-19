# gettingandcleaningdata Codebook
Getting and Cleaning Data Course Project

This CodeBook describes the "tidydata.txt" data output by the "run_analysis.R" script.

First of all the training data (located in the train subfolder) and test data (located in the test subfolder) were merged together. In particular only the files in the initial subfolder were merged, not any further subfolders.
 - X_train.txt and X_test.txt contain the measurements made by the accelerometers
 - y_train.txt and y_test.txt contain the activity identifiers which match with those in the activity_labels.txt file in the root data folder
 - subject_train.txt and subject_test.txt contain the subject numbers of the measurements

The data is then condensed so that only mean and standard deviation for each measurement are left. For this purpose I checkled whether the feature (as set out in features.txt) contained "mean(" or "std". This means that certain features, such as meanFreq and the additional vectors based on, for example, gravityMean, are also excluded.

The activity identifiers were then replaced with the descriptive version set out in activity_labels.txt, but lowercase to make the data easier to work with.

The data was then tidied slightly to add column headers while removing the curly brackets from the features names, as these don't add information. This results in a data frame called completedata but is not stored externally.

The tidy data was then created which contains the following columns:
 - "subject" the subject identifier which is from 1 to 30
 - "activity" the activity, which is one of 6 options - "walking", "walking_upstairs", "walking_downstairs", "sitting", "standing" and "laying"
 - a mean of all the signal measurements for the particular subject and activity for a certain signal type in the format A-B-C, where A is the signal type (explained in features_info.txt), B is mean or std (standard deviation) and C relates to the X, Y or Z direction
