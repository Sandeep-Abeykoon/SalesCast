from flask import Flask, request

#Importing Local Modules
import csv_processesing as cp
import data_preprocessing as dp
import predictions
import web_scraping as ws
import database as db

app = Flask(__name__)


@app.route('/')
def index():
    ws.getDemandProducts()
    return "Hello World!"


@app.route('/upload_csv_contents', methods=['POST'])
def upload_csv():
    # Getting the data from the request
    csv_data = request.form['csv_contents']

    # Processing the CSV data structure
    records = cp.csv_data_processing(csv_data)

    # Preprocesing the data and getting the datarames for each product
    product_data_frames, last_rows, productIds = dp.data_preprocessing(records)

    # Training the model for each product and getting the sales prediction
    sales_predictions = predictions.get_predictions(product_data_frames, last_rows)

    print(productIds)
    print (sales_predictions)

    db.database_add(records)
    # Getting the Trending product brands


    return [sales_predictions], 200

   
if __name__ == "__main__":
    app.run(debug=True)



