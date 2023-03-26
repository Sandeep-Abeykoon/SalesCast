import pymongo
import ssl


def database_add(records):
    first = records[0]
    print(first)
    client = pymongo.MongoClient(
        'mongodb+srv://admin:admin123@cluster0.xtwmxll.mongodb.net/?retryWrites=true&w=majority',
        ssl=True, ssl_cert_reqs=ssl.CERT_NONE)
    if client:
        print("connected successfully to database")
        db = client["salesdemo"]
        collection = db["products"]
        collection.insert_one(first)
        print("added successfully")
    else:
        print("failed to connect to database")
    client.close()