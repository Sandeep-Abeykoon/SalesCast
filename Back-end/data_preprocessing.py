import pandas as pd


def data_preprocessing(records):

    df = pd.DataFrame(records)


    # Deleting the product column as it is not needed (product_id is enough)
    df.drop('product', axis=1, inplace=True)

    # Deleting the rows with missing values
    df.dropna(axis=0, how='any', inplace=True)

    registered_products = df['id_number'].unique()
    product_dataframes = []
    last_rows = []
    productIds = []

    # Creating Dataframes for each product seperately
    for id in registered_products:
        product_df = df[df['id_number'] == id]
        # processing each dataframe individually

        # Checking if the registered product is included in the data or not
        # Also checks whether atleast more than 1 record is there for a product
        if ((len(product_df)) < 2):
            continue

        # Appending the record available products
        productIds.append(product_df.iloc[0, 0])

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

    return product_dataframes, last_rows, productIds


def date_processing(df):
    df['day_of_week'] = df['date'].dt.dayofweek
    df['quarter'] = df['date'].dt.quarter
    df['month'] = df['date'].dt.month
    df['year'] = df['date'].dt.year
    df['day_of_year'] = df['date'].dt.dayofyear
    df['day_of_month'] = df['date'].dt.day
    df['week_of_year'] = df['date'].dt.isocalendar().week

    df = df.drop(['date'], axis = 1)

    # Finding the Minimum year and considering that as the initial year
    min_year = df['year'].min()
    df['year'] = df['year'].apply(lambda x : ((x - min_year) + 1) if x != min_year else 1)

    return df

def price_processing(df):
    df['price'] = df['price'].str.replace('[\$,€]', '', regex=True).str.replace(',', '', regex=False)

    return df

    
    



    

        

    