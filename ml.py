import pandas as pd

# read the CSV file
df = pd.read_csv('output.csv')

# convert the date column to datetime format
df['Date'] = pd.to_datetime(df['date'])

# group the data by date and sum the sales
sales_by_day = df.groupby('date')['sold_quantity', 'sold_price'].sum()

# write the data to a new CSV file
sales_by_day.to_csv('sales_by_day.csv', header=True)


# read the CSV file
df = pd.read_csv('sales_by_day.csv')
df.head()


df['date'] = pd.to_datetime(df['date'])
df['day_of_week'] = df['date'].dt.dayofweek
df['quarter'] = df['date'].dt.quarter
df['month'] = df['date'].dt.month
df['year'] = df['date'].dt.year
df['day_of_year'] = df['date'].dt.dayofyear
df['week_of_year'] = df['date'].dt.weekofyear



from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
df['price_scaled'] = scaler.fit_transform(df[['sold_price']])
df['price_normalized'] = (df['sold_price'] - np.mean(df['sold_price'])) / np.std(df['sold_price'])

# Convert prices to log price
df['log_price'] = np.log(df['sold_price'])

df = df.drop(['date'], axis = 1)

x = df.drop('sold_quantity', axis = 1)
y = df['sold_quantity']


from sklearn.model_selection import train_test_split
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2,shuffle=False)


# Model
import  xgboost as xgb
reg = xgb.XGBRegressor(objective='reg:squarederror', n_estimators = 2000)
reg.fit(x_train, y_train, verbose=False)



import numpy as np
x_test_prediction=np.round(reg.predict(x_test




from sklearn.metrics import mean_squared_error as MSE
rmse = np.sqrt(MSE(y_test, x_test_prediction))
print("RMSE : ", rmse)


from sklearn.metrics import mean_absolute_percentage_error
mape = mean_absolute_percentage_error(y_test, x_test_prediction) * 100
mape


import matplotlib.pyplot as plt
plt.plot(y_test.values, label = 'Original')
plt.plot(x_test_prediction, color = 'green', label = 'XGBoost')
plt.legend()
