library(dplyr) ## lodaing dplyr package
getwd()## Checking the working directory
setwd("D:/R programming/Coursera Project/Part 3/Project/UCI HAR Dataset")##setting working directory
## Reading the test dataset
setwd("D:/R programming/Coursera Project/Part 3/Project/UCI HAR Dataset/test")
list.files("D:/R programming/Coursera Project/Part 3/Project/UCI HAR Dataset/test")
x.test<-read.table("X_test.txt",header = FALSE)## Reading x_test file
head(x.test,n=6)
y.test<-read.table("y_test.txt",header = FALSE)## Reading y_test file
sub_test<-read.table("subject_test.txt",header = FALSE)## Reading sub_test file
## Reading training data set
setwd("D:/R programming/Coursera Project/Part 3/Project/UCI HAR Dataset/train")
list.files("D:/R programming/Coursera Project/Part 3/Project/UCI HAR Dataset/train")
x.train<-read.table("X_train.txt",header=FALSE)## Reading x_train
y.train<-read.table("y_train.txt",header=FALSE)## Reading y_train
sub.train<-read.table("subject_train.txt",header=FALSE)## Reading subject_train
## Reading features data
setwd("D:/R programming/Coursera Project/Part 3/Project/UCI HAR Dataset")
list.files("D:/R programming/Coursera Project/Part 3/Project/UCI HAR Dataset")
feature<-read.table("features.txt",header=FALSE)## Reading feature data
## Reading activing_labels data
act_labels<-read.table("activity_labels.txt",header=FALSE)## Reading activity_labels
## Labeling the testing and training data set
colnames(x.train)=feature[,2] ## Labelling x.train data set with feature column [2]
colnames(y.train)="activityID"## Labelling y.train data set with "activity id"
colnames(sub.train)="subjectid"## labelling the sub.train data set "subject id"
colnames(x.test)=feature[,2]## Labelling x.test data set with feature column [2]
colnames(y.test)="activityID"##Labelling y.test data set with "activity id"
colnames(sub_test)="subjectid"## labelling the sub.train data set "subject id"
## Labellling activity table
colnames(act_labels)= c("activityID","activitytype")
##Merging training data set
train.merge<-cbind(y.train,sub.train,x.train)
##Merging testing data set
test.merge<-cbind(y.test,sub_test,x.test)
##Merging testing and training data set to make into one complete data set
full<-rbind(train.merge,test.merge)
##Extracting the mean and the standard deviation
columnNames<-colnames(full)## Reading the values of the column names
## Extracting the mean and standard deviation data from the full dataset
avg_std_extraction<-(grepl("activityID",columnNames)|grepl("subjectid",columnNames)|grepl("mean..",columnNames)|grepl("std..",columnNames))
##Subsetting the dataset with mean and standard devation
full1<-full[,avg_std_extraction==TRUE]
##Naming the activites in the dataset
activity_names<-merge(full1,act_labels,by="activityID",all.x=TRUE)
##Creating the second data set with average of each variable with average of each activity
secdata<-aggregate(.~subjectid+activityID,full1,mean)
##setting in order the second data
secdata1<-secdata[order(secdata$subjectid,secdata$activityID),]
## Writing the secondary data
write.table(secdata1,"secdata1.txt",row.names = FALSE)
