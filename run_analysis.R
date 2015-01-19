## step 1: reading data: 
## get data: subject, activity, measurement
datatest <- read.table("test/X_test.txt")
datanames <- read.table("features.txt")
colnames(datatest) <- datanames$V2

subjecttest <- read.table("test/subject_test.txt")
colnames(subjecttest) <- c("subject.number")

activitytest <- read.table("test//y_test.txt")


fulltest <- cbind(subjecttest, activitytest, datatest)

datatrain <- read.table("train/X_train.txt")
colnames(datatrain) <- datanames$V2

subjecttrain <- read.table("train//subject_train.txt")
colnames(subjecttrain) <- c("subject.number")

activitytrain <- read.table("train//y_train.txt")
fulltrain <- cbind(subjecttrain, activitytrain, datatrain)
fulldata <- rbind(fulltrain, fulltest)

## step 3: label activities 
activitylabels <- read.table("activity_labels.txt")
fulldata$V1 <- factor(fulldata$V1)
levels(fulldata$V1) <- activitylabels$V2

colnames(fulldata)[2] <- c("activity")

## step 2: discard everything but "mean" and "std" variables
tuplatpois <- fulldata[,!duplicated(colnames(fulldata))]
karsittu <- select(tuplatpois, contains("Subject"), contains("Acti"), contains("mean"), contains("std"))

## step 4: label variables, clean variable names
names(karsittu) <- gsub("\\()", "", names(karsittu))

## step 5: generate data set with average of each variable for each activity 
## and each subject (row: sub1-walking, col: all measurements)

avedataset <- aggregate(.~subject.number+activity, data=karsittu, mean)




