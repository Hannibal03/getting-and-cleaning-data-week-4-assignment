#package
library(dplyr)

#read train data
xtrain <- read.table(file.path(pathdata, "train", "x_train.txt"), header = FALSE)
ytrain <- read.table(file.path(pathdata, "train", "y_train.txt"),header = FALSE)
subTrain = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)

#Read testing data
xtest <- read.table(file.path(pathdata, "test", "X_test.txt"),header = FALSE)
ytest <- read.table(file.path(pathdata, "test", "y_test.txt"),header = FALSE)
subTest <- read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)

#Read features
features <- read.table(file.path(pathdata, "features.txt"),header = FALSE)

#Read activity
activityLabels <- read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)

#Merging the train and test data sets
xTotal <- rbind(xtrain, xtest)
yTotal <- rbind(ytrain, ytest)
subTotal <- rbind(subTrain, subTest)

#mean and standart deviation
sel_var <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
XTotal <- XTotal[,sel_var[,1]]

#names
colnames(xTotal) <- sel_var[,2]
colnames(yYotal)   <- "activity"
colnames(subTotal) <- "subject"


#merge dataset
total <- rbind(xTotal, yTotal, subTotal)

# activities and subjects
total$activity <- factor(total$activity, levels = activity_labels[,1], labels = activity_labels[,2]) 
total$subject  <- as.factor(total$subject) 

#dataset with average
totalMean <- total %>% group_by(activity, subject) %>% summarize_all(funs(mean)) 

write.table(total_mean, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE) 
