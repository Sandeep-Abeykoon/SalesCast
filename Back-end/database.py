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
    result = collection.find_one({"user_id": user_id, "product_iD": product_id})
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
    sorted_product_ids = sorted(set(product_ids), key=int)

    print(sorted_product_ids)

    # create an empty list to store the matching documents
    matching_docs = []

    # find all documents with user_id and matching product IDs
    for product_id in sorted_product_ids:
        for doc in collection2.find({'user_id': user_id, 'id_number': product_id}, {'_id': 0, 'user_id': 0}):
            matching_docs.append(doc)
            print(doc)

    print(matching_docs)
