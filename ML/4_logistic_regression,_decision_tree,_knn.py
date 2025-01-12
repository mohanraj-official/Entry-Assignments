# -*- coding: utf-8 -*-
"""4 - Logistic Regression, Decision Tree, KNN.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1bRE4i5g5ukmzDTM4ZZKmTsyHelMFs3AK

# Logistic Regression, Decision Tree, KNN

## 1 - Data Preprocessing

### 1.1 - Load the Dataset
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
df = pd.read_csv("https://raw.githubusercontent.com/ArchanaInsights/Datasets/main/campus_placement.csv")
df.tail()

df.info()

df.describe()

"""### 1.2 - Handling missing values"""

df.isnull().sum()

"""### 1.3 - Encode Categorical Features"""

# Find the Categary columns
categary_columns = []
for i in df.select_dtypes(include = "O").columns:
  categary_columns.append(i)
categary_columns

# Compare its values
df[categary_columns].head()

# Encode these categary Columns into Numeric Columns
for i in categary_columns:
  df[i] = df[i].map({"Yes" : 1, "No" : 0, "NotPlaced" : 0, "Placed" : 1})
df[categary_columns].head()

"""### 1.4 - Feature Selection"""

# let us see the figure
plt.figure(figsize = (12, 10))
sns.heatmap(df.corr(), annot = True, cmap="coolwarm")
plt.show()

# Select Top features
df.corr()["PlacementStatus"].sort_values(ascending = False)

# Now Select Feature And Target
top_features = ["AptitudeTestScore", "HSC_Marks", "ExtracurricularActivities", "Projects"]
target = "PlacementStatus"

X = df[top_features]
y = df[target]

"""### 1.5 - Data Splitting"""

# Data Splitting
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 42)

print(f"X_train shape\t : {X_train.shape}")
print(f"X_test shape\t : {X_test.shape}")
print(f"y_train shape\t : {y_train.shape}")
print(f"y_test shape\t : {y_test.shape}")

"""### 1.6 - Feature Scaling"""

# Now Scale the Features
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
# Training Set
X_train_scaled = scaler.fit_transform(X_train)
# Test Set
X_test_scaled = scaler.fit_transform(X_test)

"""## 2 - Logistic Regression - Model Building and Evaluation

### 2.1 - Model Building:
"""

# Build a Logistic Regression Model
from sklearn.linear_model import LogisticRegression
lr = LogisticRegression(max_iter = 300)
lr.fit(X_train, y_train)

"""### 2.2 - Model Evaluation"""

# Evaluate the Model
from sklearn.metrics import accuracy_score
y_pred_LR = lr.predict(X_test)
accuracy_LR = accuracy_score(y_test, y_pred_LR)
print(f"Accuracy : {accuracy_LR}")

"""## 3 - Decision Tree - Model Building and Evaluation

### 3.1 - Model Building
"""

# Build decision tree model
from sklearn.tree import DecisionTreeClassifier
clf = DecisionTreeClassifier(max_depth = 3)
clf.fit(X_train, y_train)

"""### 3.2 - Model Evaluation"""

# Model Evaluation
y_pred_DT = clf.predict(X_test)
accuracy_DT = accuracy_score(y_test, y_pred_DT)
print(f"Accuracy Score for Decision Tree - {accuracy_DT}")

# Now We can see the visual
from sklearn.tree import plot_tree
plt.figure(figsize = (20, 10))
plot_tree(clf, feature_names = X.columns, filled = True, class_names = ["Not Placed", "Placed"])
plt.show()

"""## 4 - K-Nearest Neighbors (KNN) - Model Building and Evaluation

### 4.1 - Model Building
"""

# Build the KNeighbor Model
from sklearn.neighbors import KNeighborsClassifier
knn = KNeighborsClassifier()
knn.fit(X_train, y_train)

"""### 4.2 - Model Evaluation"""

# Evaluate the model
accuracy_knn = []
for i in range(1, 11):
  knn = KNeighborsClassifier(n_neighbors = i)
  knn.fit(X_train, y_train)
  score = knn.score(X_test, y_test)
  accuracy_knn.append(score)
accuracy_knn

"""### 4.3 - Reporting"""

# Report
for i, score in enumerate(accuracy_knn, start = 1):
  print(f"for k = {i}, accuracy = {score}")

mean_of_accuracy = np.mean(accuracy_knn)
print(f"Mean Accuracy : {mean_of_accuracy}")

plt.figure(figsize = (10, 4))
plt.plot(range(1, 11), accuracy_knn, marker = "o", color = "blue", markersize = 5, markerfacecolor = "red", linestyle = "dashed")
plt.xticks(range(1, 11))
plt.title("Accuracy vs K")
plt.xlabel("K")
plt.ylabel("Accuracy")
plt.show()

"""## 5 - Comparison and Analysis

<h4>1 - Accuracy scores of 3 models</h4>

|No.|Models|Accuracy|
|--------|---------|------|
|1 |Logistic Regression| 0.7865|
|2| Decision Tree       |0.777|
|3 |K-Nearest Neighbors| 0.7411|

<br>

<h4>2 - Discussions based on Accuracy scores</h4>

*    Logistic Regression is a best model compare than others.
*    Then it's accuracy is higher.
*    It takes quick time to anaylize.

<br>

<h4>3 - Strength and Weakness</h4>

|Strength |Weakness|
|------|-----|
|Simple and Fast | Not supported for all |
|Doesn't Overfit| Limited to capturing linear|
|Suitable foe smaller dataset|Not required for Large dataset



"""