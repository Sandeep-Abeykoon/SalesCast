from flask import Flask, request, jsonify
import threading

# Importing Local Modules
import csv_processesing as cp
import data_preprocessing as dp
import predictions
import web_scraping as ws
import database as db

app = Flask(__name__)


@app.route('/')
def index():
    # ws.getDemandProducts()
    return "Testing!"


@app.route('/load_products', methods=['POST'])
def load_products():
    user_id = request.form['user_id']
    print("The user Id is : ", user_id)
    products = db.load_product(user_id)
    return jsonify(products)


@app.route('/upload_csv_contents', methods=['POST'])
def upload_csv():
    user_id = request.form['user_id']
    csv_data = request.form['csv_contents']
    records = cp.csv_data_processing(csv_data)
    db.database_add(records, user_id)

    forecasting_thread = threading.Thread(target=runForecasting(user_id))
    forecasting_thread.start()
    return "Data uploaded succesfully"

@app.route('/product_availability', methods=['POST'])
def check_availability():
    user_id = request.form.get('user_id')
    product_id = request.form.get('product_id')
    print(user_id, product_id)
    is_available = db.product_available(user_id, product_id)
    print(is_available)
    return jsonify({'is_available': is_available})


@app.route('/register_product', methods=['POST'])
def register_product():
    user_id = request.form.get("user_id")
    product_name = request.form.get("product_name")
    product_id = request.form.get("product_id")
    product_price = request.form.get("product_price")
    product_brand = request.form.get("product_brand")
    product_category = request.form.get("product_category")
    product_image_url = request.form.get("product_image_url")
    print(product_image_url)

    db.add_product(user_id, product_name, product_id, product_price, product_brand, product_category, product_image_url)
    return ("The product is added sucessfully")


@app.route('/getLastTwoRecords', methods=['POST'])
def getLastTwoRecords():
    user_id = request.form.get("user_id")
    records = db.last_two_records(user_id)
    return jsonify(records)


@app.route('/getSalesRecords', methods=['POST'])
def getSalesRecords():
    user_id = request.form.get("user_id")
    records = db.return_all_records(user_id)
    return jsonify(records)


#-----------------------------------------------
def runForecasting(user_id):
    user_sales_records = db.machine_learning_load(user_id)

    product_data_frames, last_rows, productIds = dp.data_preprocessing(user_sales_records)
    sales_predictions = predictions.get_predictions(product_data_frames, last_rows)

    print(productIds)
    print(sales_predictions)

    db.saleforecast_store(user_id,productIds,sales_predictions)
    
    

if __name__ == "__main__":
    app.run(debug=True)