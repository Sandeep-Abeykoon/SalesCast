import ssl

import pymongo


def database_add(records, user_id):
    # connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    if client:
        print("Connected successfully to the database.")
        # access the "SalesCast" database and "Product" collection
        db = client["SalesCast"]
        collection = db["Product"]

        # iterate through the records and add them to the collection
        for x in records:
            # add user_id to the record
            new_dict = {"user_id": user_id}
            new_dict.update(x)

            # check if the record already exists in the collection
            result = collection.find_one(
                {"user_id": user_id, "id_number": new_dict['id_number'], "product": new_dict['product'],
                 "sold_quantity": new_dict['sold_quantity'], "price": new_dict['price'], "date": new_dict['date']})

            if result is None:
                # if the record does not exist, insert it into the collection
                collection.insert_one(new_dict)
                print("Record added.")
            else:
                print("Record already exists.")

        # close the connection to the database
        client.close()
    else:
        print("Failed to connect to the database.")


def product_available(user_id, product_id):
    # connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    # access the "SalesCast" database and "Sales_record" collection
    db = client["SalesCast"]
    collection = db["Sales_record"]

    # find a document with matching user_id and product_id
    result = collection.find_one({"user_id": user_id, "product_id": product_id})
    print("result : ", result)

    # if the result is None, the product is not available
    if result is None:
        is_available = False
    # otherwise, the product is available
    else:
        is_available = True
    return is_available


def add_product(user_id, product_name, product_id, product_price, product_brand, product_category, product_image_url):
    # Connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    db = client["SalesCast"]
    collection = db["Sales_record"]

    # Create a dictionary for the new document to be inserted
    post = {
        "user_id": user_id,
        "product_name": product_name,
        "product_id": product_id,
        "product_price": product_price,
        "product_category": product_category,
        "product_brand": product_brand,
        "product_image_url": product_image_url
    }

    # Insert the new document into the collection
    collection.insert_one(post)

    # Print a message to indicate that the product was added successfully
    print("Product added successfully")


def load_product(user_id):
    # Connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    # Access the "SalesCast" database
    db = client["SalesCast"]
    collection = db["Sales_record"]

    # Define the fields to exclude in the results
    projection = {"_id": 0, "user_id": 0}

    # Retrieve all documents with user_id user_id and exclude the specified fields
    document = collection.find({"user_id": user_id}, projection)

    # Create an empty list to store the matching documents
    matching_docs = []

    # Iterate through the documents and append the matching documents to the list
    for x in document:
        matching_docs.append(x)

    # Return the matching documents
    return matching_docs


def machine_learning_load(user_id):
    # connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    # access the "SalesCast" database
    db = client["SalesCast"]
    collection = db["Sales_record"]
    collection2 = db["Product"]

    # create an empty list to store the product IDs
    product_ids = []

    # find all documents with user_id and retrieve only the product_iD field
    docs = collection.find({'user_id': user_id}, {'product_id': 1, '_id': 0})

    # iterate through the documents and append the product_iD to the list
    for doc in docs:
        product_ids.append(doc['product_id'])

    # remove duplicates from the list and sort it in ascending order
    sorted_product_ids = sorted(set(product_ids))

    # create an empty list to store the matching documents
    matching_docs = []

    # find all documents with user_id and matching product IDs
    for product_id in sorted_product_ids:
        for doc in collection2.find({'user_id': user_id, 'id_number': product_id}, {'_id': 0, 'user_id': 0}):
            matching_docs.append(doc)

    return matching_docs


def return_all_records(user_id):
    # connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    arr = []
    # access the "SalesCast" database
    db = client["SalesCast"]
    collection = db["Product"]
    for doc in collection.find({'user_id': user_id}, {'_id': 0, 'user_id': 0}):
        arr.append(doc)
    return arr


