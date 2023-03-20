import numpy as np
import pandas as pd
import  xgboost as xgb
import matplotlib.pyplot as plt
from sklearn.model_selection import GridSearchCV

import seaborn as sns
sns.set_style('whitegrid')
plt.rcParams['figure.figsize'] = (20, 10)
plt.style.use('tableau-colorblind10')

df = pd.read_csv('product_id_processed_and_sorted_csv_file.csv')

corrmat = df.corr()
top_corr_features = corrmat.index
plt.figure(figsize=(20,20))
g = sns.heatmap(df[top_corr_features].corr(),annot=True)

# Data Preprocessing
df['date'] = pd.to_datetime(df['date'])
df['time'] = pd.to_datetime(df['time'], format='%H:%M').dt.time
df['hour'] = pd.to_datetime(df['time'], format = '%H:%M:%S').dt.hour
df['minute'] = pd.to_datetime(df['time'], format = '%H:%M:%S').dt.minute
df['day_of_week'] = df['date'].dt.dayofweek
df['quarter'] = df['date'].dt.quarter
df['month'] = df['date'].dt.month
df['year'] = df['date'].dt.year
df['day_of_year'] = df['date'].dt.dayofyear
df['day_of_month'] = df['date'].dt.day
df['week_of_year'] = df['date'].dt.weekofyear

df = df.drop(['product', 'date', 'time', 'minute'], axis=1)

df = df.drop(['product_id'], axis=1)

df = pd.concat([df, products], axis=1)

df.isnull().sum()

df.isnull().sum()

len(df)

x = df.drop('sold_quantity', axis = 1)
y = df['sold_quantity']

from sklearn.model_selection import train_test_split

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size= 0.1, shuffle=False)

x_train
y_train

x_train.shape, x_test.shape

reg = xgb.XGBRegressor(objective='reg:squarederror', n_estimators = 1000)
reg.fit(x_train, y_train, verbose=False)