training <- read.table("train/X_train.txt", header = FALSE)
trainingY <- read.table("train/y_train.txt", header = FALSE)
trainingSubj <- read.table("train/subject_train.txt", header = FALSE)
training$activity <- trainingY$V1
training$subject <- trainingSubj$V1

test <- read.table("test/X_test.txt", header = FALSE)
testY <- read.table("test/y_test.txt", header = FALSE)
testSubj <- read.table("test/subject_test.txt", header = FALSE)
test$activity <- testY$V1
test$subject <- testSubj$V1

# 1. Merge the training and the test sets to create one data set
merged <- rbind(training, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.csv("features.txt", sep=" ", header = FALSE, stringsAsFactors=FALSE)
selectedFeatures <- features[grep("mean\\(\\)|std\\(\\)", features$V2),]
extractedData <- merged[,selectedFeatures$V1]

# 3. Use descriptive activity names to name the activities in the data set
activityLabelsFile <- read.csv("activity_labels.txt", sep=" ", header = FALSE)
activityLabels <- as.factor(x = activityLabelsFile$V2)
extractedData$activity <- factor(merged$activity, levels=activityLabelsFile$V1, labels=activityLabelsFile$V2)
extractedData$subject <- merged$subject

# 4. Appropriately label the data set with descriptive variable names. 
names(extractedData) <- selectedFeatures$V2
activityColIdx <- length(names(extractedData)) - 1
subjectColIdx  <- length(names(extractedData))
names(extractedData)[activityColIdx] <- "activity"
names(extractedData)[subjectColIdx] <- "subject"

# 5. Average of each variable for each activity and each subject.
aggregated <- aggregate(
    extractedData[,-c(activityColIdx,subjectColIdx)], 
    list(activity=extractedData$activity, subject=extractedData$subject), 
    FUN="mean")
write.table("aggregated.txt", row.name=FALSE)