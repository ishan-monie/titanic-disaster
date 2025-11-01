# Question 13
library(tidyverse)
library(caret)
set.seed(42)

train <- read.csv("/app/data/train.csv")
print(head(train))

# Question 14
print("Columns:")
print(colnames(train))
print("Missing values:")
print(colSums(is.na(train)))

train$Age[is.na(train$Age)] <- median(train$Age, na.rm = TRUE)
train$Embarked[is.na(train$Embarked)] <- names(which.max(table(train$Embarked)))
train$Sex <- ifelse(train$Sex == "male", 0, 1)
train$Fare[is.na(train$Fare)] <- median(train$Fare, na.rm = TRUE)

print("After cleaning:")
print(str(train))
print(summary(train))
print(head(train))

# Question 15
features <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare")
X <- train[, features]
y <- train$Survived

train_index <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[train_index, ]
y_train <- y[train_index]
X_val <- X[-train_index, ]
y_val <- y[-train_index]

df_train <- cbind(X_train, Survived = y_train)

model <- glm(Survived ~ ., data = df_train, family = binomial())
print("Logistic Regression model:")
print(summary(model))

# Question 16
pred_train <- ifelse(predict(model, X_train, type = "response") > 0.5, 1, 0)
train_accuracy <- mean(pred_train == y_train)
print(paste("Training accuracy:", round(train_accuracy, 4)))

# Question 17
test <- read.csv("/app/data/test.csv")
print(paste("Loaded test shape:", nrow(test), "rows,", ncol(test), "columns"))
print(head(test))

test$Age[is.na(test$Age)] <- median(train$Age, na.rm = TRUE)
test$Fare[is.na(test$Fare)] <- median(train$Fare, na.rm = TRUE)
test$Sex <- ifelse(test$Sex == "male", 0, 1)

X_test <- test[, features]
test_preds <- ifelse(predict(model, X_test, type = "response") > 0.5, 1, 0)

print("Test predictions preview:")
print(head(test_preds, 20))
print(paste("Number of test predictions:", length(test_preds)))

# Question 18
gender_submission <- read.csv("/app/data/gender_submission.csv")
print(paste("Loaded gender_submission shape:", nrow(gender_submission), "rows"))
print(head(gender_submission))

y_test_true <- gender_submission$Survived
test_accuracy <- mean(test_preds == y_test_true)
print(paste("Test accuracy:", round(test_accuracy, 4)))
