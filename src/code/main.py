#Imports
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

# Question 13
train = pd.read_csv("/app/data/train.csv")
print(train.head())

# Question 14
print("Columns:", train.columns)
print("Missing values:\n", train.isnull().sum())
train['Age'] = train['Age'].fillna(train['Age'].median())
train['Embarked'] = train['Embarked'].fillna(train['Embarked'].mode()[0])
train['Sex'] = train['Sex'].map({'male': 0, 'female': 1})
train['Fare'] = train['Fare'].fillna(train['Fare'].median())
print("After cleaning:")
print(train.info())
print(train.describe())
print(train.head())

# Question 15
X = train[['Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Fare']]
y = train['Survived']

X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2, random_state=42)

model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

print("Logistic Regression model:")
print("Coefficients:", model.coef_)
print("Intercept:", model.intercept_)

# Question 16
y_pred_train = model.predict(X_train)
train_accuracy = accuracy_score(y_train, y_pred_train)
print("Training accuracy:", round(train_accuracy, 4))

# Question 17
test = pd.read_csv("/app/data/test.csv")
print("Loaded test shape:", test.shape)
print(test.head())

test['Age'] = test['Age'].fillna(train['Age'].median())
test['Fare'] = test['Fare'].fillna(train['Fare'].median())
test['Sex'] = test['Sex'].map({'male': 0, 'female': 1})

X_test = test[['Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Fare']]
test_preds = model.predict(X_test)

print("Test predictions preview:", test_preds[:20])
print("Number of test predictions:", len(test_preds))


# Question 18
gender_submission = pd.read_csv("/app/data/gender_submission.csv")
print("Loaded gender_submission shape:", gender_submission.shape)
print(gender_submission.head())

y_test_true = gender_submission["Survived"]
test_accuracy = accuracy_score(y_test_true, test_preds)
print("Test accuracy:", round(test_accuracy, 4))


