import pandas as pd

def data_preprocessing(records):
    registered_products = ['9', '2']

    main_df = pd.DataFrame(records)

    # filtering only the required data rows (Only for registered products)
    filtered_df = main_df[main_df['id_number'].isin(registered_products)]
    main_df = filtered_df
    # Deleting the product column as it is not needed (product_id is enough)
    main_df.drop('product', axis=1, inplace=True)

    # Deleting the rows with missing values
    main_df.dropna(axis=0, how='any', inplace=True)

    product_dataframes = []
    last_rows = []

    # Creating Dataframes for the registered products only
    for id in registered_products:
        product_df = main_df[main_df['id_number'] == id]
        # processing each dataframe individually

        # Sorting the data according to the date
        product_df['date'] = pd.to_datetime(product_df['date'])
        product_df = product_df.sort_values('date')

        last_rows.append(product_df.tail(1))
        
        # Date Processing
        product_df = date_processing(product_df)
        product_df = price_processing(product_df)

        # Converting all the values to float values
        product_df = product_df.astype(float)

        # Removing the Id number 
        product_df = product_df.drop(['id_number'], axis = 1)

        # Appending the frames to a list
        product_dataframes.append(product_df)

    return product_dataframes, last_rows


def date_processing(df):
    df['day_of_week'] = df['date'].dt.dayofweek
    df['quarter'] = df['date'].dt.quarter
    df['month'] = df['date'].dt.month
    df['year'] = df['date'].dt.year
    df['day_of_year'] = df['date'].dt.dayofyear
    df['day_of_month'] = df['date'].dt.day
    df['week_of_year'] = df['date'].dt.weekofyear

    df = df.drop(['date'], axis = 1)

    # Finding the Minimum year and considering that as the initial year
    min_year = df['year'].min()
    df['year'] = df['year'].apply(lambda x : ((x - min_year) + 1) if x != min_year else 1)

    return df

def price_processing(df):
    df['price'] = df['price'].str.replace('[\$,€]', '', regex=True).str.replace(',', '', regex=False)

    return df

    
    



    

        

    