###cousera getting and cleaning data course project
##read the training data sets
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE,sep="",na.strings="NA",dec=".",fill=
                        TRUE,skip=0)
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE,sep="",na.strings="NA",dec=".",fill=
                      TRUE,skip=0)
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep="",na.strings="NA",dec=".",fill=
                      TRUE,skip=0)
##read the test data sets
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE,sep="",na.strings="NA",dec=".",fill=
                      TRUE,skip=0)
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep="",na.strings="NA",dec=".",fill=
                      TRUE,skip=0)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep="",na.strings="NA",dec=".",fill=
                            TRUE,skip=0)
##read the feature names, whcih can be used for label the X data set variables and select only variables with mean and standard deviations
feastures<-read.table("./UCI HAR Dataset/features.txt",header=FALSE,sep="",stringsAsFactors=FALSE,na.strings="NA",dec=".",fill=
                        TRUE,skip=0)
## read teh activity labels
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep="",stringsAsFactors=FALSE,na.strings="NA",dec=".",fill=
                        TRUE,skip=0)
##merge the train and test data sets.
X<-rbind(X_train,X_test)
y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)

##re-name the data sets to meaningful names
#install.packages("data.table") #if data.table is not installed, need to install first.
library(data.table)
setnames(X, old = colnames(X), new = feastures$V2)
setnames(y, old = colnames(y), new = "Activities")
setnames(subject, old = colnames(subject), new = "subject")
setnames(activity_labels,old=colnames(activity_labels),new=c("ActCode","ActName"))

### create a varible to indicate wether a specific row is train data or not, TRUE means train data, FALSE mean test data.
##exclude this seems not required by this project. 
# IsTrain<-c(rep(TRUE,dim(subject_train)[1]),rep(FALSE,dim(subject_test)[1]))
# IsTrainDf<-data.frame(IsTrain)

##merge the X,y and subject to a new data set. 
DataComplete<-cbind(subject,y,X)


##Extracts only the measurements on the mean and standard deviation for each measurement
measureNames<-feastures$V2
#check X names contain mean or std
IsmeasureNamesMeanStd<-grepl("Mean",ignore.case=TRUE,measureNames)|grepl("Std",ignore.case=TRUE,measureNames)
#default include the Subject,Activities
VariablesToSelect<-c(TRUE,TRUE,IsmeasureNamesMeanStd)
DataMeanStd<-subset(DataComplete,select=VariablesToSelect)


##Uses descriptive activity names to name the activities in the data set
#the activity code is just the row number in the activity_label, so can use as the row index for the mapping
#form code to the name. 
DataMeanStd$Activities<-activity_labels[DataMeanStd$Activities,"ActName"]


##Appropriately labels the data set with descriptive variable names
## it has already been done in code 27~33

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
##for each activity and each subject
library(dplyr)
DataMeanofMeanStd<-DataMeanStd%>%group_by(subject,Activities)%>%summarise_each(funs(mean))
#write.table(DataMeanofMeanStd,file="./CouseraGettingandCleanDataProjectData.txt",row.names=FALSE)




