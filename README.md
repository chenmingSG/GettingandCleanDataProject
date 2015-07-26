### logic flow of the scripts
the scripts contain the following main sections:
1. Data reading: train, test, feature name and activity labels data. 
2. merge data and rename to readable variabels names: first use rbind to combine the train and test data set by data set; second use the data.table library to renname the variables; lastly use cbind to combine the subject,inputs (X) and output (y). 
3. extract only those measurements on mean or standard deviations. here the grepl function is used to find which variable contain the mean or std inside the variable names. the subsete function is then used to select only those variables of interests. 
4. replace the activity code with the activity name. activtiy code serves as the row number to index the activity name. 
5. summarize the mean of all the variables grouped by subject and activity,using the dplyr package. the summarise_each function is able to summarize all the variables.    
### Data sets and folder location
1. "UCI HAR Dataset" folder is located in the same location as the run_analysis R file, and contains two data files: activity_labels.txt and features.txt. 
2. "train" folder is located under "UCI HAR Dataset" and contain three data files: subject_train.txt,X_train.txt and y_train.txt.
3. "test" folder is located under "UCI HAR Dataset" and contain three data files: subject_test.txt, X_test.txt and y_test.txt.
For a detailed descriptions on how the data has been collected, please refer to the readme.txt located the "UCI HAR Dataset" folder. 
### major libraries used
1. read.table
2. data.table
3. dplyr