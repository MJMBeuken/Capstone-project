## downloaded zipfile and saved it in locale directory

## load activity label and feature files
labels <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/activity_labels.txt"), col.names = c("Klasse", "Activiteit"))
Eigenschappen <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/features.txt"), col.names = c("Index", "Namen eigenschappen"))


Eigenschapgewilde <- grep(".*Mean.*|.*Std.*", Eigenschappen$`Namen eigenschappen`)
maten <- Eigenschappen[Eigenschapgewilde, `Namen eigenschappen`]
maten <- gsub("[()]", "", maten)

## load trainings data

train <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/train/X_train.txt"))[, Eigenschapgewilde, with=FALSE]
data.table::setnames(train, colnames(train), maten)

trainingsactiviteit <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activiteit"))
trainingsonderwerp <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/train/subject_train.txt"), col.names = c("Onderwerpnummer"))
training <- cbind(trainingsactiviteit, trainingsonderwerp, train)

## load test data

test <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/test/X_test.txt"))[, Eigenschapgewilde, with=FALSE]
data.table::setnames(test, colnames(test), maten)

testactiviteit <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/test/Y_test.txt"), col.names=c("Activiteit"))
testonderwerp <- fread(file.path("~/Data science cursus coursera/course3week4/UCI HAR Dataset/test/subject_test.txt"), col.names = c("Onderwerpnummer"))
test <- cbind(testactiviteit, testonderwerp, test)

## merging data train & test
mergeddata <- rbind(training, test)

## inserting activitylabels
mergeddata$Activiteit <- factor(mergeddata$Activiteit, levels = labels$Klasse, labels = labels$Activiteit)

mergeddata$Onderwerpnummer <- as.factor(mergeddata$Onderwerpnummer)


mergeddata <- reshape2::melt(data = mergeddata, id = c("Activiteit", "Onderwerpnummer"))
mergeddata <- reshape2::dcast(mergeddata, Activiteit + Onderwerpnummer ~ variable, mean)


## convert to txt file

write.table(x=mergeddata, file = "traintest.txt", row.names=FALSE)
