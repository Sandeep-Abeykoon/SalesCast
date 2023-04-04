from flask import Flask, request, jsonify

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
    product_data_frames, last_rows, productIds = dp.data_preprocessing(records)
    sales_predictions = predictions.get_predictions(product_data_frames, last_rows)
    print(productIds)
    print(sales_predictions)
    db.database_add(records)
    return [sales_predictions], 200


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

    db.add_product(user_id, product_name, product_id, product_price, product_brand, product_category)
    return ("The product is added sucessfully")


if __name__ == "__main__":
    app.run(debug=True)