def last_two_records(user_id):
    # connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    # access the "SalesCast" database
    db = client["SalesCast"]
    collection = db["Product"]
    count = 1
    arr = []
    for doc in collection.find({'user_id': user_id}, {'_id': 0, 'user_id': 0}):
        if count < 3:
            arr.append(doc)
            count += 1
    return arr


def saleforecast_store(user_id, productIds, sales_predictions):
    # Connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    # Access the "SalesCast" database
    db = client["SalesCast"]

    # Get the collection for sales records and sales forecasts
    collection = db['Sales_record']
    collection2 = db['Sales_forecast']

    count = 0

    # Loop through each product and add its sales forecast
    for x in productIds:
        # Get the product's name from the sales records
        result = collection.find_one({'user_id': user_id, 'product_id': x})
        product_name = result['product_name'] if result is not None and 'product_name' in result else ''

        # Create a new document for the sales forecast if it doesn't exist
        if collection2.find_one({'user_id': user_id, 'product_id': x}) is None:
            post = {
                'user_id': user_id,
                'product_id': x,
                'product_name': product_name,
                'Day 1': sales_predictions[count][0],
                'Day 2': sales_predictions[count][1],
                'Day 3': sales_predictions[count][2],
                'Day 4': sales_predictions[count][3],
                'Day 5': sales_predictions[count][4],
                'Day 6': sales_predictions[count][5],
                'Day 7': sales_predictions[count][6]
            }
            collection2.insert_one(post)
            print(f"Inserted new sales forecast for user_id {user_id}, product_id {x}")
        # Otherwise, update the existing document with the new sales forecast
        else:
            changes = {'$set': {'Day 1': sales_predictions[count][0],
                                'Day 2': sales_predictions[count][1],
                                'Day 3': sales_predictions[count][2],
                                'Day 4': sales_predictions[count][3],
                                'Day 5': sales_predictions[count][4],
                                'Day 6': sales_predictions[count][5],
                                'Day 7': sales_predictions[count][6]}}
            collection2.update_one({'user_id': user_id, 'product_id': x}, changes, upsert=True)
            print(f"Updated sales forecast for user_id {user_id}, product_id {x}")

        count += 1


def return_sales(user_id):
    # Connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    # Access the "SalesCast" database
    db = client["SalesCast"]
    collection = db['Sales_forecast']
    results = collection.find({'user_id': user_id}, {'user_id': 0, '_id': 0, 'product_id': 0})
    data = []
    for result in results:
        data.append(result)
    total = []
    name = []
    for x in data:
        name.append(x['product_name'])
        tot = 0
        tot += x['Day 1']
        tot += x['Day 2']
        tot += x['Day 3']
        tot += x['Day 4']
        tot += x['Day 5']
        tot += x['Day 6']
        tot += x['Day 7']
        total.append(tot)
    
    final = []
    dict = {}

    for i in range(len(name)):
        dict = {'product_name': name[i], 'total': total[i]}
        final.append(dict)
    return final


def forecast_day_sales(user_id,product_id):
    # Connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    # Access the "SalesCast" database
    db = client["SalesCast"]

    collection = db['Sales_forecast']

    result = collection.find_one({'product_id': product_id, 'user_id': user_id}, {'_id': 0, 'product_id': 0, 'user_id': 0, 'product_name': 0})
    return result


def getProductname(user_id, product_id):
    # Connect to MongoDB
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    # Access the "SalesCast" database
    db = client["SalesCast"]
    collection = db['Sales_record']

    result = collection.find_one({"user_id": user_id, "product_id": product_id})
    return result['product_name']

def trending_products_store(user_id, product_id, arr):
    # connect to the MongoDB Atlas cluster
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.qva0hbp.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

    # access the "SalesCast" database
    db = client["SalesCast"]

    # access the "Trending_product" collection
    collection = db["Trending_product"]

    # insert the documents into the collection
    for x in arr:
        document = {'user_id': user_id, 'product_id': product_id, **x}
        collection.insert_one(document)