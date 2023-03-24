from sklearn.model_selection import train_test_split
import  xgboost as xgb



def model_training(df):
    # Converting all the values to float

    x = df.drop('sold_quantity', axis = 1)
    x.to_csv('data.csv', index=False)
    y = df['sold_quantity']

    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size= 0.1, shuffle=False)

    model = xgb.XGBRegressor(objective='reg:squarederror', n_estimators = 1000)
    model.fit(x_train, y_train, verbose=False)


    return model



        



        



    

    

 









    