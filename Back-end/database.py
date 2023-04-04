import pymongo
import ssl


def database_add(records):
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    if client:
        print("connected successfully to database")
        db = client["SalesCast"]
        collection = db["Product"]
        for x in records:
            new_dict = {"user_id": "MqoldQlyAHb9I3zWGQZGnNbH6qX2"}
            new_dict.update(x)
            result = collection.find_one({"user_id": "MqoldQlyAHb9I3zWGQZGnNbH6qX2", "id_number": new_dict['id_number'], "product": new_dict['product'], "sold_quantity": new_dict['sold_quantity'], "price": new_dict['price'], "date": new_dict['date']})
            if result is None:
                collection.insert_one(new_dict)
                print("added")
            else:
                print("already exists")
            # print(new_dict)
        # print("added successfully")
    else:
        print("failed to connect to database")
    client.close()


def product_available(user_id, product_id):
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    db = client["SalesCast"]
    collection = db["Sales_record"]
    result = collection.find_one({"user_id": user_id, "product_iD": product_id})
    print("result : ", result)

    if result is None:
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
    post = {"user_id": user_id, "product_name": product_name, "product_iD": product_id, "product_price": product_price,
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
    document = collection.find({"user_id": user_id}, projection)
    matching_docs = []
    for x in document:
        # print(x)
        matching_docs.append(x)
    return matching_docs
