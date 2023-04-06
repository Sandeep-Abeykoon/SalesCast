import pandas as pd
import numpy as np
from datetime import datetime

import data_preprocessing as dp
import machine_learning as ml

def get_predictions(product_dataframes, last_rows):

    predictions = []
    count = 0

    for df in product_dataframes:
        model = ml.model_training(df)
        # Getting generated dataframe for the number of pediction days for each product
        prediction_df = nextWeekDataFrame(last_rows[count])
        # Predicting the sales
        prediction = predict_sales(model, prediction_df)
        predictions.append(prediction.tolist())
        count+=1

    return predictions


def nextWeekDataFrame(last_row):
    
    number_of_prediction_days = 7
    # Parse the date string into a datetime object
    today_date = datetime.today().strftime('%Y-%m-%d')
    today_timestamp = pd.Timestamp(today_date)
    # Increment the date by one day
    new_date = today_timestamp + pd.DateOffset(days=1)
    # Create a new dataframe by copying the last record five times
    new_df = pd.concat([last_row] * number_of_prediction_days, ignore_index=True)
    # Dropping the Sold quantity column and Id number columns
    new_df = new_df.drop(['sold_quantity', 'id_number'], axis = 1)
    # Generate a sequence of dates with a frequency of one day
    date_range = pd.date_range(start=new_date, periods=len(new_df), freq='D')
    # Set the new date value for each row
    new_df['date'] = date_range.strftime('%Y-%m-%d')
    # Processing the date columns
    new_df['date'] = pd.to_datetime(new_df['date'])
    df = dp.date_processing(new_df)
    return df


def predict_sales(model, prediction_df):
    df = prediction_df.astype(float)
    prediction = model.predict(df)
    prediction = (np.round(prediction))

    return prediction
