from flask import Flask, request



#Importing Local Modules
import csv_processesing as cp
import data_preprocessing as dp

app = Flask(__name__)


@app.route('/')
def index():
    return "Hello World!"


@app.route('/upload_csv_contents', methods=['POST'])
def upload_csv():
    # Getting the data from the request
    csv_data = request.form['csv_contents']

    # Processing the CSV data
    records = cp.csv_data_processing(csv_data)

    # Preprocesing the data
    dp.data_preprocessing(records)



    
    return "CSV data receied and processed", 200

   
if __name__ == "__main__":
    app.run(debug=True)



