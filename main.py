from flask import Flask, request, jsonify

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


@app.route('/product_availability', methods=['POST'])
def check_availability():
    user_id = request.form.get('user_id')
    product_id = request.form.get('product_id')
    print(user_id, product_id)
    

    is_available = False
    is_available = False
    is_available = db.product_available(user_id,product_id,is_available)
    print(is_available)
    return jsonify({'is_available': is_available})

@app.route('/register_product', methods=['POST'])
def register_product(): 
    user_id = request.form.get('user_id')
    product_brand = request.form.get('product_brand')
    product_name = request.form.get('product_name')
    product_price = request.form.get('product_price')
    product_category = request.form.get('product_category')
    product_id = request.form.get('product_id')
    db.add_product(user_id,product_name,product_id,product_price,product_brand,product_category)
    return("hello world")
   
if __name__ == "__main__":
    app.run(debug=True)



