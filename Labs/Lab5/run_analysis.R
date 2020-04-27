# Встановлюємо директорію лабораторної роботи 5 як робочу
# setwd(getwd() + "/Lab5")

# вказуємо шляхи до файлів
testSubjectPath <- "./UCI_HAR_Dataset/test/subject_test.txt"
testXPath <- "./UCI_HAR_Dataset/test/X_test.txt"
testYPath <- "./UCI_HAR_Dataset/test/Y_test.txt"
trainSubjectPath <- "./UCI_HAR_Dataset/train/subject_train.txt"
trainXPath <- "./UCI_HAR_Dataset/train/X_train.txt"
trainYPath <- "./UCI_HAR_Dataset/train/Y_train.txt"
featuresNamesPath <- "./UCI_HAR_Dataset/features.txt"

# зчитуємо назви атрибутів (features)
featuresNamesData <- read.table(featuresNamesPath)
# трансформуємо таблицю атрибутів у вектор
featuresNames <- featuresNamesData[[2]]

# зчитуємо test та train дані
testSubjectDataFrame <- read.table(testSubjectPath, col.names=c("subject"))
testXDataFrame <- read.table(testXPath, col.names=featuresNames)
testYDataFrame <- read.table(testYPath, col.names=c("y"))

trainSubjectDataFrame <- read.table(trainSubjectPath, col.names=c("subject"))
trainXDataFrame <- read.table(trainXPath, col.names=featuresNames)
trainYDataFrame <- read.table(trainYPath, col.names=c("y"))

# об'єднуємо тестові та тренувальні дані для кожного набору даних
fullSubjectDataFrame <- rbind(testSubjectDataFrame, trainSubjectDataFrame)
fullXDataFrame <- rbind(testXDataFrame, trainXDataFrame)
fullYDataFrame <- rbind(testYDataFrame, trainYDataFrame)

# формуємо єдиний, об'єднаний дата фрейм
mergedDataFrame <- cbind(fullSubjectDataFrame, fullYDataFrame, fullXDataFrame)

# обираємо лише атрибути, що нас цікалять ("mean()" та "std()")
filteredXDataFrame <- cbind(
  fullXDataFrame[, Reduce(`&`, list(grepl("mean", names(fullXDataFrame)), !grepl("meanFreq", names(fullXDataFrame))))],
  fullXDataFrame[, grepl("std", names(fullXDataFrame))]
)

activityLabelsPath <- "./UCI_HAR_Dataset/activity_labels.txt"
activityLabels <- read.table(activityLabelsPath, col.names=c("activity_id", "activity_description"))

# надаємо значенням Y їх іменовані варіанти (WALKING, etc.)
namedYDataFrame <- data.frame(activity=activityLabels$activity_description[match(fullYDataFrame$y, activityLabels$activity_id)])

library(dplyr)

mergedDataFrame <- cbind(fullSubjectDataFrame, namedYDataFrame, filteredXDataFrame)

# групуємо за діяльністю, суб’єктом та для кожного атрибуту знаходимо середнє значення
tidyDataset <- data.frame(mergedDataFrame %>% group_by(subject, activity) %>% summarise_all(funs(mean)))

# записуємо дата фрейм у файл
write.table(tidyDataset, "tidy_dataset.txt", row.names=FALSE)
