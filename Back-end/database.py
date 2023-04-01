import pymongo
import ssl


def database_add(records):
    first = records[0]
    print(first)
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True)
    if client:
        print("connected successfully to database")
        db = client["SalesCast"]
        collection = db["Product"]
        collection.insert_one(first)
        print("added successfully")
    else:
        print("failed to connect to database")
    client.close()


def product_available(user_id, product_id):
    is_available = False
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    db = client["SalesCast"]
    collection = db["Sales_record"]
    result = collection.find_one({"user_id": user_id, "product_id": product_id})
    print("result : ", result)

    if result == None:
        is_available = False
    else:
        is_available = True
    return is_available


def add_product(user_id, product_name, product_id, product_price, product_brand, product_category):
    print("inside db")
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    db = client["SalesCast"]
    collection = db["Sales_record"]
    post = {"user_id": user_id, "product_name": product_name, "product_id": product_id, "product_price": product_price,
            "product_category": product_category, "product_brand": product_brand}
    collection.insert_one(post)
    print("added succesfully")


def load_product(user_id):
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    db = client["SalesCast"]
    collection = db["Sales_record"]
    projection = {"_id": 0, "user_id": 0}
    document = collection.find({"user_id": user_id},projection)
    matching_docs = []
    for x in document:
        matching_docs.append(x)
    return matching_docs
