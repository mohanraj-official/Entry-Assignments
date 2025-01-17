# -*- coding: utf-8 -*-
"""3 - Linear Regression.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1650rcCawR_4lBCdJMf0UDqPdqYSNUkz5

# Machine Learning Model Building Steps

## 1 - Explore the Dataset

### 1.1 - Understand the Data
"""

# load the dataset
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.read_csv("https://raw.githubusercontent.com/ArchanaInsights/Datasets/main/mobile_price.csv")
print(df.head())

df.info()

df.describe().round(2)

"""### 1.2 - Examine Statistical Summary"""

# Examine Statistical Summary
num_cols = df.select_dtypes(include = "number").columns[1:]

for i in num_cols:
  print(f"Summary Statistics for - '{i}'")
  print(f"Mean \t : {df[i].mean().round(4)}")
  print(f"Median \t : {df[i].median()}")
  print(f"Mode \t : {df[i].mode().values[0]}")
  print(f"Std \t : {df[i].std()}")
  print(f"Min \t : {df[i].min()}")
  print(f"Max \t : {df[i].max()} \n")

"""### 1.3 - Correlation Analysis"""

# Correlation Analysis
plt.figure(figsize = (12, 5))
sns.heatmap(df.corr().round(2), annot = True)
plt.show()

# correlation anlaysis with target
correlation = df.corr()
with_target = correlation["Price"].sort_values(ascending = False)
print(with_target[1: 5])

"""### 1.4 - Relationship Analysis"""

# Relationship Analysis
top_features = ["ram", "ppi", "internal mem", "RearCam"]
fig, axes = plt.subplots(figsize = (12, 3), ncols = 4)

for i, col in enumerate(top_features):
  sns.scatterplot(data = df, x = col, y = "Price", ax = axes[i], color = "DarkslateGray")
plt.tight_layout()
plt.show()

"""## 2 - Prepare the Data

### 2.1 - Feature Selection
"""

# Feature Selection
X = df[top_features] # -------- Features
y = df["Price"]        # -------- Target

"""### 2.2 - Split the Dataset"""

# Split the Dataset
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 42)
print(f"Default dataset  : {df.shape}")
print(f"X_train shape \t : {X_train.shape}")
print(f"y_train shape \t : {y_train.shape}")
print(f"X_test shape \t : {X_test.shape}")
print(f"y_test shape \t : {y_test.shape}")

"""## 3 - Build and Train the Model

### 3.1 - Create a Linear Regression Model
"""

# Create a Linear Regression Model
from sklearn.linear_model import LinearRegression
lr = LinearRegression()

"""### 3.2 - Train the Model"""

# Train the Model
lr.fit(X_train, y_train)

"""## 4 - Evaluate the Model

### 4.1 - Predict
"""

# Predict
slope = lr.coef_
intercept = lr.intercept_
print(f"Slope \t- {slope}")
print(f"intercept \t- {intercept}")

y_pred = lr.predict(X_test)

train_result = pd.DataFrame({"Actual" : y_train, "Predicted" : y_pred_train, "error" : y_train - y_pred_train})
train_result.head().round(2)

"""### 4.2 - Metrics Calculation"""

from sklearn.metrics import r2_score, mean_absolute_error, mean_squared_error
print(f"R2_Score \t\t\t - {r2_score(y_test, y_pred)}")
print(f"Mean Absolute Error \t\t - {mean_absolute_error(y_test, y_pred)}")
print(f"Mean Squared Error \t\t - {mean_squared_error(y_test, y_pred)}")
print(f"Root Mean Sqaured Error \t - {mean_squared_error(y_test, y_pred) ** 0.5}")

"""## 5 - Conclude the Analysis

#### 5.1 - Model Evoluation

### Insights and discussion

- R2_Score - $0.85$ it captures most of the variences in mobile price.

- The difference between MAE $ (246.33) $ and RMSE  $(288.91)$ confirms the presence of larger errors in predicions.

- $ Size, Ram, processor Speed $ has high correlation with Price.

- High coefficients are indicates strong influence with price.

- positive coefficient relates direct relationship and negative relates indirect.
"""

