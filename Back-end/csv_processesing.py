def csv_data_processing(csv_data):
    splitted_string = csv_data.splitlines()
    
    records_list = []

    for record in splitted_string:
        record_list = [record[:-1]]
        records_list.append(record_list)
    
    columns = records_list[0][0].split(',')

    records = []

    for record in records_list[1:]:
        for string in record:
            values = string.strip().split(',')

            dict_records = {
                'id_number' : values[0] if values[0] != '' else None,
                'product' : values[1] if values[1] != '' else None,
                'sold_quantity': (values[2]) if values[2] != '' else None,
                'price' : (values[3]) if values[3] != '' else None,
                'date' : values[4] if values[4] != '' else None
            }

            records.append(dict_records)
    return records
    
